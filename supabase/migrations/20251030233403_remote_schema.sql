drop policy "user_photos: manage self" on "public"."user_photos";

drop policy "user_photos: self read" on "public"."user_photos";

drop policy "user_photos: self write" on "public"."user_photos";

drop policy "match_requests: create request" on "public"."match_requests";

drop policy "match_requests: requester cancel" on "public"."match_requests";

drop policy "match_requests: respond" on "public"."match_requests";

create table "public"."blocks" (
    "blocker_id" uuid not null,
    "blocked_id" uuid not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."blocks" enable row level security;

create table "public"."frames" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "photo_url" text not null,
    "caption" text,
    "is_active" boolean not null default true,
    "created_at" timestamp with time zone not null default now(),
    "expires_at" timestamp with time zone not null default (now() + '24:00:00'::interval),
    "archived_at" timestamp with time zone
);


alter table "public"."frames" enable row level security;

--alter table "public"."match_requests" alter column "status" set default 'pending'::match_status_enum;

--alter table "public"."match_requests" alter column "status" set data type match_status_enum using "status"::text::match_status_enum;

--drop type "public"."match_status_enum__old_version_to_be_dropped";

CREATE INDEX blocks_blocked_blocker_idx ON public.blocks USING btree (blocked_id, blocker_id);

CREATE UNIQUE INDEX blocks_pkey ON public.blocks USING btree (blocker_id, blocked_id);

CREATE INDEX frames_created_idx ON public.frames USING btree (created_at);

CREATE UNIQUE INDEX frames_one_active_per_user_idx ON public.frames USING btree (user_id) WHERE (is_active = true);

CREATE UNIQUE INDEX frames_pkey ON public.frames USING btree (id);

CREATE INDEX frames_user_active_exp_idx ON public.frames USING btree (user_id, is_active, expires_at);

alter table "public"."blocks" add constraint "blocks_pkey" PRIMARY KEY using index "blocks_pkey";

alter table "public"."frames" add constraint "frames_pkey" PRIMARY KEY using index "frames_pkey";

