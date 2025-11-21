create extension if not exists "postgis" with schema "public" version '3.3.7';

create type "public"."event_category_enum" as enum ('food_drinks', 'nightlife_party', 'outdoors_nature', 'sports_fitness', 'games_hobbies', 'arts_culture_entertainment', 'learning_career', 'community_volunteering', 'romantic_dating', 'travel_adventure', 'online_virtual', 'other');

create type "public"."event_status_enum" as enum ('active', 'cancelled', 'finished', 'expired');

create type "public"."gender_filter_enum" as enum ('Man', 'Woman', 'Beyond Binary');

create type "public"."media_type" as enum ('image', 'video');

drop policy "frames: select current via preview" on "public"."frames";

drop policy "frames: select history via full" on "public"."frames";

drop index if exists "public"."frames_one_active_per_user_idx";

drop index if exists "public"."frames_user_active_exp_idx";

create table "public"."events" (
    "id" uuid not null default gen_random_uuid(),
    "host_id" uuid not null,
    "event_name" text not null,
    "category" event_category_enum not null,
    "event_description" text not null,
    "location" geography(Point,4326) not null,
    "location_name" text not null,
    "time_start" timestamp with time zone not null,
    "time_end" timestamp with time zone not null,
    "capacity" integer not null,
    "gender_allowed" gender_filter_enum not null,
    "age_min" integer not null,
    "age_max" integer not null,
    "status" event_status_enum not null default 'active'::event_status_enum,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now(),
    "latitude" double precision,
    "longitude" double precision
);


alter table "public"."events" enable row level security;

alter table "public"."frames" drop column "is_active";

alter table "public"."frames" drop column "photo_url";

alter table "public"."frames" add column "is_expired" boolean not null default false;

alter table "public"."frames" add column "media_kind" media_type not null default 'image'::media_type;

alter table "public"."frames" add column "media_url" text not null;

alter table "public"."match_requests" alter column "status" set default 'pending'::match_status_enum;

alter table "public"."match_requests" alter column "status" set data type match_status_enum using "status"::text::match_status_enum;

drop type "public"."match_status_enum__old_version_to_be_dropped";

CREATE UNIQUE INDEX events_pkey ON public.events USING btree (id);

CREATE INDEX frames_user_expires_idx ON public.frames USING btree (user_id, expires_at DESC);

CREATE INDEX idx_events_location ON public.events USING gist (location);

alter table "public"."events" add constraint "events_pkey" PRIMARY KEY using index "events_pkey";

alter table "public"."events" add constraint "events_age_min_check" CHECK ((age_min >= 18)) not valid;

alter table "public"."events" validate constraint "events_age_min_check";

alter table "public"."events" add constraint "events_capacity_check" CHECK ((capacity > 0)) not valid;

alter table "public"."events" validate constraint "events_capacity_check";

alter table "public"."events" add constraint "events_check" CHECK ((time_end > time_start)) not valid;

alter table "public"."events" validate constraint "events_check";

alter table "public"."events" add constraint "events_check1" CHECK ((age_max >= age_min)) not valid;

alter table "public"."events" validate constraint "events_check1";

alter table "public"."events" add constraint "events_host_id_fkey" FOREIGN KEY (host_id) REFERENCES profiles(id) not valid;

alter table "public"."events" validate constraint "events_host_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.create_event_with_location(p_event_data json)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  v_event_id uuid;
BEGIN
  INSERT INTO events (
    host_id,
    event_name,
    category,
    event_description,
    location,
    location_name,
    time_start,
    time_end,
    capacity,
    gender_allowed,
    age_min,
    age_max,
    status
  ) VALUES (
    (p_event_data->>'host_id')::uuid,
    p_event_data->>'event_name',
    (p_event_data->>'category')::event_category_enum,
    p_event_data->>'event_description',
    ST_SetSRID(
      ST_MakePoint(
        (p_event_data->>'longitude')::float,
        (p_event_data->>'latitude')::float
      ),
      4326
    ),
    p_event_data->>'location_name',
    (p_event_data->>'time_start')::timestamptz,
    (p_event_data->>'time_end')::timestamptz,
    (p_event_data->>'capacity')::integer,
    (p_event_data->>'gender_allowed')::gender_filter_enum,
    (p_event_data->>'age_min')::integer,
    (p_event_data->>'age_max')::integer,
    COALESCE((p_event_data->>'status')::event_status_enum, 'active')
  ) RETURNING id INTO v_event_id;
  
  RETURN v_event_id;
END;
$function$
;

create type "public"."geometry_dump" as ("path" integer[], "geom" geometry);

