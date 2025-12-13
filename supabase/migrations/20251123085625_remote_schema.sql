create type "public"."connection_visibility_enum" as enum ('full_profile', 'blind');

create type "public"."conversation_type_enum" as enum ('dating_match', 'blind_date', 'friend_match', 'event_group');

create type "public"."event_application_status_enum" as enum ('pending', 'approved', 'rejected', 'cancelled');

create type "public"."match_mode_enum" as enum ('dating', 'friend');

create type "public"."place_role_enum" as enum ('none', 'requester', 'target');

drop policy "Logged-in users can create events" on "public"."events";

drop policy "Logged-in users can view active events" on "public"."events";

revoke delete on table "public"."events" from "anon";

revoke insert on table "public"."events" from "anon";

revoke references on table "public"."events" from "anon";

revoke select on table "public"."events" from "anon";

revoke trigger on table "public"."events" from "anon";

revoke truncate on table "public"."events" from "anon";

revoke update on table "public"."events" from "anon";

revoke delete on table "public"."events" from "authenticated";

revoke insert on table "public"."events" from "authenticated";

revoke references on table "public"."events" from "authenticated";

revoke select on table "public"."events" from "authenticated";

revoke trigger on table "public"."events" from "authenticated";

revoke truncate on table "public"."events" from "authenticated";

revoke update on table "public"."events" from "authenticated";

revoke delete on table "public"."events" from "service_role";

revoke insert on table "public"."events" from "service_role";

revoke references on table "public"."events" from "service_role";

revoke select on table "public"."events" from "service_role";

revoke trigger on table "public"."events" from "service_role";

revoke truncate on table "public"."events" from "service_role";

revoke update on table "public"."events" from "service_role";

revoke delete on table "public"."spatial_ref_sys" from "anon";

revoke insert on table "public"."spatial_ref_sys" from "anon";

revoke references on table "public"."spatial_ref_sys" from "anon";

revoke select on table "public"."spatial_ref_sys" from "anon";

revoke trigger on table "public"."spatial_ref_sys" from "anon";

revoke truncate on table "public"."spatial_ref_sys" from "anon";

revoke update on table "public"."spatial_ref_sys" from "anon";

revoke delete on table "public"."spatial_ref_sys" from "authenticated";

revoke insert on table "public"."spatial_ref_sys" from "authenticated";

revoke references on table "public"."spatial_ref_sys" from "authenticated";

revoke select on table "public"."spatial_ref_sys" from "authenticated";

revoke trigger on table "public"."spatial_ref_sys" from "authenticated";

revoke truncate on table "public"."spatial_ref_sys" from "authenticated";

revoke update on table "public"."spatial_ref_sys" from "authenticated";

revoke delete on table "public"."spatial_ref_sys" from "postgres";

revoke insert on table "public"."spatial_ref_sys" from "postgres";

revoke references on table "public"."spatial_ref_sys" from "postgres";

revoke select on table "public"."spatial_ref_sys" from "postgres";

revoke trigger on table "public"."spatial_ref_sys" from "postgres";

revoke truncate on table "public"."spatial_ref_sys" from "postgres";

revoke update on table "public"."spatial_ref_sys" from "postgres";

revoke delete on table "public"."spatial_ref_sys" from "service_role";

revoke insert on table "public"."spatial_ref_sys" from "service_role";

revoke references on table "public"."spatial_ref_sys" from "service_role";

revoke select on table "public"."spatial_ref_sys" from "service_role";

revoke trigger on table "public"."spatial_ref_sys" from "service_role";

revoke truncate on table "public"."spatial_ref_sys" from "service_role";

revoke update on table "public"."spatial_ref_sys" from "service_role";

drop function if exists "public"."get_my_nearby_events"();

drop index if exists "public"."match_requests_pair_once_idx";

drop index if exists "public"."ux_match_requests_pair";

alter type "public"."gender_filter_enum" rename to "gender_filter_enum__old_version_to_be_dropped";

create type "public"."gender_filter_enum" as enum ('Man', 'Woman', 'Beyond Binary', 'Everyone');

create table "public"."conversation_members" (
    "conversation_id" uuid not null,
    "user_id" uuid not null,
    "joined_at" timestamp with time zone not null default now(),
    "muted" boolean not null default false,
    "last_read_at" timestamp with time zone
);


