drop policy "lifestyle: manage self" on "public"."lifestyle";

revoke delete on table "public"."match_requests" from "anon";

revoke insert on table "public"."match_requests" from "anon";

revoke references on table "public"."match_requests" from "anon";

revoke select on table "public"."match_requests" from "anon";

revoke trigger on table "public"."match_requests" from "anon";

revoke truncate on table "public"."match_requests" from "anon";

revoke update on table "public"."match_requests" from "anon";

revoke delete on table "public"."match_requests" from "authenticated";

revoke insert on table "public"."match_requests" from "authenticated";

revoke references on table "public"."match_requests" from "authenticated";

revoke select on table "public"."match_requests" from "authenticated";

revoke trigger on table "public"."match_requests" from "authenticated";

revoke truncate on table "public"."match_requests" from "authenticated";

revoke update on table "public"."match_requests" from "authenticated";

revoke delete on table "public"."match_requests" from "service_role";

revoke insert on table "public"."match_requests" from "service_role";

revoke references on table "public"."match_requests" from "service_role";

revoke select on table "public"."match_requests" from "service_role";

revoke trigger on table "public"."match_requests" from "service_role";

revoke truncate on table "public"."match_requests" from "service_role";

revoke update on table "public"."match_requests" from "service_role";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.can_see_on_map(me uuid, other uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
  with a as (
    select id, lat, lng, distance_km, discoverable
    from public.profiles where id = me
  ), b as (
    select id, lat, lng, distance_km, discoverable
    from public.profiles where id = other
  )
  select
    a.discoverable
    and b.discoverable
    and a.lat is not null and a.lng is not null
    and b.lat is not null and b.lng is not null
    and (public.haversine_km(a.lat, a.lng, b.lat, b.lng)
         <= least(greatest(a.distance_km,1), greatest(b.distance_km,1)))
  from a, b;
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

create policy "hobbies_master: seed by service_role"
on "public"."hobbies_master"
as permissive
for insert
to service_role
with check (true);


create policy "lifestyle: delete self"
on "public"."lifestyle"
as permissive
for delete
to authenticated
using ((auth.uid() = user_id));


create policy "lifestyle: insert self"
on "public"."lifestyle"
as permissive
for insert
to authenticated
with check ((auth.uid() = user_id));


create policy "lifestyle: read self"
on "public"."lifestyle"
as permissive
for select
to authenticated
using ((auth.uid() = user_id));


create policy "lifestyle: update self"
on "public"."lifestyle"
as permissive
for update
to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));