CREATE OR REPLACE FUNCTION public.get_all_events_with_coordinates()
 RETURNS TABLE(id uuid, host_id uuid, event_name text, category event_category_enum, event_description text, location_name text, time_start timestamp with time zone, time_end timestamp with time zone, capacity integer, gender_allowed gender_filter_enum, age_min integer, age_max integer, status event_status_enum, created_at timestamp with time zone, updated_at timestamp with time zone, latitude double precision, longitude double precision)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  RETURN QUERY
  SELECT 
    e.id,
    e.host_id,
    e.event_name,
    e.category,
    e.event_description,
    e.location_name,
    e.time_start,
    e.time_end,
    e.capacity,
    e.gender_allowed,
    e.age_min,
    e.age_max,
    e.status,
    e.created_at,
    e.updated_at,
    ST_Y(e.location::geometry) as latitude,
    ST_X(e.location::geometry) as longitude
  FROM events e
  ORDER BY e.created_at DESC;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_events_with_coordinates(p_status event_status_enum DEFAULT 'active'::event_status_enum)
 RETURNS TABLE(id uuid, host_id uuid, event_name text, category event_category_enum, event_description text, location_name text, time_start timestamp with time zone, time_end timestamp with time zone, capacity integer, gender_allowed gender_filter_enum, age_min integer, age_max integer, status event_status_enum, created_at timestamp with time zone, updated_at timestamp with time zone, latitude double precision, longitude double precision)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  RETURN QUERY
  SELECT 
    e.id,
    e.host_id,
    e.event_name,
    e.category,
    e.event_description,
    e.location_name,
    e.time_start,
    e.time_end,
    e.capacity,
    e.gender_allowed,
    e.age_min,
    e.age_max,
    e.status,
    e.created_at,
    e.updated_at,
    -- Extract latitude and longitude from PostGIS geography
    ST_Y(e.location::geometry) as latitude,
    ST_X(e.location::geometry) as longitude
  FROM events e
  WHERE e.status = p_status
    AND e.time_end >= now()
  ORDER BY e.time_start ASC;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_my_nearby_events()
 RETURNS TABLE(id uuid, host_id uuid, event_name text, category event_category_enum, event_description text, location_name text, time_start timestamp with time zone, time_end timestamp with time zone, capacity integer, gender_allowed gender_filter_enum, age_min integer, age_max integer, status event_status_enum, created_at timestamp with time zone, updated_at timestamp with time zone, latitude double precision, longitude double precision, distance_meters double precision)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  v_user_lat double precision;
  v_user_lng double precision;
  v_radius_meters integer;