alter table "public"."conversation_members" enable row level security;

create table "public"."conversations" (
    "id" uuid not null default gen_random_uuid(),
    "type" conversation_type_enum not null,
    "match_request_id" uuid,
    "event_id" uuid,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


alter table "public"."conversations" enable row level security;

create table "public"."event_applications" (
    "id" uuid not null default gen_random_uuid(),
    "event_id" uuid not null,
    "applicant_id" uuid not null,
    "status" event_application_status_enum not null default 'pending'::event_application_status_enum,
    "add_as_friend" boolean not null default false,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


alter table "public"."event_applications" enable row level security;

create table "public"."event_ratings" (
    "id" uuid not null default gen_random_uuid(),
    "event_id" uuid not null,
    "rater_id" uuid not null,
    "rating" numeric(2,1) not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."event_ratings" enable row level security;

create table "public"."messages" (
    "id" uuid not null default gen_random_uuid(),
    "conversation_id" uuid not null,
    "sender_id" uuid not null,
    "content" text not null,
    "edited" boolean not null default false,
    "created_at" timestamp with time zone not null default now(),
    "edited_at" timestamp with time zone
);


alter table "public"."messages" enable row level security;

alter table "public"."events" alter column gender_allowed type "public"."gender_filter_enum" using gender_allowed::text::"public"."gender_filter_enum";

drop type "public"."gender_filter_enum__old_version_to_be_dropped";

alter table "public"."match_requests" add column "blind_location" geography(Point,4326);

alter table "public"."match_requests" add column "blind_location_name" text;

alter table "public"."match_requests" add column "blind_meet_time" timestamp with time zone;

alter table "public"."match_requests" add column "chat_allowed" boolean not null default true;

alter table "public"."match_requests" add column "connection_visibility" connection_visibility_enum not null default 'full_profile'::connection_visibility_enum;

alter table "public"."match_requests" add column "match_mode" match_mode_enum not null default 'dating'::match_mode_enum;

alter table "public"."match_requests" add column "origin_event_id" uuid;

alter table "public"."match_requests" add column "place_role" place_role_enum not null default 'none'::place_role_enum;

alter table "public"."match_requests" alter column "status" set default 'pending'::match_status_enum;

alter table "public"."match_requests" alter column "status" set data type match_status_enum using "status"::text::match_status_enum;

drop type "public"."match_status_enum__old_version_to_be_dropped";

CREATE UNIQUE INDEX conversation_members_pkey ON public.conversation_members USING btree (conversation_id, user_id);

CREATE UNIQUE INDEX conversations_pkey ON public.conversations USING btree (id);

CREATE UNIQUE INDEX event_applications_event_id_applicant_id_key ON public.event_applications USING btree (event_id, applicant_id);

CREATE UNIQUE INDEX event_applications_pkey ON public.event_applications USING btree (id);

CREATE UNIQUE INDEX event_ratings_event_id_rater_id_key ON public.event_ratings USING btree (event_id, rater_id);

CREATE UNIQUE INDEX event_ratings_pkey ON public.event_ratings USING btree (id);

CREATE INDEX idx_conversation_members_last_read ON public.conversation_members USING btree (last_read_at);

CREATE INDEX idx_conversation_members_user ON public.conversation_members USING btree (user_id);

CREATE INDEX idx_conversations_created ON public.conversations USING btree (created_at);

CREATE INDEX idx_conversations_event ON public.conversations USING btree (event_id);

CREATE INDEX idx_conversations_match_request ON public.conversations USING btree (match_request_id);

CREATE INDEX idx_conversations_type ON public.conversations USING btree (type);

CREATE INDEX idx_event_applications_applicant ON public.event_applications USING btree (applicant_id);

CREATE INDEX idx_event_applications_event ON public.event_applications USING btree (event_id);

CREATE INDEX idx_event_applications_status ON public.event_applications USING btree (status);

CREATE INDEX idx_event_ratings_event ON public.event_ratings USING btree (event_id);

CREATE INDEX idx_event_ratings_rater ON public.event_ratings USING btree (rater_id);

CREATE INDEX idx_event_ratings_rating ON public.event_ratings USING btree (rating);

CREATE INDEX idx_match_requests_mode ON public.match_requests USING btree (match_mode);

CREATE INDEX idx_match_requests_origin_event ON public.match_requests USING btree (origin_event_id);

CREATE INDEX idx_match_requests_requester ON public.match_requests USING btree (requester_id);

CREATE INDEX idx_match_requests_status ON public.match_requests USING btree (status);

CREATE INDEX idx_match_requests_target ON public.match_requests USING btree (target_id);

CREATE INDEX idx_match_requests_visibility ON public.match_requests USING btree (connection_visibility);

CREATE INDEX idx_messages_conversation ON public.messages USING btree (conversation_id);

CREATE INDEX idx_messages_conversation_created ON public.messages USING btree (conversation_id, created_at DESC);

CREATE INDEX idx_messages_created ON public.messages USING btree (created_at DESC);

CREATE INDEX idx_messages_sender ON public.messages USING btree (sender_id);

CREATE UNIQUE INDEX match_requests_unique_pair_mode ON public.match_requests USING btree (LEAST(requester_id, target_id), GREATEST(requester_id, target_id), match_mode);

CREATE UNIQUE INDEX messages_pkey ON public.messages USING btree (id);

alter table "public"."conversation_members" add constraint "conversation_members_pkey" PRIMARY KEY using index "conversation_members_pkey";

alter table "public"."conversations" add constraint "conversations_pkey" PRIMARY KEY using index "conversations_pkey";

alter table "public"."event_applications" add constraint "event_applications_pkey" PRIMARY KEY using index "event_applications_pkey";

alter table "public"."event_ratings" add constraint "event_ratings_pkey" PRIMARY KEY using index "event_ratings_pkey";

alter table "public"."messages" add constraint "messages_pkey" PRIMARY KEY using index "messages_pkey";

alter table "public"."conversation_members" add constraint "conversation_members_conversation_id_fkey" FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE not valid;

alter table "public"."conversation_members" validate constraint "conversation_members_conversation_id_fkey";

alter table "public"."conversation_members" add constraint "conversation_members_user_id_fkey" FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."conversation_members" validate constraint "conversation_members_user_id_fkey";

alter table "public"."conversations" add constraint "conversations_check" CHECK ((((type = ANY (ARRAY['dating_match'::conversation_type_enum, 'blind_date'::conversation_type_enum, 'friend_match'::conversation_type_enum])) AND (match_request_id IS NOT NULL) AND (event_id IS NULL)) OR ((type = 'event_group'::conversation_type_enum) AND (event_id IS NOT NULL) AND (match_request_id IS NULL)))) not valid;

alter table "public"."conversations" validate constraint "conversations_check";

alter table "public"."conversations" add constraint "conversations_event_id_fkey" FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE not valid;

alter table "public"."conversations" validate constraint "conversations_event_id_fkey";

alter table "public"."conversations" add constraint "conversations_match_request_id_fkey" FOREIGN KEY (match_request_id) REFERENCES match_requests(id) ON DELETE CASCADE not valid;

alter table "public"."conversations" validate constraint "conversations_match_request_id_fkey";

alter table "public"."event_applications" add constraint "event_applications_applicant_id_fkey" FOREIGN KEY (applicant_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."event_applications" validate constraint "event_applications_applicant_id_fkey";

alter table "public"."event_applications" add constraint "event_applications_event_id_applicant_id_key" UNIQUE using index "event_applications_event_id_applicant_id_key";

alter table "public"."event_applications" add constraint "event_applications_event_id_fkey" FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE not valid;

alter table "public"."event_applications" validate constraint "event_applications_event_id_fkey";

alter table "public"."event_ratings" add constraint "event_ratings_event_id_fkey" FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE not valid;

alter table "public"."event_ratings" validate constraint "event_ratings_event_id_fkey";

alter table "public"."event_ratings" add constraint "event_ratings_event_id_rater_id_key" UNIQUE using index "event_ratings_event_id_rater_id_key";

alter table "public"."event_ratings" add constraint "event_ratings_rater_id_fkey" FOREIGN KEY (rater_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."event_ratings" validate constraint "event_ratings_rater_id_fkey";

alter table "public"."event_ratings" add constraint "event_ratings_rating_check" CHECK (((rating >= 0.5) AND (rating <= 5.0) AND ((((rating * (10)::numeric))::integer % 5) = 0))) not valid;

alter table "public"."event_ratings" validate constraint "event_ratings_rating_check";

alter table "public"."match_requests" add constraint "match_requests_origin_event_fk" FOREIGN KEY (origin_event_id) REFERENCES events(id) ON DELETE SET NULL not valid;

alter table "public"."match_requests" validate constraint "match_requests_origin_event_fk";

alter table "public"."messages" add constraint "messages_content_check" CHECK ((length(TRIM(BOTH FROM content)) > 0)) not valid;

alter table "public"."messages" validate constraint "messages_content_check";

alter table "public"."messages" add constraint "messages_conversation_id_fkey" FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_conversation_id_fkey";

alter table "public"."messages" add constraint "messages_sender_id_fkey" FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_sender_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.expire_ended_events()
 RETURNS void
 LANGUAGE sql
AS $function$
    UPDATE events
    SET status = 'expired'
    WHERE status = 'active'
    AND time_end < now()
$function$
;

CREATE OR REPLACE FUNCTION public.get_host_ratings()
 RETURNS TABLE(host_id uuid, total_ratings bigint, average_rating numeric, min_rating numeric, max_rating numeric)
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        e.host_id,
        COUNT(DISTINCT er.id) as total_ratings,
        ROUND(AVG(er.rating), 2) as average_rating,
        MIN(er.rating) as min_rating,
        MAX(er.rating) as max_rating
    FROM events e
    JOIN event_ratings er ON e.id = er.event_id
    GROUP BY e.host_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_map_cards(p_mode match_mode_enum DEFAULT 'dating'::match_mode_enum)
 RETURNS TABLE(user_id uuid, full_name text, age integer, bio text, frame_id uuid, mode text, approx_lat numeric, approx_lng numeric, main_photo_url text)
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
AS $function$
DECLARE
    current_user_id uuid;
BEGIN
    -- Get the current user ID
    current_user_id := auth.uid();
    
    IF current_user_id IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;

    RETURN QUERY
    WITH latest_mode AS (
        SELECT DISTINCT ON (um.user_id)
            um.user_id,
            um.mode
        FROM user_modes um
        ORDER BY um.user_id, um.created_at DESC
    )
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt) as bio,
        p.frame_id,
        COALESCE(lm.mode, 'dating') as mode,
        ROUND(p.lat::numeric + (RANDOM() - 0.5)::numeric * 0.01, 4) as approx_lat,
        ROUND(p.lng::numeric + (RANDOM() - 0.5)::numeric * 0.01, 4) as approx_lng,
        (
            SELECT up.photo_url
            FROM user_photos up 
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as main_photo_url
    FROM profiles p
    LEFT JOIN latest_mode lm ON lm.user_id = p.id
    WHERE 
        p.id != current_user_id  -- FIXED: Exclude self
        AND can_see_on_map(current_user_id, p.id)
        AND NOT EXISTS(
            SELECT 1 FROM match_requests mr
            WHERE mr.status = 'denied'
            AND mr.match_mode = p_mode
            AND ((mr.requester_id = current_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = current_user_id))
        )
        AND NOT have_blocked_each_other(current_user_id, p.id)
    ORDER BY p.last_seen DESC;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_match_status(target_user_id uuid, p_mode match_mode_enum DEFAULT 'dating'::match_mode_enum)
 RETURNS TABLE(status match_status_enum, connection_visibility connection_visibility_enum, chat_allowed boolean, is_requester boolean, match_id uuid)
 LANGUAGE plpgsql
 STABLE
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        mr.status,
        mr.connection_visibility,
        mr.chat_allowed,
        (mr.requester_id = auth.uid()) as is_requester,
        mr.id as match_id
    FROM match_requests mr
    WHERE mr.match_mode = p_mode
    AND ((mr.requester_id = auth.uid() AND mr.target_id = target_user_id)
        OR (mr.requester_id = target_user_id AND mr.target_id = auth.uid()))
    ORDER BY mr.created_at DESC
    LIMIT 1;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_profile_if_matched(target uuid)
 RETURNS TABLE(user_id uuid, full_name text, age integer, gender text, sexual_orientation text, bio text, height_cm integer, education text, prompt_answers jsonb, lifestyle jsonb, hobbies text[], photos text[])
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_temp'
AS $function$
BEGIN
    -- Check auth first for clearer error
    IF auth.uid() IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;

    -- Check for full-profile match AND no blocks
    IF NOT EXISTS(
        SELECT 1 FROM match_requests mr
        WHERE mr.status = 'accepted'
        AND mr.connection_visibility = 'full_profile'
        AND ((mr.requester_id = auth.uid() AND mr.target_id = target)
            OR (mr.requester_id = target AND mr.target_id = auth.uid()))
    ) OR have_blocked_each_other(auth.uid(), target) THEN
        RAISE EXCEPTION 'no access: match not accepted, is blind connection, or users blocked';
    END IF;

    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        p.gender,
        p.sexual_orientation::text,
        COALESCE(p.bio, p.prompt) as bio,  -- Fallback to prompt if bio is null
        p.height_cm,
        p.education,
        p.prompt_answers,
        CASE 
            WHEN l.user_id IS NOT NULL THEN
                jsonb_build_object(
                    'drinking', l.drinking,
                    'smoking', l.smoking,
                    'kids', l.kids,
                    'workout', l.workout,
                    'communication', l.communication,
                    'love_language', l.love_language,
                    'zodiac', l.zodiac,
                    'religion', l.religion,
                    'politics', l.politics,
                    'pets', l.pets,
                    'communities', l.communities
                )
            ELSE NULL
        END as lifestyle,
        COALESCE(
            ARRAY(
                SELECT hm.label  -- FIX: use 'label' not 'hobby_name'
                FROM user_hobbies uh
                JOIN hobbies_master hm ON uh.hobby_id = hm.id
                WHERE uh.user_id = p.id
                ORDER BY hm.label
            ), 
            ARRAY[]::text[]
        ) as hobbies,
        COALESCE(
            ARRAY(
                SELECT photo_url 
                FROM user_photos up 
                WHERE up.user_id = p.id 
                ORDER BY is_main DESC, id ASC
            ), 
            ARRAY[]::text[]
        ) as photos
    FROM profiles p
    LEFT JOIN lifestyle l ON l.user_id = p.id
    WHERE p.id = target;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_event_application_approval()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
    v_host_id uuid;
    v_match_id uuid;
BEGIN
    -- Only proceed if status changed to approved and add_as_friend is true
    IF NEW.status = 'approved' AND NEW.add_as_friend = true AND
       (OLD.status IS NULL OR OLD.status != 'approved' OR OLD.add_as_friend != true) THEN
        
        -- Get the host_id from the event
        SELECT host_id INTO v_host_id FROM events WHERE id = NEW.event_id;
        
        -- Check if a friend connection already exists
        SELECT id INTO v_match_id
        FROM match_requests
        WHERE match_mode = 'friend'
        AND ((requester_id = v_host_id AND target_id = NEW.applicant_id) OR
             (requester_id = NEW.applicant_id AND target_id = v_host_id));
        
        IF v_match_id IS NULL THEN
            -- Create new friend connection (auto-accepted)
            INSERT INTO match_requests (
                requester_id, target_id, status, match_mode,
                connection_visibility, place_role, chat_allowed, 
                origin_event_id, responded_at
            ) VALUES (
                v_host_id, NEW.applicant_id, 'accepted', 'friend',
                'full_profile', 'none', true,
                NEW.event_id, now()
            );
        ELSE
            -- Update existing connection to accepted if not already
            UPDATE match_requests
            SET status = 'accepted',
                responded_at = COALESCE(responded_at, now()),
                origin_event_id = COALESCE(origin_event_id, NEW.event_id)
            WHERE id = v_match_id AND status != 'accepted';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_match_acceptance()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
    v_conversation_id uuid;
    v_conversation_type conversation_type_enum;
BEGIN
    -- Only proceed if status changed to accepted and chat is allowed
    IF NEW.status = 'accepted' AND NEW.chat_allowed = true AND 
       (OLD.status IS NULL OR OLD.status != 'accepted') THEN
        
        -- Determine conversation type based on match mode and visibility
        IF NEW.match_mode = 'dating' THEN
            IF NEW.connection_visibility = 'full_profile' THEN
                v_conversation_type := 'dating_match';
            ELSE
                v_conversation_type := 'blind_date';
            END IF;
        ELSE -- friend mode
            v_conversation_type := 'friend_match';
        END IF;
        
        -- Create conversation
        INSERT INTO conversations (type, match_request_id)
        VALUES (v_conversation_type, NEW.id)
        RETURNING id INTO v_conversation_id;
        
        -- Add both users as members
        INSERT INTO conversation_members (conversation_id, user_id)
        VALUES 
            (v_conversation_id, NEW.requester_id),
            (v_conversation_id, NEW.target_id);
    END IF;
    
    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.should_reveal_blind_profile(match_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
    v_blind_meet_time timestamptz;
    v_connection_visibility connection_visibility_enum;
BEGIN
    -- Get the blind date details
    SELECT blind_meet_time, connection_visibility
    INTO v_blind_meet_time, v_connection_visibility
    FROM match_requests
    WHERE id = match_id;
    
    -- If not a blind connection, always reveal
    IF v_connection_visibility != 'blind' THEN
        RETURN true;
    END IF;
    
    -- If no meet time set, don't reveal
    IF v_blind_meet_time IS NULL THEN
        RETURN false;
    END IF;
    
    -- Reveal if the meeting time has passed (you can adjust the logic)
    -- For now, simple: reveal after meeting time + 1 hour
    RETURN now() > (v_blind_meet_time + interval '1 hour');
END;
$function$
;

CREATE OR REPLACE FUNCTION public.validate_event_rating()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
    -- Check if event has ended
    IF NOT EXISTS (
        SELECT 1 FROM events 
        WHERE id = NEW.event_id 
        AND (time_end < now() OR status IN ('finished', 'expired'))
    ) THEN
        RAISE EXCEPTION 'Can only rate events that have ended';
    END IF;
    
    -- Check if rater was approved for the event
    IF NOT EXISTS (
        SELECT 1 FROM event_applications
        WHERE event_id = NEW.event_id
        AND applicant_id = NEW.rater_id
        AND status = 'approved'
    ) THEN
        RAISE EXCEPTION 'Only approved attendees can rate events';
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
    SELECT EXISTS(
        SELECT 1 FROM match_requests mr
        WHERE ((mr.requester_id = me AND mr.target_id = other)
            OR (mr.requester_id = other AND mr.target_id = me))
        AND mr.status = 'accepted'
        AND mr.connection_visibility = 'full_profile'  -- NEW: only full profile connections
    )
    AND NOT have_blocked_each_other(me, other)
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
 RETURNS TABLE(id uuid, host_id uuid, event_name text, category event_category_enum, event_description text, location geography, location_name text, time_start timestamp with time zone, time_end timestamp with time zone, capacity integer, gender_allowed gender_filter_enum, age_min integer, age_max integer, status event_status_enum, created_at timestamp with time zone, updated_at timestamp with time zone, latitude double precision, longitude double precision, distance_km numeric, attendee_count bigint)
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
    user_lat numeric;
    user_lng numeric;
    user_age integer;
    user_gender text;
BEGIN
    SELECT p.lat, p.lng, p.age, p.gender
    INTO user_lat, user_lng, user_age, user_gender
    FROM profiles p
    WHERE p.id = auth.uid();
    
    RETURN QUERY
    WITH event_data AS (
        SELECT 
            e.*,
            ST_Distance(
                e.location::geography,
                ST_MakePoint(user_lng, user_lat)::geography
            ) / 1000.0 AS dist_km,
            (
                SELECT COUNT(*)
                FROM event_applications ea
                WHERE ea.event_id = e.id
                AND ea.status = 'approved'
            ) AS attendee_cnt
        FROM events e
        WHERE 
            e.status = 'active'
            AND e.time_start > now()
            AND ST_DWithin(
                e.location::geography,
                ST_MakePoint(user_lng, user_lat)::geography,
                30000
            )
            AND user_age BETWEEN e.age_min AND e.age_max
            AND (
                e.gender_allowed = 'Everyone'
                OR (e.gender_allowed = 'Man' AND user_gender = 'man')
                OR (e.gender_allowed = 'Woman' AND user_gender = 'woman')
                OR (e.gender_allowed = 'Beyond Binary' AND user_gender = 'nonbinary')  -- FIX: space added
            )
            AND NOT have_blocked_each_other(auth.uid(), e.host_id)
    )
    SELECT 
        ed.id, ed.host_id, ed.event_name, ed.category,
        ed.event_description, ed.location, ed.location_name,
        ed.time_start, ed.time_end, ed.capacity, ed.gender_allowed,
        ed.age_min, ed.age_max, ed.status, ed.created_at,
        ed.updated_at, ed.latitude, ed.longitude,
        ROUND(ed.dist_km, 2), ed.attendee_cnt
    FROM event_data ed
    ORDER BY ed.dist_km, ed.time_start;
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

create policy "conversation_members:delete_self"
on "public"."conversation_members"
as permissive
for delete
to authenticated
using ((user_id = auth.uid()));


create policy "conversation_members:select_self"
on "public"."conversation_members"
as permissive
for select
to authenticated
using ((user_id = auth.uid()));


create policy "conversations:select_member"
on "public"."conversations"
as permissive
for select
to authenticated
using ((EXISTS ( SELECT 1
   FROM conversation_members cm
  WHERE ((cm.conversation_id = conversations.id) AND (cm.user_id = auth.uid())))));


create policy "event_applications:insert_own"
on "public"."event_applications"
as permissive
for insert
to authenticated
with check (((auth.uid() = applicant_id) AND (NOT (EXISTS ( SELECT 1
   FROM events e
  WHERE ((e.id = event_applications.event_id) AND have_blocked_each_other(auth.uid(), e.host_id)))))));


create policy "event_applications:select_own_or_host"
on "public"."event_applications"
as permissive
for select
to authenticated
using (((auth.uid() = applicant_id) OR (auth.uid() = ( SELECT e.host_id
   FROM events e
  WHERE (e.id = event_applications.event_id)))));


create policy "event_applications:update_cancel_own"
on "public"."event_applications"
as permissive
for update
to authenticated
using (((auth.uid() = applicant_id) AND (status = 'pending'::event_application_status_enum)))
with check (((auth.uid() = applicant_id) AND (status = 'cancelled'::event_application_status_enum)));


create policy "event_applications:update_host"
on "public"."event_applications"
as permissive
for update
to authenticated
using ((auth.uid() = ( SELECT e.host_id
   FROM events e
  WHERE (e.id = event_applications.event_id))))
with check ((auth.uid() = ( SELECT e.host_id
   FROM events e
  WHERE (e.id = event_applications.event_id))));


create policy "event_ratings:insert_self"
on "public"."event_ratings"
as permissive
for insert
to authenticated
with check ((auth.uid() = rater_id));


create policy "event_ratings:select_all"
on "public"."event_ratings"
as permissive
for select
to authenticated
using (true);


create policy "events:insert_own"
on "public"."events"
as permissive
for insert
to authenticated
with check ((host_id = auth.uid()));


create policy "events:select_authenticated"
on "public"."events"
as permissive
for select
to authenticated
using (((auth.uid() IS NOT NULL) AND (NOT have_blocked_each_other(auth.uid(), host_id))));


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


create policy "messages:insert_member"
on "public"."messages"
as permissive
for insert
to authenticated
with check (((sender_id = auth.uid()) AND (EXISTS ( SELECT 1
   FROM conversation_members cm
  WHERE ((cm.conversation_id = messages.conversation_id) AND (cm.user_id = auth.uid())))) AND (NOT (EXISTS ( SELECT 1
   FROM (conversations c
     JOIN match_requests mr ON ((c.match_request_id = mr.id)))
  WHERE ((c.id = messages.conversation_id) AND have_blocked_each_other(mr.requester_id, mr.target_id)))))));


create policy "messages:select_member"
on "public"."messages"
as permissive
for select
to authenticated
using ((EXISTS ( SELECT 1
   FROM conversation_members cm
  WHERE ((cm.conversation_id = messages.conversation_id) AND (cm.user_id = auth.uid())))));


CREATE TRIGGER handle_event_friend_add AFTER INSERT OR UPDATE ON public.event_applications FOR EACH ROW EXECUTE FUNCTION handle_event_application_approval();

CREATE TRIGGER update_event_applications_updated_at BEFORE UPDATE ON public.event_applications FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER check_event_rating_validity BEFORE INSERT OR UPDATE ON public.event_ratings FOR EACH ROW EXECUTE FUNCTION validate_event_rating();

CREATE TRIGGER create_conversation_on_match_accept AFTER INSERT OR UPDATE ON public.match_requests FOR EACH ROW EXECUTE FUNCTION handle_match_acceptance();