alter table "public"."blocks" add constraint "blocks_blocked_id_fkey" FOREIGN KEY (blocked_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."blocks" validate constraint "blocks_blocked_id_fkey";

alter table "public"."blocks" add constraint "blocks_blocker_id_fkey" FOREIGN KEY (blocker_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."blocks" validate constraint "blocks_blocker_id_fkey";

alter table "public"."blocks" add constraint "blocks_no_self" CHECK ((blocker_id <> blocked_id)) not valid;

alter table "public"."blocks" validate constraint "blocks_no_self";

alter table "public"."frames" add constraint "frames_expires_after_create" CHECK ((expires_at > created_at)) not valid;

alter table "public"."frames" validate constraint "frames_expires_after_create";

alter table "public"."frames" add constraint "frames_user_id_fkey" FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."frames" validate constraint "frames_user_id_fkey";

alter table "public"."profiles" add constraint "profiles_frame_id_fkey" FOREIGN KEY (frame_id) REFERENCES frames(id) ON DELETE SET NULL not valid;

alter table "public"."profiles" validate constraint "profiles_frame_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.frames_after_insert_set_pointer()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  UPDATE public.profiles
     SET frame_id = NEW.id
   WHERE id = NEW.user_id;
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.frames_after_update_clear_pointer()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- If it WAS active and now is inactive OR has passed its expiry,
  -- clear profiles.frame_id (only if it still points to this frame)
  IF OLD.is_active = true
     AND (NEW.is_active = false OR NEW.expires_at <= now()) THEN
    UPDATE public.profiles
       SET frame_id = NULL
     WHERE id = NEW.user_id AND frame_id = NEW.id;
  END IF;

  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.frames_before_insert_rotate()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Deactivate any current active frame for this user
  UPDATE public.frames
     SET is_active = false,
         archived_at = now()
   WHERE user_id = NEW.user_id
     AND is_active = true;

  -- Ensure default expiry if not provided
  IF NEW.expires_at IS NULL THEN
    NEW.expires_at := now() + interval '24 hours';
  END IF;

  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.can_see_on_map(me uuid, other uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
SELECT COALESCE((
  WITH a AS (
    SELECT id, lat, lng, distance_km, distance_meters, discoverable
    FROM public.profiles WHERE id = me
  ),
  b AS (
    SELECT id, lat, lng, distance_km, distance_meters, discoverable
    FROM public.profiles WHERE id = other
  )
  SELECT
    a.discoverable
    AND b.discoverable
    AND a.lat IS NOT NULL AND a.lng IS NOT NULL
    AND b.lat IS NOT NULL AND b.lng IS NOT NULL
    AND (
      public.haversine_km(a.lat, a.lng, b.lat, b.lng) * 1000.0
      <= LEAST(
           COALESCE(a.distance_meters, a.distance_km * 1000),
           COALESCE(b.distance_meters, b.distance_km * 1000)
         )
    )
  FROM a, b
), false);
$function$
;

CREATE OR REPLACE FUNCTION public.can_view_full(me uuid, other uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
SELECT
  EXISTS (
    SELECT 1
    FROM public.match_requests mr
    WHERE (
      (mr.requester_id = me AND mr.target_id = other)
      OR
      (mr.requester_id = other AND mr.target_id = me)
    )
    AND mr.status = 'accepted'::public.match_status_enum
  )
  AND NOT public.have_blocked_each_other(me, other);
$function$
;

CREATE OR REPLACE FUNCTION public.can_view_preview(me uuid, other uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
SELECT
  public.can_see_on_map(me, other)
  AND NOT public.have_blocked_each_other(me, other);
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
end;
$function$
;

CREATE OR REPLACE FUNCTION public.get_profile_full_for_user(target_user uuid)
 RETURNS TABLE(id uuid, full_name text, age integer, gender text, gender_subtype text, show_gender_on_profile boolean, sexual_orientation text, show_orientation_on_profile boolean, orientation_custom text, brings_you text, interested_in text[], age_pref_min integer, age_pref_max integer, height_cm integer, education text, institution text, bio text, prompt_answers jsonb, today_frame uuid, main_photo_url text, last_seen timestamp with time zone, discoverable boolean, onboarding_completed boolean, created_at timestamp with time zone, updated_at timestamp with time zone)
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog', 'auth'
AS $function$
DECLARE
    caller uuid := auth.uid();
BEGIN
    IF caller IS NULL THEN
       RAISE EXCEPTION 'not authenticated';
    END IF;

    -- if I'm not them, I must be in accepted match with them
    IF caller <> target_user AND NOT public.can_view_full(caller, target_user) THEN
       RAISE EXCEPTION 'not authorized to view full profile';
    END IF;

    RETURN QUERY
    SELECT
      p.id,
      p.full_name,
      p.age,
      p.gender,
      p.gender_subtype,
      p.show_gender_on_profile,
      p.sexual_orientation::text,
      p.show_orientation_on_profile,
      p.orientation_custom,
      p.brings_you::text,
      p.interested_in::text[],
      p.age_pref_min,
      p.age_pref_max,
      p.height_cm,
      p.education,
      p.institution,
      p.prompt AS bio,
      p.prompt_answers,
      p.frame_id AS today_frame,
      (
        SELECT up.photo_url
        FROM public.user_photos up
        WHERE up.user_id = p.id
          AND up.is_main = true
        ORDER BY up.id
        LIMIT 1
      ) AS main_photo_url,
      p.last_seen,
      p.discoverable,
      p.onboarding_completed,
      p.created_at,
      p.updated_at
    FROM public.profiles p
    WHERE p.id = target_user;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_profile_preview_for_user(target_user uuid)
 RETURNS TABLE(user_id uuid, age integer, bio text, today_frame uuid, frame_prompt text, main_photo_url text)
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog', 'auth'
AS $function$
DECLARE
    caller uuid := auth.uid();
BEGIN
    IF caller IS NULL THEN
       RAISE EXCEPTION 'not authenticated';
    END IF;

    RETURN QUERY
    SELECT
      p.id AS user_id,
      p.age,
      p.prompt AS bio,
      p.frame_id AS today_frame,
      NULL::text AS frame_prompt, -- placeholder until you add frame_prompt table/column
      (
        SELECT up.photo_url
        FROM public.user_photos up
        WHERE up.user_id = p.id
          AND up.is_main = true
        ORDER BY up.id
        LIMIT 1
      ) AS main_photo_url
    FROM public.profiles p
    WHERE p.id = target_user
      AND public.can_view_preview(caller, p.id);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_lifestyle_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.have_blocked_each_other(me uuid, other uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  SELECT
    -- Explicit hard blocks (either direction)
    EXISTS (
      SELECT 1
      FROM public.blocks b
      WHERE (b.blocker_id = me   AND b.blocked_id = other)
         OR (b.blocker_id = other AND b.blocked_id = me)
    )
    OR
    -- Legacy compatibility: 'rejected' in match_requests acts like a block
    EXISTS (
      SELECT 1
      FROM public.match_requests mr
      WHERE (
        (mr.requester_id = me   AND mr.target_id = other)
        OR
        (mr.requester_id = other AND mr.target_id = me)
      )
      AND mr.status = 'rejected'::public.match_status_enum
    );
$function$
;

CREATE OR REPLACE FUNCTION public.haversine_km(lat1 numeric, lon1 numeric, lat2 numeric, lon2 numeric)
 RETURNS numeric
 LANGUAGE sql
 IMMUTABLE
AS $function$
  select 2 * 6371 * asin(
    sqrt(
      power(sin(radians($3 - $1)/2), 2) +
      cos(radians($1)) * cos(radians($3)) * power(sin(radians($4 - $2)/2), 2)
    )
  );
$function$
;

create policy "blocks: delete self"
on "public"."blocks"
as permissive
for delete
to authenticated
using ((blocker_id = auth.uid()));


create policy "blocks: insert self"
on "public"."blocks"
as permissive
for insert
to authenticated
with check ((blocker_id = auth.uid()));


create policy "blocks: select self-related"
on "public"."blocks"
as permissive
for select
to authenticated
using (((blocker_id = auth.uid()) OR (blocked_id = auth.uid())));


create policy "frames: delete own"
on "public"."frames"
as permissive
for delete
to authenticated
using ((user_id = auth.uid()));


create policy "frames: insert own"
on "public"."frames"
as permissive
for insert
to authenticated
with check ((user_id = auth.uid()));


create policy "frames: select current via preview"
on "public"."frames"
as permissive
for select
to authenticated
using (((is_active = true) AND (now() < expires_at) AND can_view_preview(auth.uid(), user_id)));


create policy "frames: select history via full"
on "public"."frames"
as permissive
for select
to authenticated
using ((((is_active = false) OR (now() >= expires_at)) AND can_view_full(auth.uid(), user_id)));


create policy "frames: select own"
on "public"."frames"
as permissive
for select
to authenticated
using ((user_id = auth.uid()));


create policy "frames: update own"
on "public"."frames"
as permissive
for update
to authenticated
using ((user_id = auth.uid()))
with check ((user_id = auth.uid()));


create policy "match_requests: create request"
on "public"."match_requests"
as permissive
for insert
to authenticated
with check (((requester_id = auth.uid()) AND (requester_id <> target_id) AND (status::text = 'pending')));


create policy "match_requests: requester cancel"
on "public"."match_requests"
as permissive
for delete
to authenticated
using (
  (auth.uid() = requester_id)
  AND (status::text = 'pending')
);

create policy "match_requests: respond"
on "public"."match_requests"
as permissive
for update
to authenticated
using (
  (target_id = auth.uid())
  AND (status::text = 'pending')
)
with check (
  (target_id = auth.uid())
  AND (status::text = ANY (ARRAY['accepted','denied','rejected']))
);



CREATE TRIGGER trg_frames_after_insert_set_pointer AFTER INSERT ON public.frames FOR EACH ROW EXECUTE FUNCTION frames_after_insert_set_pointer();

CREATE TRIGGER trg_frames_after_update_clear_pointer AFTER UPDATE ON public.frames FOR EACH ROW EXECUTE FUNCTION frames_after_update_clear_pointer();

CREATE TRIGGER trg_frames_before_insert_rotate BEFORE INSERT ON public.frames FOR EACH ROW EXECUTE FUNCTION frames_before_insert_rotate();


drop policy "user_photos public read" on "storage"."objects";


  create policy "user_photos: delete own folder"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'user_photos'::text) AND (auth.uid() = ((storage.foldername(name))[1])::uuid)));



  create policy "user_photos: insert own folder"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'user_photos'::text) AND (auth.uid() = ((storage.foldername(name))[1])::uuid)));



  create policy "user_photos: select own folder"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using (((bucket_id = 'user_photos'::text) AND (auth.uid() = ((storage.foldername(name))[1])::uuid)));



  create policy "user_photos: update own folder"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using (((bucket_id = 'user_photos'::text) AND (auth.uid() = ((storage.foldername(name))[1])::uuid)))
with check (((bucket_id = 'user_photos'::text) AND (auth.uid() = ((storage.foldername(name))[1])::uuid)));