BEGIN
  -- Get user's current location and radius from their profile
  -- You'll need to add latitude/longitude columns to profiles table if not present
  SELECT 
    p.latitude,
    p.longitude,
    p.distance_meters
  INTO 
    v_user_lat,
    v_user_lng,
    v_radius_meters
  FROM profiles p
  WHERE p.id = auth.uid();

  -- If user has no location set, return empty
  IF v_user_lat IS NULL OR v_user_lng IS NULL THEN
    RETURN;
  END IF;

  -- Use default radius if not set
  v_radius_meters := COALESCE(v_radius_meters, 5000); -- Default 5km

  -- Return nearby events
  RETURN QUERY
  SELECT * FROM get_nearby_events_with_coordinates(
    v_user_lat,
    v_user_lng,
    v_radius_meters,
    'active'::event_status_enum
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_nearby_events_with_coordinates(p_user_lat double precision, p_user_lng double precision, p_radius_meters integer, p_status event_status_enum DEFAULT 'active'::event_status_enum)
 RETURNS TABLE(id uuid, host_id uuid, event_name text, category event_category_enum, event_description text, location_name text, time_start timestamp with time zone, time_end timestamp with time zone, capacity integer, gender_allowed gender_filter_enum, age_min integer, age_max integer, status event_status_enum, created_at timestamp with time zone, updated_at timestamp with time zone, latitude double precision, longitude double precision, distance_meters double precision)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  RETURN QUERY
  SELECT 
    e.id,
    e.host_id,
    e.event_name,
    e.category,
    e.event_description,
    e.location_name,
    e.time_start,
    e.time_end,
    e.capacity,
    e.gender_allowed,
    e.age_min,
    e.age_max,
    e.status,
    e.created_at,
    e.updated_at,
    -- Extract latitude and longitude from PostGIS geography
    ST_Y(e.location::geometry) as latitude,
    ST_X(e.location::geometry) as longitude,
    -- Calculate distance in meters
    ST_Distance(
      e.location,
      ST_SetSRID(ST_MakePoint(p_user_lng, p_user_lat), 4326)::geography
    ) as distance_meters
  FROM events e
  WHERE e.status = p_status
    AND e.time_end >= now()
    -- Filter by distance using ST_DWithin (more efficient than ST_Distance for filtering)
    AND ST_DWithin(
      e.location,
      ST_SetSRID(ST_MakePoint(p_user_lng, p_user_lat), 4326)::geography,
      p_radius_meters
    )
  ORDER BY distance_meters ASC, e.time_start ASC;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.mark_all_expired_frames()
 RETURNS TABLE(updated_count bigint)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  count_updated bigint;
BEGIN
  UPDATE public.frames
     SET is_expired = true,
         archived_at = COALESCE(archived_at, NOW())
   WHERE expires_at <= NOW()
     AND is_expired = false;
  
  GET DIAGNOSTICS count_updated = ROW_COUNT;
  RETURN QUERY SELECT count_updated;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.mark_expired_frames()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- If frame has expired, mark it
  IF NEW.expires_at IS NOT NULL AND NEW.expires_at <= NOW() THEN
    NEW.is_expired := true;
    IF NEW.archived_at IS NULL THEN
      NEW.archived_at := NOW();
    END IF;
  ELSE
    NEW.is_expired := false;
  END IF;
  
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.update_location_from_coords()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NEW.latitude IS NOT NULL AND NEW.longitude IS NOT NULL THEN
    NEW.location := ST_SetSRID(ST_MakePoint(NEW.longitude, NEW.latitude), 4326);
  END IF;
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.update_updated_at_column()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$function$
;

create type "public"."valid_detail" as ("valid" boolean, "reason" character varying, "location" geometry);

CREATE OR REPLACE FUNCTION public.validate_event_description_word_count()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  DECLARE
    word_count integer;
  BEGIN
    word_count := array_length(string_to_array(NEW.event_description, ' '), 1);
    
    IF word_count < 10 OR word_count > 500 THEN
      RAISE EXCEPTION 'Event description must be between 10 and 500 words. Current: % words', word_count;
    END IF;
    
    RETURN NEW;
  END;
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

CREATE OR REPLACE FUNCTION public.frames_after_insert_set_pointer()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Point profile to this new frame (if not expired)
  IF NEW.expires_at > NOW() THEN
    UPDATE public.profiles
       SET frame_id = NEW.id
     WHERE id = NEW.user_id;
  END IF;
  
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.frames_after_update_clear_pointer()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- If frame has expired, clear the profile pointer
  IF OLD.expires_at > NOW() AND NEW.expires_at <= NOW() THEN
    UPDATE public.profiles
       SET frame_id = NULL
     WHERE id = NEW.user_id 
       AND frame_id = NEW.id;
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
  -- Set default expiry if not provided
  IF NEW.expires_at IS NULL THEN
    NEW.expires_at := NOW() + INTERVAL '24 hours';
  END IF;

  -- Don't delete anything - just let frames expire naturally
  -- The profile pointer will be updated by the AFTER INSERT trigger
  
  RETURN NEW;
END;
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

create policy "Host can delete their own events"
on "public"."events"
as permissive
for delete
to public
using ((host_id = auth.uid()));


create policy "Host can update their own events"
on "public"."events"
as permissive
for update
to public
using ((host_id = auth.uid()))
with check ((host_id = auth.uid()));


create policy "Logged-in users can create events"
on "public"."events"
as permissive
for insert
to public
with check ((auth.uid() IS NOT NULL));


create policy "Logged-in users can view active events"
on "public"."events"
as permissive
for select
to public
using (((auth.uid() IS NOT NULL) AND (status = 'active'::event_status_enum)));


create policy "match_requests: create request"
on "public"."match_requests"
as permissive
for insert
to authenticated
with check (((requester_id = auth.uid()) AND (requester_id <> target_id) AND (status = 'pending'::match_status_enum)));


create policy "match_requests: requester cancel"
on "public"."match_requests"
as permissive
for delete
to authenticated
using (((auth.uid() = requester_id) AND (status = 'pending'::match_status_enum)));


create policy "match_requests: respond"
on "public"."match_requests"
as permissive
for update
to authenticated
using (((target_id = auth.uid()) AND (status = 'pending'::match_status_enum)))
with check (((target_id = auth.uid()) AND (status = ANY (ARRAY['accepted'::match_status_enum, 'rejected'::match_status_enum]))));


create policy "frames: select current via preview"
on "public"."frames"
as permissive
for select
to authenticated
using (((auth.uid() = user_id) AND (expires_at > now())));


create policy "frames: select history via full"
on "public"."frames"
as permissive
for select
to authenticated
using (((auth.uid() = user_id) AND (expires_at <= now())));


CREATE TRIGGER check_event_description_word_count BEFORE INSERT OR UPDATE ON public.events FOR EACH ROW EXECUTE FUNCTION validate_event_description_word_count();

CREATE TRIGGER set_location_from_coords BEFORE INSERT OR UPDATE ON public.events FOR EACH ROW EXECUTE FUNCTION update_location_from_coords();

CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON public.events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_mark_expired_frames BEFORE INSERT OR UPDATE ON public.frames FOR EACH ROW EXECUTE FUNCTION mark_expired_frames();



  create policy "frames: delete own folder"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'frames'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "frames: insert own folder"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'frames'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "frames: select own folder"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using (((bucket_id = 'frames'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "frames: update own folder"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using (((bucket_id = 'frames'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)))
with check (((bucket_id = 'frames'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



