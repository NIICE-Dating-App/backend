create type "public"."match_status_enum" as enum ('pending', 'accepted', 'denied');

drop policy "Users can see and edit their own row" on "public"."profiles";

drop policy "user_modes: manage self" on "public"."user_modes";

drop policy "user_modes: read others" on "public"."user_modes";

create table "public"."match_requests" (
    "id" uuid not null default gen_random_uuid(),
    "requester_id" uuid not null,
    "target_id" uuid not null,
    "status" match_status_enum not null default 'pending'::match_status_enum,
    "created_at" timestamp with time zone not null default now(),
    "responded_at" timestamp with time zone
);


alter table "public"."match_requests" enable row level security;

alter table "public"."hobbies_master" enable row level security;

alter table "public"."profiles" add column "discoverable" boolean not null default true;

alter table "public"."profiles" add column "frame_id" uuid;

alter table "public"."profiles" add column "last_seen" timestamp with time zone default now();

alter table "public"."profiles" add column "lat" numeric(9,6);

alter table "public"."profiles" add column "lng" numeric(9,6);

CREATE INDEX idx_profiles_lat_lng ON public.profiles USING btree (lat, lng);

CREATE INDEX idx_user_modes_user_id_updated_at ON public.user_modes USING btree (user_id, updated_at DESC);

CREATE INDEX idx_user_photos_user_id_is_main ON public.user_photos USING btree (user_id, is_main);

CREATE UNIQUE INDEX match_requests_pkey ON public.match_requests USING btree (id);

CREATE UNIQUE INDEX ux_match_requests_pair ON public.match_requests USING btree (LEAST(requester_id, target_id), GREATEST(requester_id, target_id));

alter table "public"."match_requests" add constraint "match_requests_pkey" PRIMARY KEY using index "match_requests_pkey";

