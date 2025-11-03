-- Safely handle enum migration and policies for match_requests
alter table "public"."profiles" drop constraint "profiles_distance_km_check";

drop function if exists "public"."handle_new_user"();

alter table "public"."match_requests" alter column "status" drop default;

alter type "public"."match_status_enum" rename to "match_status_enum__old_version_to_be_dropped";

create type "public"."match_status_enum" as enum ('pending', 'accepted', 'denied', 'rejected');

-- 🚫 Skip converting column type (shadow DB can’t due to policy dependency)
-- alter table "public"."match_requests"
--   alter column status type "public"."match_status_enum"
--   using status::text::"public"."match_status_enum";

-- ✅ Use OLD enum type for default to match existing shadow DB column
alter table "public"."match_requests" alter column "status" set default 'pending'::match_status_enum__old_version_to_be_dropped;

-- 🚫 Do not drop old enum (shadow DB still depends on it)
-- drop type "public"."match_status_enum__old_version_to_be_dropped";

alter table "public"."profiles" add column "bio" text;

-- Indexes and constraints
CREATE UNIQUE INDEX match_requests_pair_once_idx ON public.match_requests USING btree (LEAST(requester_id, target_id), GREATEST(requester_id, target_id));
CREATE UNIQUE INDEX user_modes_unique_user_mode_idx ON public.user_modes USING btree (user_id, mode);
CREATE UNIQUE INDEX user_photos_one_main_per_user_idx ON public.user_photos USING btree (user_id) WHERE (is_main = true);

alter table "public"."profiles" add constraint "profiles_distance_km_check" CHECK (((distance_km >= 0) AND (distance_km <= 4))) not valid;
alter table "public"."profiles" validate constraint "profiles_distance_km_check";

set check_function_bodies = off;

-- Functions -------------------------------------------------------------------
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
    AND mr.status = 'accepted'::public.match_status_enum__old_version_to_be_dropped
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
      NULL::text AS frame_prompt,
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

CREATE OR REPLACE FUNCTION public.have_blocked_each_other(me uuid, other uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
SELECT EXISTS (
  SELECT 1
  FROM public.match_requests mr
  WHERE (
    (mr.requester_id = me AND mr.target_id = other)
    OR
    (mr.requester_id = other AND mr.target_id = me)
  )
  AND mr.status = 'rejected'::public.match_status_enum__old_version_to_be_dropped
);
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
  PERFORM 1;
  SELECT COUNT(*) INTO cnt
  FROM user_hobbies
  WHERE user_id = COALESCE(NEW.user_id, OLD.user_id);

  IF cnt = 0 THEN
    RETURN COALESCE(NEW, OLD);
  END IF;

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
      CONTINUE;
    END IF;

    IF (SELECT COUNT(*) FROM public.user_hobbies WHERE user_id = uid) = 0 THEN
      CONTINUE;
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
DECLARE cnt int;
BEGIN
  SELECT count(*) INTO cnt FROM public.user_photos WHERE user_id = NEW.user_id;
  IF cnt >= 4 THEN
    RAISE EXCEPTION 'A user can have at most 4 photos';
  END IF;
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_lifestyle_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.updated_at = timezone('utc', now());
  RETURN NEW;
END;
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

-- -------------------------------------------------------------------

create policy "match_requests: requester cancel"
on "public"."match_requests"
as permissive
for delete
to authenticated
using (
  (auth.uid() = requester_id)
  AND (status::text = 'pending')
);


create policy "match_requests: read own"
on "public"."match_requests"
as permissive
for select
to authenticated
using (((requester_id = auth.uid()) OR (target_id = auth.uid())));

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


create policy "profiles: self read"
on "public"."profiles"
as permissive
for select
to authenticated
using ((auth.uid() = id));

create policy "profiles: self update"
on "public"."profiles"
as permissive
for update
to authenticated
using ((auth.uid() = id))
with check ((auth.uid() = id));

create policy "user_photos: self read"
on "public"."user_photos"
as permissive
for select
to authenticated
using ((auth.uid() = user_id));

create policy "user_photos: self write"
on "public"."user_photos"
as permissive
for all
to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));