alter table "public"."match_requests" add constraint "match_requests_requester_id_fkey" FOREIGN KEY (requester_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."match_requests" validate constraint "match_requests_requester_id_fkey";

alter table "public"."match_requests" add constraint "match_requests_target_id_fkey" FOREIGN KEY (target_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."match_requests" validate constraint "match_requests_target_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.can_see_on_map(me uuid, other uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
  WITH a AS (
    SELECT id, lat, lng, distance_km, discoverable
    FROM public.profiles WHERE id = me
  ), b AS (
    SELECT id, lat, lng, distance_km, discoverable
    FROM public.profiles WHERE id = other
  )
  SELECT
    a.discoverable
    AND b.discoverable
    AND a.lat IS NOT NULL AND a.lng IS NOT NULL
    AND b.lat IS NOT NULL AND b.lng IS NOT NULL
    AND (
      public.haversine_km(a.lat, a.lng, b.lat, b.lng)
      <= LEAST(GREATEST(a.distance_km,1), GREATEST(b.distance_km,1))
    )
  FROM a, b;
$function$
;

CREATE OR REPLACE FUNCTION public.haversine_km(lat1 numeric, lon1 numeric, lat2 numeric, lon2 numeric)
 RETURNS numeric
 LANGUAGE sql
 IMMUTABLE
AS $function$
  SELECT 2 * 6371 * asin(
    sqrt(
      power(sin(radians($3 - $1)/2), 2) +
      cos(radians($1)) * cos(radians($3)) * power(sin(radians($4 - $2)/2), 2)
    )
  );
$function$
;

CREATE OR REPLACE FUNCTION public.check_user_exists(user_email text)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
BEGIN
  RETURN EXISTS (
    SELECT 1 
    FROM auth.users 
    WHERE email = user_email
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.current_user_id()
 RETURNS uuid
 LANGUAGE plpgsql
 STABLE
 SET search_path TO 'public', 'pg_temp'
AS $function$
BEGIN
  RETURN current_setting('request.jwt.claim.sub', true)::uuid;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.enforce_hobby_count()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pg_catalog'
AS $function$
DECLARE
  cnt int;
BEGIN
  -- Determine correct user id whether inserting or deleting
  PERFORM 1;
  SELECT COUNT(*) INTO cnt
  FROM user_hobbies
  WHERE user_id = COALESCE(NEW.user_id, OLD.user_id);

  -- Skip enforcement if count = 0 (meaning full reset, will reinsert soon)
  IF cnt = 0 THEN
    RETURN COALESCE(NEW, OLD);
  END IF;

  -- Only enforce when final count < 4 or > 10
  IF cnt < 4 OR cnt > 10 THEN
    RAISE EXCEPTION 'User must have between 4 and 10 hobbies';
  END IF;

  RETURN COALESCE(NEW, OLD);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.enforce_hobby_count_stmt()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pg_catalog'
AS $function$
DECLARE
  uid uuid;
  affected_users uuid[];
BEGIN
  IF TG_OP = 'DELETE' THEN
    affected_users := ARRAY[OLD.user_id];
  ELSIF TG_OP IN ('INSERT', 'UPDATE') THEN
    affected_users := ARRAY[NEW.user_id];
  END IF;

  FOREACH uid IN ARRAY affected_users LOOP
    IF uid IS NULL THEN
      CONTINUE; -- ignore null user_id
    END IF;

    -- get current hobby count
    PERFORM 1;
    IF (SELECT COUNT(*) FROM public.user_hobbies WHERE user_id = uid) = 0 THEN
      CONTINUE; -- skip check during reset
    END IF;

    IF (SELECT COUNT(*) FROM public.user_hobbies WHERE user_id = uid) NOT BETWEEN 4 AND 10 THEN
      RAISE EXCEPTION 'User % must have between 4 and 10 hobbies', uid;
    END IF;
  END LOOP;

  RETURN NULL;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.enforce_photo_max_4()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pg_catalog'
AS $function$
declare cnt int;
begin
  select count(*) into cnt from public.user_photos where user_id = new.user_id;
  if cnt >= 4 then
    raise exception 'A user can have at most 4 photos';
  end if;
  return new;
end; $function$
;

CREATE OR REPLACE FUNCTION public.handle_lifestyle_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pg_catalog'
AS $function$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
BEGIN
  INSERT INTO public.user_info ("UID", created_at)
  VALUES (NEW.id, NOW());
  RETURN NEW;
END;
$function$
;

create policy "hobbies_master: read"
on "public"."hobbies_master"
as permissive
for select
to public
using (true);


create policy "match_requests: read mine"
on "public"."match_requests"
as permissive
for select
to authenticated
using (((auth.uid() = requester_id) OR (auth.uid() = target_id)));


create policy "match_requests: create request"
on "public"."match_requests"
as permissive
for insert
to authenticated
with check (
  (requester_id = auth.uid())
  AND (requester_id <> target_id)
  AND (status::text = 'pending')
);



create policy "match_requests: requester insert"
on "public"."match_requests"
as permissive
for insert
to authenticated
with check (((auth.uid() = requester_id) AND (requester_id <> target_id)));


create policy "match_requests: target respond"
on "public"."match_requests"
as permissive
for update
to authenticated
using ((auth.uid() = target_id))
with check ((auth.uid() = target_id));


create policy "profiles: insert self"
on "public"."profiles"
as permissive
for insert
to authenticated
with check ((auth.uid() = id));


create policy "profiles: read self"
on "public"."profiles"
as permissive
for select
to authenticated
using ((auth.uid() = id));


create policy "profiles: update self"
on "public"."profiles"
as permissive
for update
to authenticated
using ((auth.uid() = id))
with check ((auth.uid() = id));


create policy "user_hobbies: delete self"
on "public"."user_hobbies"
as permissive
for delete
to authenticated
using ((auth.uid() = user_id));


create policy "user_hobbies: insert self"
on "public"."user_hobbies"
as permissive
for insert
to authenticated
with check ((auth.uid() = user_id));


create policy "user_hobbies: read self"
on "public"."user_hobbies"
as permissive
for select
to authenticated
using ((auth.uid() = user_id));


create policy "user_hobbies: update self"
on "public"."user_hobbies"
as permissive
for update
to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));


create policy "user_modes: delete self"
on "public"."user_modes"
as permissive
for delete
to authenticated
using ((auth.uid() = user_id));


create policy "user_modes: insert self"
on "public"."user_modes"
as permissive
for insert
to authenticated
with check ((auth.uid() = user_id));


create policy "user_modes: read self"
on "public"."user_modes"
as permissive
for select
to authenticated
using ((auth.uid() = user_id));


create policy "user_modes: update self"
on "public"."user_modes"
as permissive
for update
to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));


create policy "user_photos: delete self"
on "public"."user_photos"
as permissive
for delete
to authenticated
using ((auth.uid() = user_id));


create policy "user_photos: insert self"
on "public"."user_photos"
as permissive
for insert
to authenticated
with check ((auth.uid() = user_id));


create policy "user_photos: read self"
on "public"."user_photos"
as permissive
for select
to authenticated
using ((auth.uid() = user_id));


create policy "user_photos: update self"
on "public"."user_photos"
as permissive
for update
to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));




