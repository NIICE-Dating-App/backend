


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "postgis" WITH SCHEMA "public";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."community_category_enum" AS ENUM (
    'tech',
    'sports',
    'music',
    'art',
    'food',
    'travel',
    'fitness',
    'gaming',
    'books',
    'movies',
    'photography',
    'fashion',
    'business',
    'education',
    'health',
    'lifestyle',
    'other'
);


ALTER TYPE "public"."community_category_enum" OWNER TO "postgres";


CREATE TYPE "public"."conversation_type_enum" AS ENUM (
    'dating_match',
    'blind_date',
    'friend_match',
    'event_group',
    'group_chat',
    'community_chat',
    'match'
);


ALTER TYPE "public"."conversation_type_enum" OWNER TO "postgres";


CREATE TYPE "public"."event_application_status_enum" AS ENUM (
    'pending',
    'approved',
    'rejected',
    'cancelled'
);


ALTER TYPE "public"."event_application_status_enum" OWNER TO "postgres";


CREATE TYPE "public"."event_category_enum" AS ENUM (
    'food_drinks',
    'nightlife_party',
    'outdoors_nature',
    'sports_fitness',
    'games_hobbies',
    'arts_culture_entertainment',
    'learning_career',
    'community_volunteering',
    'romantic_dating',
    'travel_adventure',
    'online_virtual',
    'other'
);


ALTER TYPE "public"."event_category_enum" OWNER TO "postgres";


CREATE TYPE "public"."event_status_enum" AS ENUM (
    'active',
    'cancelled',
    'finished',
    'expired'
);


ALTER TYPE "public"."event_status_enum" OWNER TO "postgres";


CREATE TYPE "public"."event_type_enum" AS ENUM (
    'public',
    'public_application',
    'private',
    'invite_only',
    'group_event',
    'community_event'
);


ALTER TYPE "public"."event_type_enum" OWNER TO "postgres";


CREATE TYPE "public"."event_visibility_enum" AS ENUM (
    'public',
    'private',
    'invite_only'
);


ALTER TYPE "public"."event_visibility_enum" OWNER TO "postgres";


CREATE TYPE "public"."gender_enum" AS ENUM (
    'man',
    'woman',
    'nonbinary'
);


ALTER TYPE "public"."gender_enum" OWNER TO "postgres";


CREATE TYPE "public"."gender_filter_enum" AS ENUM (
    'Man',
    'Woman',
    'Beyond Binary',
    'Everyone'
);


ALTER TYPE "public"."gender_filter_enum" OWNER TO "postgres";


CREATE TYPE "public"."looking_for_enum" AS ENUM (
    'long_term_relationship',
    'life_partner',
    'casual_dates',
    'intimacy',
    'marriage',
    'short_term_relationship',
    'new_friends',
    'figuring_it_out',
    'workout_fitness_buddy',
    'travel_companions',
    'activity_hobby_partners',
    'casual_hangouts',
    'professional_networking',
    'close_friendships',
    'event_buddies',
    'group_activities',
    'local_exploration',
    'adventure_partners',
    'cultural_events',
    'sports_events',
    'food_and_drinks',
    'nightlife_partners',
    'outdoor_activities',
    'learning_together'
);


ALTER TYPE "public"."looking_for_enum" OWNER TO "postgres";


COMMENT ON TYPE "public"."looking_for_enum" IS 'User preferences for what they are looking for - includes dating, friendship, and event/activity options';



CREATE TYPE "public"."marital_status_enum" AS ENUM (
    'single',
    'in_relationship',
    'engaged',
    'married',
    'divorced',
    'widowed',
    'separated',
    'its_complicated'
);


ALTER TYPE "public"."marital_status_enum" OWNER TO "postgres";


CREATE TYPE "public"."match_status_enum" AS ENUM (
    'pending',
    'accepted',
    'denied',
    'rejected'
);


ALTER TYPE "public"."match_status_enum" OWNER TO "postgres";


CREATE TYPE "public"."media_type" AS ENUM (
    'image',
    'video'
);


ALTER TYPE "public"."media_type" OWNER TO "postgres";


CREATE TYPE "public"."member_role_enum" AS ENUM (
    'owner',
    'admin',
    'moderator',
    'member'
);


ALTER TYPE "public"."member_role_enum" OWNER TO "postgres";


CREATE TYPE "public"."message_type_enum" AS ENUM (
    'text',
    'image',
    'voice',
    'system',
    'reaction',
    'location',
    'deleted'
);


ALTER TYPE "public"."message_type_enum" OWNER TO "postgres";


CREATE TYPE "public"."orientation_enum" AS ENUM (
    'straight',
    'gay',
    'bisexual',
    'other',
    'lesbian',
    'pansexual',
    'omnisexual',
    'asexual',
    'demisexual',
    'aromantic',
    'queer',
    'questioning',
    'not_listed'
);


ALTER TYPE "public"."orientation_enum" OWNER TO "postgres";


CREATE TYPE "public"."profile_visibility_enum" AS ENUM (
    'public',
    'private'
);


ALTER TYPE "public"."profile_visibility_enum" OWNER TO "postgres";


CREATE TYPE "public"."value_enum" AS ENUM (
    'honesty',
    'kindness',
    'sense_of_humor',
    'good_communication',
    'ambition',
    'loyalty',
    'emotional_intelligence',
    'adventurous_spirit',
    'intelligence',
    'affectionate',
    'family_oriented',
    'open_mindedness',
    'active_lifestyle',
    'supportive',
    'authenticity',
    'similar_values',
    'confidence',
    'romantic',
    'financial_stability',
    'shared_interests',
    'trustworthy',
    'good_listener',
    'non_judgmental',
    'reliable',
    'fun_to_be_around',
    'understanding',
    'deep_conversations',
    'positive_energy',
    'low_maintenance',
    'makes_time_for_me',
    'encouraging',
    'respectful_of_boundaries',
    'growth_minded'
);


ALTER TYPE "public"."value_enum" OWNER TO "postgres";


CREATE TYPE "public"."vehicle_enum" AS ENUM (
    'car',
    'motorcycle',
    'bicycle',
    'scooter',
    'boat',
    'plane',
    'none'
);


ALTER TYPE "public"."vehicle_enum" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."accept_event_invite"("p_invite_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_event_id UUID;
    v_conversation_id UUID;
BEGIN
    -- Verify invite belongs to user and is pending
    SELECT event_id INTO v_event_id
    FROM event_invites
    WHERE id = p_invite_id 
    AND invited_user_id = auth.uid()
    AND status = 'pending';
    
    IF v_event_id IS NULL THEN
        RAISE EXCEPTION 'Invite not found or already processed';
    END IF;
    
    -- Update invite status (this will trigger add_invited_user_to_event_chat)
    UPDATE event_invites
    SET status = 'accepted'
    WHERE id = p_invite_id;
    
    RETURN true;
END;
$$;


ALTER FUNCTION "public"."accept_event_invite"("p_invite_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."accept_group_invite"("p_invite_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_invite RECORD;
BEGIN
    -- Get invite and verify ownership
    SELECT * INTO v_invite
    FROM group_invites
    WHERE id = p_invite_id
    AND invited_user_id = auth.uid()
    AND status = 'pending';
    
    IF v_invite IS NULL THEN
        RAISE EXCEPTION 'Invite not found or already processed';
    END IF;
    
    -- Update invite status (trigger will handle adding to group)
    UPDATE group_invites
    SET status = 'accepted'
    WHERE id = p_invite_id;
    
    RETURN true;
END;
$$;


ALTER FUNCTION "public"."accept_group_invite"("p_invite_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."add_approved_applicant_to_event_chat"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    -- Only proceed if status changed to 'approved'
    IF NEW.status = 'approved' AND (OLD.status IS NULL OR OLD.status != 'approved') THEN
        -- Find the event group chat
        SELECT id INTO v_conversation_id
        FROM conversations
        WHERE event_id = NEW.event_id AND type = 'event_group';
        
        IF v_conversation_id IS NOT NULL THEN
            -- Add applicant to conversation
            INSERT INTO conversation_members (conversation_id, user_id)
            VALUES (v_conversation_id, NEW.applicant_id)
            ON CONFLICT DO NOTHING;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."add_approved_applicant_to_event_chat"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."add_invited_user_to_event_chat"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    -- Only proceed if status changed to 'accepted'
    IF NEW.status = 'accepted' AND (OLD.status IS NULL OR OLD.status != 'accepted') THEN
        -- Find the event group chat
        SELECT id INTO v_conversation_id
        FROM conversations
        WHERE event_id = NEW.event_id AND type = 'event_group';
        
        IF v_conversation_id IS NOT NULL AND NEW.invited_user_id IS NOT NULL THEN
            -- Add invited user to conversation
            INSERT INTO conversation_members (conversation_id, user_id)
            VALUES (v_conversation_id, NEW.invited_user_id)
            ON CONFLICT DO NOTHING;
            
            -- Also create an approved application for them
            INSERT INTO event_applications (event_id, applicant_id, status)
            VALUES (NEW.event_id, NEW.invited_user_id, 'approved')
            ON CONFLICT (event_id, applicant_id) 
            DO UPDATE SET status = 'approved';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."add_invited_user_to_event_chat"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."apply_to_event"("p_event_id" "uuid", "p_message" "text" DEFAULT NULL::"text") RETURNS json
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_user_id UUID;
  v_event RECORD;
  v_existing RECORD;
  v_new_status event_application_status_enum;
  v_result JSON;
BEGIN
  -- Get current user
  v_user_id := auth.uid();
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'error', 'Not authenticated');
  END IF;
  
  -- Get event details
  SELECT id, host_id, event_type, status, capacity
  INTO v_event
  FROM events
  WHERE id = p_event_id;
  
  IF v_event IS NULL THEN
    RETURN json_build_object('success', false, 'error', 'Event not found');
  END IF;
  
  IF v_event.status != 'active' THEN
    RETURN json_build_object('success', false, 'error', 'Event is not active');
  END IF;
  
  -- Check if user is the host
  IF v_event.host_id = v_user_id THEN
    RETURN json_build_object('success', false, 'error', 'You cannot apply to your own event');
  END IF;
  
  -- Check for existing application
  SELECT id, status INTO v_existing
  FROM event_applications
  WHERE event_id = p_event_id AND applicant_id = v_user_id;
  
  IF v_existing IS NOT NULL THEN
    RETURN json_build_object(
      'success', false, 
      'error', 'You have already applied to this event',
      'status', v_existing.status
    );
  END IF;
  
  -- Check if event is at capacity (for approved applications)
  IF v_event.event_type IN ('public', 'group_event', 'community_event') THEN
    DECLARE
      v_current_count INT;
    BEGIN
      SELECT COUNT(*) INTO v_current_count
      FROM event_applications
      WHERE event_id = p_event_id AND status = 'approved';
      
      IF v_current_count >= v_event.capacity THEN
        RETURN json_build_object('success', false, 'error', 'Event is at full capacity');
      END IF;
    END;
  END IF;
  
  -- Determine status based on event type
  IF v_event.event_type IN ('public', 'group_event', 'community_event') THEN
    v_new_status := 'approved';
  ELSE
    v_new_status := 'pending';
  END IF;
  
  -- Insert application
  INSERT INTO event_applications (event_id, applicant_id, status, message)
  VALUES (p_event_id, v_user_id, v_new_status, p_message);
  
  -- Return success
  IF v_new_status = 'approved' THEN
    RETURN json_build_object('success', true, 'message', 'You have joined the event', 'status', 'approved');
  ELSE
    RETURN json_build_object('success', true, 'message', 'Your application has been sent', 'status', 'pending');
  END IF;
  
EXCEPTION
  WHEN unique_violation THEN
    RETURN json_build_object('success', false, 'error', 'You have already applied to this event');
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'error', SQLERRM);
END;
$$;


ALTER FUNCTION "public"."apply_to_event"("p_event_id" "uuid", "p_message" "text") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."apply_to_event"("p_event_id" "uuid", "p_message" "text") IS 'Apply or join an event. Uses SECURITY DEFINER to bypass RLS recursion issues.';



CREATE OR REPLACE FUNCTION "public"."are_in_same_community"("p_user1" "uuid", "p_user2" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT EXISTS (
        SELECT 1 
        FROM community_members cm1
        JOIN community_members cm2 ON cm1.community_id = cm2.community_id
        WHERE cm1.user_id = p_user1
        AND cm2.user_id = p_user2
        AND cm1.user_id != cm2.user_id
    );
$$;


ALTER FUNCTION "public"."are_in_same_community"("p_user1" "uuid", "p_user2" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."are_in_same_group"("p_user1" "uuid", "p_user2" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT EXISTS (
        SELECT 1 
        FROM group_members gm1
        JOIN group_members gm2 ON gm1.group_id = gm2.group_id
        WHERE gm1.user_id = p_user1
        AND gm2.user_id = p_user2
        AND gm1.user_id != gm2.user_id
    );
$$;


ALTER FUNCTION "public"."are_in_same_group"("p_user1" "uuid", "p_user2" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_invite_to_event"("p_user_id" "uuid", "p_event_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_event RECORD;
    v_is_approved BOOLEAN;
BEGIN
    SELECT * INTO v_event
    FROM events
    WHERE id = p_event_id;
    
    IF NOT FOUND THEN
        RETURN false;
    END IF;
    
    -- Host can always invite
    IF v_event.host_id = p_user_id THEN
        RETURN true;
    END IF;
    
    -- Only invite_only events have member invite capability
    IF v_event.event_type != 'invite_only' THEN
        RETURN false;
    END IF;
    
    -- Check if allow_member_invites is enabled
    IF NOT v_event.allow_member_invites THEN
        RETURN false;
    END IF;
    
    -- Check if user is an approved attendee
    v_is_approved := EXISTS (
        SELECT 1 FROM event_applications ea
        WHERE ea.event_id = p_event_id
        AND ea.applicant_id = p_user_id
        AND ea.status = 'approved'
    );
    
    RETURN v_is_approved;
END;
$$;


ALTER FUNCTION "public"."can_invite_to_event"("p_user_id" "uuid", "p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_join_event"("p_user_id" "uuid", "p_event_id" "uuid") RETURNS TABLE("can_join" boolean, "join_method" "text", "reason" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_event RECORD;
    v_is_member BOOLEAN;
    v_is_invited BOOLEAN;
    v_has_application BOOLEAN;
    v_application_status event_application_status_enum;
    v_capacity_remaining INTEGER;
BEGIN
    -- Get event details
    SELECT e.*, 
           (SELECT COUNT(*) FROM event_applications ea 
            WHERE ea.event_id = e.id AND ea.status = 'approved') as current_attendees
    INTO v_event
    FROM events e
    WHERE e.id = p_event_id;
    
    IF NOT FOUND THEN
        RETURN QUERY SELECT false, 'none'::TEXT, 'Event not found'::TEXT;
        RETURN;
    END IF;
    
    -- Check if event is active and not ended
    IF v_event.status != 'active' OR v_event.time_end < now() THEN
        RETURN QUERY SELECT false, 'none'::TEXT, 'Event is not active or has ended'::TEXT;
        RETURN;
    END IF;
    
    -- Check capacity
    v_capacity_remaining := v_event.capacity - v_event.current_attendees;
    IF v_capacity_remaining <= 0 THEN
        RETURN QUERY SELECT false, 'none'::TEXT, 'Event is at full capacity'::TEXT;
        RETURN;
    END IF;
    
    -- Check if already has application
    SELECT status INTO v_application_status
    FROM event_applications
    WHERE event_id = p_event_id AND applicant_id = p_user_id;
    
    IF v_application_status = 'approved' THEN
        RETURN QUERY SELECT false, 'none'::TEXT, 'Already joined this event'::TEXT;
        RETURN;
    END IF;
    
    IF v_application_status = 'pending' THEN
        RETURN QUERY SELECT false, 'none'::TEXT, 'Application pending'::TEXT;
        RETURN;
    END IF;
    
    -- Check block status
    IF have_blocked_each_other(p_user_id, v_event.host_id) THEN
        RETURN QUERY SELECT false, 'none'::TEXT, 'Cannot join this event'::TEXT;
        RETURN;
    END IF;
    
    -- Type-specific logic
    CASE v_event.event_type
        -- Public: direct join
        WHEN 'public' THEN
            RETURN QUERY SELECT true, 'direct'::TEXT, 'Can join directly'::TEXT;
            
        -- Public with application: needs approval
        WHEN 'public_application' THEN
            RETURN QUERY SELECT true, 'application'::TEXT, 'Application required'::TEXT;
            
        -- Private: needs approval
        WHEN 'private' THEN
            RETURN QUERY SELECT true, 'application'::TEXT, 'Application required'::TEXT;
            
        -- Invite only: must be invited
        WHEN 'invite_only' THEN
            v_is_invited := EXISTS (
                SELECT 1 FROM event_invites ei
                WHERE ei.event_id = p_event_id
                AND ei.invited_user_id = p_user_id
                AND ei.status = 'pending'
            );
            
            IF v_is_invited THEN
                RETURN QUERY SELECT true, 'invite_accept'::TEXT, 'Accept invite to join'::TEXT;
            ELSE
                RETURN QUERY SELECT false, 'none'::TEXT, 'Invite required'::TEXT;
            END IF;
            
        -- Group event: must be group member
        WHEN 'group_event' THEN
            v_is_member := EXISTS (
                SELECT 1 FROM group_members gm
                WHERE gm.group_id = v_event.group_id
                AND gm.user_id = p_user_id
            );
            
            IF v_is_member THEN
                RETURN QUERY SELECT true, 'direct'::TEXT, 'Can join as group member'::TEXT;
            ELSE
                RETURN QUERY SELECT false, 'none'::TEXT, 'Must be a group member'::TEXT;
            END IF;
            
        -- Community event: must be community member
        WHEN 'community_event' THEN
            v_is_member := EXISTS (
                SELECT 1 FROM community_members cm
                WHERE cm.community_id = v_event.community_id
                AND cm.user_id = p_user_id
            );
            
            IF v_is_member THEN
                RETURN QUERY SELECT true, 'direct'::TEXT, 'Can join as community member'::TEXT;
            ELSE
                RETURN QUERY SELECT false, 'none'::TEXT, 'Must be a community member'::TEXT;
            END IF;
            
        ELSE
            RETURN QUERY SELECT false, 'none'::TEXT, 'Unknown event type'::TEXT;
    END CASE;
END;
$$;


ALTER FUNCTION "public"."can_join_event"("p_user_id" "uuid", "p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_manage_group_photo"("file_path" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_group_id uuid;
    v_folder_name text;
BEGIN
    -- Extract folder name (group_id) from path like "group_id/cover.jpg"
    v_folder_name := split_part(file_path, '/', 1);
    
    -- Try to cast to UUID
    BEGIN
        v_group_id := v_folder_name::uuid;
    EXCEPTION WHEN OTHERS THEN
        RETURN false;
    END;
    
    -- Check if user is the creator of the group
    IF EXISTS (
        SELECT 1 FROM groups g 
        WHERE g.id = v_group_id 
        AND g.created_by = auth.uid()
    ) THEN
        RETURN true;
    END IF;
    
    -- Check if user is owner/admin member of the group
    IF EXISTS (
        SELECT 1 FROM group_members gm
        WHERE gm.group_id = v_group_id
        AND gm.user_id = auth.uid()
        AND gm.role IN ('owner', 'admin')
    ) THEN
        RETURN true;
    END IF;
    
    RETURN false;
END;
$$;


ALTER FUNCTION "public"."can_manage_group_photo"("file_path" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_rate_event"("p_event_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    AS $$
DECLARE
    v_event_ended BOOLEAN;
    v_is_member BOOLEAN;
    v_already_rated BOOLEAN;
BEGIN
    -- Check if event has ended
    SELECT (time_end < now()) INTO v_event_ended
    FROM events WHERE id = p_event_id;
    
    IF NOT v_event_ended THEN
        RETURN false;
    END IF;
    
    -- Check if user is a member (approved application)
    SELECT EXISTS (
        SELECT 1 FROM event_applications
        WHERE event_id = p_event_id
        AND applicant_id = auth.uid()
        AND status = 'approved'
    ) INTO v_is_member;
    
    IF NOT v_is_member THEN
        RETURN false;
    END IF;
    
    -- Check if already rated
    SELECT EXISTS (
        SELECT 1 FROM event_ratings
        WHERE event_id = p_event_id
        AND rater_id = auth.uid()
    ) INTO v_already_rated;
    
    RETURN NOT v_already_rated;
END;
$$;


ALTER FUNCTION "public"."can_rate_event"("p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_see_event"("p_user_id" "uuid", "p_event_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_event_type event_type_enum;
    v_host_id UUID;
    v_group_id UUID;
    v_community_id UUID;
BEGIN
    -- Get event details
    SELECT event_type, host_id, group_id, community_id
    INTO v_event_type, v_host_id, v_group_id, v_community_id
    FROM events
    WHERE id = p_event_id;
    
    IF NOT FOUND THEN
        RETURN false;
    END IF;
    
    -- Check block status
    IF have_blocked_each_other(p_user_id, v_host_id) THEN
        RETURN false;
    END IF;
    
    -- Host can always see their own events
    IF v_host_id = p_user_id THEN
        RETURN true;
    END IF;
    
    CASE v_event_type
        -- Public events: everyone can see
        WHEN 'public', 'public_application', 'private' THEN
            RETURN true;
            
        -- Invite only: only invited users or approved attendees
        WHEN 'invite_only' THEN
            RETURN EXISTS (
                SELECT 1 FROM event_invites ei
                WHERE ei.event_id = p_event_id
                AND ei.invited_user_id = p_user_id
            ) OR EXISTS (
                SELECT 1 FROM event_applications ea
                WHERE ea.event_id = p_event_id
                AND ea.applicant_id = p_user_id
                AND ea.status = 'approved'
            );
            
        -- Group event: only group members
        WHEN 'group_event' THEN
            RETURN EXISTS (
                SELECT 1 FROM group_members gm
                WHERE gm.group_id = v_group_id
                AND gm.user_id = p_user_id
            );
            
        -- Community event: only community members
        WHEN 'community_event' THEN
            RETURN EXISTS (
                SELECT 1 FROM community_members cm
                WHERE cm.community_id = v_community_id
                AND cm.user_id = p_user_id
            );
            
        ELSE
            RETURN false;
    END CASE;
END;
$$;


ALTER FUNCTION "public"."can_see_event"("p_user_id" "uuid", "p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_see_on_map"("me" "uuid", "other" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE
    AS $$
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
$$;


ALTER FUNCTION "public"."can_see_on_map"("me" "uuid", "other" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_send_match_request"("p_requester_id" "uuid", "p_target_id" "uuid") RETURNS TABLE("can_send" boolean, "reason" "text", "context_type" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_can_see_on_map BOOLEAN;
    v_in_same_finished_event BOOLEAN;
    v_in_same_group BOOLEAN;
    v_in_same_community_event BOOLEAN;
    v_already_matched BOOLEAN;
    v_pending_request BOOLEAN;
    v_blocked BOOLEAN;
BEGIN
    v_blocked := have_blocked_each_other(p_requester_id, p_target_id);
    IF v_blocked THEN
        RETURN QUERY SELECT false, 'Users have blocked each other'::TEXT, 'none'::TEXT;
        RETURN;
    END IF;
    
    v_already_matched := EXISTS (
        SELECT 1 FROM match_requests mr
        WHERE ((mr.requester_id = p_requester_id AND mr.target_id = p_target_id)
            OR (mr.requester_id = p_target_id AND mr.target_id = p_requester_id))
        AND mr.status = 'accepted'
    );
    IF v_already_matched THEN
        RETURN QUERY SELECT false, 'Already matched'::TEXT, 'none'::TEXT;
        RETURN;
    END IF;
    
    v_pending_request := EXISTS (
        SELECT 1 FROM match_requests mr
        WHERE ((mr.requester_id = p_requester_id AND mr.target_id = p_target_id)
            OR (mr.requester_id = p_target_id AND mr.target_id = p_requester_id))
        AND mr.status = 'pending'
    );
    IF v_pending_request THEN
        RETURN QUERY SELECT false, 'Request already pending'::TEXT, 'none'::TEXT;
        RETURN;
    END IF;
    
    v_can_see_on_map := can_see_on_map(p_requester_id, p_target_id);
    v_in_same_finished_event := were_in_same_finished_event(p_requester_id, p_target_id);
    v_in_same_group := are_in_same_group(p_requester_id, p_target_id);
    v_in_same_community_event := were_in_same_community_event(p_requester_id, p_target_id);
    
    IF v_in_same_finished_event THEN
        RETURN QUERY SELECT true, 'Met at event'::TEXT, 'event'::TEXT;
        RETURN;
    END IF;
    
    IF v_in_same_group THEN
        RETURN QUERY SELECT true, 'In same group'::TEXT, 'group'::TEXT;
        RETURN;
    END IF;
    
    IF v_in_same_community_event THEN
        RETURN QUERY SELECT true, 'Met at community event'::TEXT, 'community_event'::TEXT;
        RETURN;
    END IF;
    
    IF v_can_see_on_map THEN
        RETURN QUERY SELECT true, 'Nearby'::TEXT, 'proximity'::TEXT;
        RETURN;
    END IF;
    
    RETURN QUERY SELECT false, 'Users not in valid connection context'::TEXT, 'none'::TEXT;
END;
$$;


ALTER FUNCTION "public"."can_send_match_request"("p_requester_id" "uuid", "p_target_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_view_full"("me" "uuid", "other" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE
    AS $$
    SELECT EXISTS(
        SELECT 1 FROM match_requests mr
        WHERE ((mr.requester_id = me AND mr.target_id = other)
            OR (mr.requester_id = other AND mr.target_id = me))
        AND mr.status = 'accepted'
    )
    AND NOT have_blocked_each_other(me, other)
$$;


ALTER FUNCTION "public"."can_view_full"("me" "uuid", "other" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."can_view_preview"("me" "uuid", "other" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE
    AS $$
SELECT
  public.can_see_on_map(me, other)
  AND NOT public.have_blocked_each_other(me, other);
$$;


ALTER FUNCTION "public"."can_view_preview"("me" "uuid", "other" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_user_exists"("user_email" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_catalog'
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 
    FROM auth.users 
    WHERE email = user_email
  );
END;
$$;


ALTER FUNCTION "public"."check_user_exists"("user_email" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_community_conversation"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    INSERT INTO conversations (type, community_id)
    VALUES ('community_chat', NEW.id)
    RETURNING id INTO v_conversation_id;
    
    INSERT INTO conversation_members (conversation_id, user_id)
    VALUES (v_conversation_id, NEW.created_by);
    
    INSERT INTO community_members (community_id, user_id, role)
    VALUES (NEW.id, NEW.created_by, 'owner')
    ON CONFLICT DO NOTHING;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."create_community_conversation"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_event_group_chat"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    -- Create event group chat conversation
    INSERT INTO conversations (type, event_id)
    VALUES ('event_group', NEW.id)
    RETURNING id INTO v_conversation_id;
    
    -- Add host as first member
    INSERT INTO conversation_members (conversation_id, user_id)
    VALUES (v_conversation_id, NEW.host_id);
    
    -- For group events, add all group members
    IF NEW.event_type = 'group_event' AND NEW.group_id IS NOT NULL THEN
        INSERT INTO conversation_members (conversation_id, user_id)
        SELECT v_conversation_id, gm.user_id
        FROM group_members gm
        WHERE gm.group_id = NEW.group_id
        AND gm.user_id != NEW.host_id
        ON CONFLICT DO NOTHING;
        
        -- Auto-approve all group members
        INSERT INTO event_applications (event_id, applicant_id, status)
        SELECT NEW.id, gm.user_id, 'approved'
        FROM group_members gm
        WHERE gm.group_id = NEW.group_id
        ON CONFLICT DO NOTHING;
    END IF;
    
    -- For community events, don't auto-add members (they join manually)
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."create_event_group_chat"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_event_v2"("p_event_data" "jsonb") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_event_id UUID;
    v_user_id UUID := auth.uid();
    v_event_type event_type_enum;
    v_group_id UUID;
    v_community_id UUID;
BEGIN
    v_event_type := (p_event_data->>'event_type')::event_type_enum;
    v_group_id := (p_event_data->>'group_id')::UUID;
    v_community_id := (p_event_data->>'community_id')::UUID;
    
    -- Validate group event
    IF v_event_type = 'group_event' THEN
        IF v_group_id IS NULL THEN
            RAISE EXCEPTION 'group_id is required for group events';
        END IF;
        -- Check if user is group member
        IF NOT EXISTS (
            SELECT 1 FROM group_members gm
            WHERE gm.group_id = v_group_id AND gm.user_id = v_user_id
        ) THEN
            RAISE EXCEPTION 'Must be a group member to create group events';
        END IF;
    END IF;
    
    -- Validate community event
    IF v_event_type = 'community_event' THEN
        IF v_community_id IS NULL THEN
            RAISE EXCEPTION 'community_id is required for community events';
        END IF;
        -- Check if user is community admin/owner
        IF NOT EXISTS (
            SELECT 1 FROM community_members cm
            WHERE cm.community_id = v_community_id 
            AND cm.user_id = v_user_id
            AND cm.role IN ('owner', 'admin')
        ) THEN
            RAISE EXCEPTION 'Must be a community admin or owner to create community events';
        END IF;
    END IF;
    
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
        status,
        event_type,
        group_id,
        community_id,
        allow_member_invites,
        requires_approval,
        fuzzy_radius_meters
    ) VALUES (
        v_user_id,
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
        COALESCE((p_event_data->>'capacity')::integer, 50),
        COALESCE((p_event_data->>'gender_allowed')::gender_filter_enum, 'Everyone'),
        COALESCE((p_event_data->>'age_min')::integer, 18),
        COALESCE((p_event_data->>'age_max')::integer, 99),
        'active',
        v_event_type,
        v_group_id,
        v_community_id,
        COALESCE((p_event_data->>'allow_member_invites')::boolean, false),
        CASE v_event_type
            WHEN 'public' THEN false
            ELSE COALESCE((p_event_data->>'requires_approval')::boolean, true)
        END,
        COALESCE((p_event_data->>'fuzzy_radius_meters')::integer, 500)
    ) RETURNING id INTO v_event_id;
    
    RETURN v_event_id;
END;
$$;


ALTER FUNCTION "public"."create_event_v2"("p_event_data" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_event_with_location"("p_event_data" json) RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_event_id uuid;
  v_event_type public.event_type_enum;
  v_requires_approval boolean;
BEGIN
  -- Determine event_type from input or default to 'public'
  v_event_type := COALESCE(
    (p_event_data->>'event_type')::public.event_type_enum, 
    'public'::public.event_type_enum
  );
  
  -- Set requires_approval based on event_type
  v_requires_approval := CASE 
    WHEN v_event_type IN ('public_application', 'private') THEN true
    ELSE false
  END;

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
    status,
    event_type,
    requires_approval,
    visibility
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
    COALESCE((p_event_data->>'status')::event_status_enum, 'active'),
    v_event_type,
    v_requires_approval,
    -- Map event_type to visibility for backwards compatibility
    CASE 
      WHEN v_event_type = 'private' THEN 'private'::event_visibility_enum
      WHEN v_event_type = 'invite_only' THEN 'invite_only'::event_visibility_enum
      ELSE 'public'::event_visibility_enum
    END
  ) RETURNING id INTO v_event_id;
  
  RETURN v_event_id;
END;
$$;


ALTER FUNCTION "public"."create_event_with_location"("p_event_data" json) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_group_conversation"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    INSERT INTO conversations (type, group_id)
    VALUES ('group_chat', NEW.id)
    RETURNING id INTO v_conversation_id;
    
    INSERT INTO conversation_members (conversation_id, user_id)
    VALUES (v_conversation_id, NEW.created_by);
    
    INSERT INTO group_members (group_id, user_id, role)
    VALUES (NEW.id, NEW.created_by, 'owner')
    ON CONFLICT DO NOTHING;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."create_group_conversation"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."current_user_id"() RETURNS "uuid"
    LANGUAGE "plpgsql" STABLE
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
BEGIN
  RETURN current_setting('request.jwt.claim.sub', true)::uuid;
END;
$$;


ALTER FUNCTION "public"."current_user_id"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."decline_group_invite"("p_invite_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_invite RECORD;
BEGIN
    -- Get invite and verify ownership
    SELECT * INTO v_invite
    FROM group_invites
    WHERE id = p_invite_id
    AND invited_user_id = auth.uid()
    AND status = 'pending';
    
    IF v_invite IS NULL THEN
        RAISE EXCEPTION 'Invite not found or already processed';
    END IF;
    
    -- Update invite status
    UPDATE group_invites
    SET status = 'declined'
    WHERE id = p_invite_id;
    
    RETURN true;
END;
$$;


ALTER FUNCTION "public"."decline_group_invite"("p_invite_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."enforce_hobby_count"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO 'public', 'pg_catalog'
    AS $$
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
$$;


ALTER FUNCTION "public"."enforce_hobby_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."enforce_hobby_count_stmt"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO 'public', 'pg_catalog'
    AS $$
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
$$;


ALTER FUNCTION "public"."enforce_hobby_count_stmt"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."enforce_photo_max_4"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO 'public', 'pg_catalog'
    AS $$
declare cnt int;
begin
  select count(*) into cnt from public.user_photos where user_id = new.user_id;
  if cnt >= 4 then
    raise exception 'A user can have at most 4 photos';
  end if;
  return new;
end;
$$;


ALTER FUNCTION "public"."enforce_photo_max_4"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."expire_ended_events"() RETURNS "void"
    LANGUAGE "sql"
    AS $$
    UPDATE events
    SET status = 'expired'
    WHERE status = 'active'
    AND time_end < now()
$$;


ALTER FUNCTION "public"."expire_ended_events"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."frames_after_insert_set_pointer"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Point profile to this new frame (if not expired)
  IF NEW.expires_at > NOW() THEN
    UPDATE public.profiles
       SET frame_id = NEW.id
     WHERE id = NEW.user_id;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."frames_after_insert_set_pointer"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."frames_after_update_clear_pointer"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."frames_after_update_clear_pointer"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."frames_before_insert_rotate"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Set default expiry if not provided
  IF NEW.expires_at IS NULL THEN
    NEW.expires_at := NOW() + INTERVAL '24 hours';
  END IF;

  -- Don't delete anything - just let frames expire naturally
  -- The profile pointer will be updated by the AFTER INSERT trigger
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."frames_before_insert_rotate"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_all_events_with_coordinates"() RETURNS TABLE("id" "uuid", "host_id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "event_description" "text", "location_name" "text", "time_start" timestamp with time zone, "time_end" timestamp with time zone, "capacity" integer, "gender_allowed" "public"."gender_filter_enum", "age_min" integer, "age_max" integer, "status" "public"."event_status_enum", "created_at" timestamp with time zone, "updated_at" timestamp with time zone, "latitude" double precision, "longitude" double precision)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
$$;


ALTER FUNCTION "public"."get_all_events_with_coordinates"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_community_members_basic"("p_community_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "main_photo_url" "text", "looking_for" "text"[], "role" "public"."member_role_enum", "joined_at" timestamp with time zone, "is_matched" boolean, "can_match_via_proximity" boolean, "can_match_via_event" boolean, "access_level" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM community_members cm
        WHERE cm.community_id = p_community_id AND cm.user_id = v_user_id
    ) THEN
        RAISE EXCEPTION 'Not a member of this community';
    END IF;
    
    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt) as bio,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as main_photo_url,
        p.looking_for::text[],
        cm.role,
        cm.joined_at,
        EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status = 'accepted'
        ) as is_matched,
        can_see_on_map(v_user_id, p.id) as can_match_via_proximity,
        were_in_same_community_event(v_user_id, p.id) as can_match_via_event,
        get_profile_access_level(v_user_id, p.id) as access_level
    FROM community_members cm
    JOIN profiles p ON p.id = cm.user_id
    WHERE cm.community_id = p_community_id
    AND cm.user_id != v_user_id
    AND NOT have_blocked_each_other(v_user_id, cm.user_id)
    ORDER BY cm.role, cm.joined_at;
END;
$$;


ALTER FUNCTION "public"."get_community_members_basic"("p_community_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_connection_options"("p_target_id" "uuid") RETURNS TABLE("can_connect" boolean, "context_type" "text", "reason" "text", "shared_events" "uuid"[], "shared_groups" "uuid"[], "shared_communities" "uuid"[])
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    RETURN QUERY
    WITH check_result AS (
        SELECT * FROM can_send_match_request(v_user_id, p_target_id)
    ),
    shared_event_ids AS (
        SELECT ARRAY_AGG(DISTINCT ea1.event_id) as ids
        FROM event_applications ea1
        JOIN event_applications ea2 ON ea1.event_id = ea2.event_id
        JOIN events e ON e.id = ea1.event_id
        WHERE ea1.applicant_id = v_user_id
        AND ea2.applicant_id = p_target_id
        AND ea1.status = 'approved'
        AND ea2.status = 'approved'
        AND e.time_end < now()
    ),
    shared_group_ids AS (
        SELECT ARRAY_AGG(DISTINCT gm1.group_id) as ids
        FROM group_members gm1
        JOIN group_members gm2 ON gm1.group_id = gm2.group_id
        WHERE gm1.user_id = v_user_id
        AND gm2.user_id = p_target_id
    ),
    shared_community_ids AS (
        SELECT ARRAY_AGG(DISTINCT cm1.community_id) as ids
        FROM community_members cm1
        JOIN community_members cm2 ON cm1.community_id = cm2.community_id
        WHERE cm1.user_id = v_user_id
        AND cm2.user_id = p_target_id
    )
    SELECT 
        cr.can_send,
        cr.context_type,
        cr.reason,
        COALESCE(se.ids, ARRAY[]::UUID[]),
        COALESCE(sg.ids, ARRAY[]::UUID[]),
        COALESCE(sc.ids, ARRAY[]::UUID[])
    FROM check_result cr
    CROSS JOIN shared_event_ids se
    CROSS JOIN shared_group_ids sg
    CROSS JOIN shared_community_ids sc;
END;
$$;


ALTER FUNCTION "public"."get_connection_options"("p_target_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_event_applications_for_host"("p_event_id" "uuid") RETURNS TABLE("application_id" "uuid", "applicant_id" "uuid", "status" "public"."event_application_status_enum", "message" "text", "created_at" timestamp with time zone, "updated_at" timestamp with time zone, "applicant_name" "text", "applicant_age" integer, "applicant_bio" "text", "applicant_photo_url" "text", "applicant_looking_for" "text"[], "access_level" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_host_id UUID;
BEGIN
    SELECT host_id INTO v_host_id FROM events WHERE id = p_event_id;
    
    IF v_host_id IS NULL THEN
        RAISE EXCEPTION 'Event not found';
    END IF;
    
    IF v_host_id != v_user_id THEN
        RAISE EXCEPTION 'Not authorized - not the host';
    END IF;
    
    RETURN QUERY
    SELECT 
        ea.id as application_id,
        ea.applicant_id,
        ea.status,
        ea.message,
        ea.created_at,
        ea.updated_at,
        p.full_name as applicant_name,
        p.age as applicant_age,
        COALESCE(p.bio, p.prompt) as applicant_bio,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as applicant_photo_url,
        p.looking_for::text[] as applicant_looking_for,
        get_profile_access_level(v_user_id, ea.applicant_id) as access_level
    FROM event_applications ea
    JOIN profiles p ON p.id = ea.applicant_id
    WHERE ea.event_id = p_event_id
    AND NOT have_blocked_each_other(v_user_id, ea.applicant_id)
    ORDER BY 
        CASE ea.status 
            WHEN 'pending' THEN 1 
            WHEN 'approved' THEN 2 
            WHEN 'rejected' THEN 3
            ELSE 4
        END,
        ea.created_at DESC;
END;
$$;


ALTER FUNCTION "public"."get_event_applications_for_host"("p_event_id" "uuid") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."get_event_applications_for_host"("p_event_id" "uuid") IS 'Returns all applications for an event, with applicant profile data and access levels. Only callable by the event host.';



CREATE OR REPLACE FUNCTION "public"."get_event_host_id"("p_event_id" "uuid") RETURNS "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT host_id FROM events WHERE id = p_event_id;
$$;


ALTER FUNCTION "public"."get_event_host_id"("p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_event_members"("p_event_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "is_host" boolean, "joined_at" timestamp with time zone, "main_photo_url" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    AS $$
DECLARE
    v_host_id UUID;
BEGIN
    -- Get host id
    SELECT host_id INTO v_host_id FROM events WHERE id = p_event_id;
    
    RETURN QUERY
    SELECT 
        ea.applicant_id,
        p.full_name,
        (ea.applicant_id = v_host_id) AS is_host,
        ea.created_at AS joined_at,
        (SELECT up.photo_url FROM user_photos up 
         WHERE up.user_id = ea.applicant_id AND up.is_main = true 
         LIMIT 1) AS main_photo_url
    FROM event_applications ea
    JOIN profiles p ON ea.applicant_id = p.id
    WHERE ea.event_id = p_event_id
    AND ea.status = 'approved'
    
    UNION
    
    -- Include host even if not in applications
    SELECT 
        v_host_id,
        p.full_name,
        true AS is_host,
        e.created_at AS joined_at,
        (SELECT up.photo_url FROM user_photos up 
         WHERE up.user_id = v_host_id AND up.is_main = true 
         LIMIT 1) AS main_photo_url
    FROM events e
    JOIN profiles p ON e.host_id = p.id
    WHERE e.id = p_event_id
    
    ORDER BY is_host DESC, joined_at ASC;
END;
$$;


ALTER FUNCTION "public"."get_event_members"("p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_event_participants_preview"("p_event_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "main_photo_url" "text", "frame_id" "uuid", "looking_for" "text"[], "is_host" boolean, "joined_at" timestamp with time zone, "is_matched" boolean, "can_send_request" boolean, "request_context" "text", "access_level" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_host_id UUID;
    v_is_participant BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM event_applications ea
        WHERE ea.event_id = p_event_id
        AND ea.applicant_id = v_user_id
        AND ea.status = 'approved'
    ) INTO v_is_participant;
    
    SELECT host_id INTO v_host_id FROM events WHERE id = p_event_id;
    
    IF v_user_id = v_host_id THEN
        v_is_participant := true;
    END IF;
    
    IF NOT v_is_participant THEN
        RAISE EXCEPTION 'Not a participant of this event';
    END IF;
    
    RETURN QUERY
    WITH participants AS (
        SELECT ea.applicant_id as pid, ea.created_at as join_time
        FROM event_applications ea
        WHERE ea.event_id = p_event_id AND ea.status = 'approved'
        
        UNION
        
        SELECT e.host_id as pid, e.created_at as join_time
        FROM events e
        WHERE e.id = p_event_id
    )
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt) as bio,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as main_photo_url,
        CASE 
            WHEN get_profile_access_level(v_user_id, p.id) = 'full' 
            THEN p.frame_id 
            ELSE NULL 
        END as frame_id,
        p.looking_for::text[],
        (p.id = v_host_id) as is_host,
        part.join_time as joined_at,
        EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status = 'accepted'
        ) as is_matched,
        NOT EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status IN ('pending', 'accepted')
        ) AND NOT have_blocked_each_other(v_user_id, p.id) as can_send_request,
        'event'::text as request_context,
        get_profile_access_level(v_user_id, p.id) as access_level
    FROM participants part
    JOIN profiles p ON p.id = part.pid
    WHERE p.id != v_user_id
    AND NOT have_blocked_each_other(v_user_id, p.id)
    ORDER BY (p.id = v_host_id) DESC, part.join_time ASC;
END;
$$;


ALTER FUNCTION "public"."get_event_participants_preview"("p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_events_by_type"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer DEFAULT 30, "p_event_types" "public"."event_type_enum"[] DEFAULT NULL::"public"."event_type_enum"[]) RETURNS TABLE("id" "uuid", "host_id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "event_description" "text", "location_name" "text", "time_start" timestamp with time zone, "time_end" timestamp with time zone, "capacity" integer, "current_attendees" bigint, "gender_allowed" "public"."gender_filter_enum", "age_min" integer, "age_max" integer, "status" "public"."event_status_enum", "event_type" "public"."event_type_enum", "latitude" double precision, "longitude" double precision, "is_exact_location" boolean, "distance_km" double precision, "can_join" boolean, "join_method" "text", "group_id" "uuid", "group_name" "text", "community_id" "uuid", "community_name" "text", "allow_member_invites" boolean)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    RETURN QUERY
    WITH event_attendees AS (
        SELECT ea.event_id, COUNT(*) as attendee_count
        FROM event_applications ea
        WHERE ea.status = 'approved'
        GROUP BY ea.event_id
    ),
    user_groups AS (
        SELECT gm.group_id FROM group_members gm WHERE gm.user_id = v_user_id
    ),
    user_communities AS (
        SELECT cm.community_id FROM community_members cm WHERE cm.user_id = v_user_id
    ),
    user_invites AS (
        SELECT ei.event_id FROM event_invites ei 
        WHERE ei.invited_user_id = v_user_id
    ),
    user_approved AS (
        SELECT ea.event_id FROM event_applications ea
        WHERE ea.applicant_id = v_user_id AND ea.status = 'approved'
    )
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
        COALESCE(att.attendee_count, 0) as current_attendees,
        e.gender_allowed,
        e.age_min,
        e.age_max,
        e.status,
        e.event_type,
        -- Location logic: fuzzy for private events unless approved
        CASE 
            WHEN e.event_type = 'private' 
                AND e.host_id != v_user_id
                AND NOT EXISTS (SELECT 1 FROM user_approved ua WHERE ua.event_id = e.id)
            THEN ST_Y(e.location::geometry) + (random() - 0.5) * (e.fuzzy_radius_meters::DOUBLE PRECISION / 111000)
            ELSE ST_Y(e.location::geometry)
        END AS latitude,
        CASE 
            WHEN e.event_type = 'private' 
                AND e.host_id != v_user_id
                AND NOT EXISTS (SELECT 1 FROM user_approved ua WHERE ua.event_id = e.id)
            THEN ST_X(e.location::geometry) + (random() - 0.5) * (e.fuzzy_radius_meters::DOUBLE PRECISION / (111000 * cos(radians(ST_Y(e.location::geometry)))))
            ELSE ST_X(e.location::geometry)
        END AS longitude,
        -- Is exact location
        (e.event_type != 'private' 
            OR e.host_id = v_user_id
            OR EXISTS (SELECT 1 FROM user_approved ua WHERE ua.event_id = e.id)
        ) AS is_exact_location,
        -- Distance
        ST_Distance(
            e.location,
            ST_SetSRID(ST_MakePoint(p_user_lng, p_user_lat), 4326)::geography
        ) / 1000 AS distance_km,
        -- Can join (simplified - use can_join_event for full check)
        CASE e.event_type
            WHEN 'public' THEN true
            WHEN 'public_application' THEN true
            WHEN 'private' THEN true
            WHEN 'invite_only' THEN EXISTS (SELECT 1 FROM user_invites ui WHERE ui.event_id = e.id)
            WHEN 'group_event' THEN EXISTS (SELECT 1 FROM user_groups ug WHERE ug.group_id = e.group_id)
            WHEN 'community_event' THEN EXISTS (SELECT 1 FROM user_communities uc WHERE uc.community_id = e.community_id)
        END AS can_join,
        -- Join method
        CASE e.event_type
            WHEN 'public' THEN 'direct'
            WHEN 'public_application' THEN 'application'
            WHEN 'private' THEN 'application'
            WHEN 'invite_only' THEN 'invite'
            WHEN 'group_event' THEN 'direct'
            WHEN 'community_event' THEN 'direct'
        END AS join_method,
        e.group_id,
        g.name as group_name,
        e.community_id,
        c.name as community_name,
        e.allow_member_invites
    FROM events e
    LEFT JOIN event_attendees att ON att.event_id = e.id
    LEFT JOIN groups g ON g.id = e.group_id
    LEFT JOIN communities c ON c.id = e.community_id
    WHERE e.status = 'active'
        AND e.time_end > now()
        AND NOT have_blocked_each_other(v_user_id, e.host_id)
        -- Filter by event types if specified
        AND (p_event_types IS NULL OR e.event_type = ANY(p_event_types))
        -- Visibility logic
        AND (
            -- Public types: check distance
            (e.event_type IN ('public', 'public_application', 'private') 
                AND ST_DWithin(
                    e.location,
                    ST_SetSRID(ST_MakePoint(p_user_lng, p_user_lat), 4326)::geography,
                    p_radius_km * 1000
                )
            )
            -- Invite only: must be host, invited, or approved
            OR (e.event_type = 'invite_only' 
                AND (
                    e.host_id = v_user_id
                    OR EXISTS (SELECT 1 FROM user_invites ui WHERE ui.event_id = e.id)
                    OR EXISTS (SELECT 1 FROM user_approved ua WHERE ua.event_id = e.id)
                )
            )
            -- Group event: must be group member
            OR (e.event_type = 'group_event' 
                AND EXISTS (SELECT 1 FROM user_groups ug WHERE ug.group_id = e.group_id)
            )
            -- Community event: must be community member
            OR (e.event_type = 'community_event' 
                AND EXISTS (SELECT 1 FROM user_communities uc WHERE uc.community_id = e.community_id)
            )
        )
    ORDER BY e.time_start ASC;
END;
$$;


ALTER FUNCTION "public"."get_events_by_type"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer, "p_event_types" "public"."event_type_enum"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_events_with_coordinates"("p_status" "public"."event_status_enum" DEFAULT 'active'::"public"."event_status_enum") RETURNS TABLE("id" "uuid", "host_id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "event_description" "text", "location_name" "text", "time_start" timestamp with time zone, "time_end" timestamp with time zone, "capacity" integer, "gender_allowed" "public"."gender_filter_enum", "age_min" integer, "age_max" integer, "status" "public"."event_status_enum", "created_at" timestamp with time zone, "updated_at" timestamp with time zone, "latitude" double precision, "longitude" double precision)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
$$;


ALTER FUNCTION "public"."get_events_with_coordinates"("p_status" "public"."event_status_enum") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_events_with_visibility"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer DEFAULT 30) RETURNS TABLE("id" "uuid", "host_id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "event_description" "text", "location_name" "text", "time_start" timestamp with time zone, "time_end" timestamp with time zone, "capacity" integer, "gender_allowed" "public"."gender_filter_enum", "age_min" integer, "age_max" integer, "status" "public"."event_status_enum", "visibility" "public"."event_visibility_enum", "latitude" double precision, "longitude" double precision, "is_exact_location" boolean, "distance_km" double precision)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
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
        e.visibility,
        CASE 
            WHEN e.visibility = 'private' 
                AND e.host_id != v_user_id
                AND NOT EXISTS (
                    SELECT 1 FROM event_applications ea 
                    WHERE ea.event_id = e.id 
                    AND ea.applicant_id = v_user_id 
                    AND ea.status = 'approved'
                )
            THEN ST_Y(e.location::geometry) + (random() - 0.5) * (e.fuzzy_radius_meters::DOUBLE PRECISION / 111000)
            ELSE ST_Y(e.location::geometry)
        END AS latitude,
        CASE 
            WHEN e.visibility = 'private' 
                AND e.host_id != v_user_id
                AND NOT EXISTS (
                    SELECT 1 FROM event_applications ea 
                    WHERE ea.event_id = e.id 
                    AND ea.applicant_id = v_user_id 
                    AND ea.status = 'approved'
                )
            THEN ST_X(e.location::geometry) + (random() - 0.5) * (e.fuzzy_radius_meters::DOUBLE PRECISION / (111000 * cos(radians(ST_Y(e.location::geometry)))))
            ELSE ST_X(e.location::geometry)
        END AS longitude,
        (e.visibility != 'private' 
            OR e.host_id = v_user_id
            OR EXISTS (
                SELECT 1 FROM event_applications ea 
                WHERE ea.event_id = e.id 
                AND ea.applicant_id = v_user_id 
                AND ea.status = 'approved'
            )
        ) AS is_exact_location,
        ST_Distance(
            e.location,
            ST_SetSRID(ST_MakePoint(p_user_lng, p_user_lat), 4326)::geography
        ) / 1000 AS distance_km
    FROM events e
    WHERE e.status = 'active'
        AND e.time_end > now()
        AND NOT have_blocked_each_other(v_user_id, e.host_id)
        AND (
            (e.visibility IN ('public', 'private') 
                AND ST_DWithin(
                    e.location,
                    ST_SetSRID(ST_MakePoint(p_user_lng, p_user_lat), 4326)::geography,
                    p_radius_km * 1000
                )
            )
            OR (e.visibility = 'invite_only' 
                AND (
                    e.host_id = v_user_id
                    OR EXISTS (
                        SELECT 1 FROM event_invites ei 
                        WHERE ei.event_id = e.id 
                        AND ei.invited_user_id = v_user_id
                    )
                )
            )
        )
    ORDER BY e.time_start ASC;
END;
$$;


ALTER FUNCTION "public"."get_events_with_visibility"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_finished_event_participants"("p_event_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "main_photo_url" "text", "looking_for" "text"[], "is_host" boolean, "can_match" boolean, "is_already_matched" boolean, "access_level" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_event_finished BOOLEAN;
    v_host_id UUID;
BEGIN
    SELECT (time_end < now()), host_id INTO v_event_finished, v_host_id
    FROM events WHERE id = p_event_id;
    
    IF NOT v_event_finished THEN
        RAISE EXCEPTION 'Event has not finished yet';
    END IF;
    
    IF NOT EXISTS (
        SELECT 1 FROM event_applications ea
        WHERE ea.event_id = p_event_id
        AND ea.applicant_id = v_user_id
        AND ea.status = 'approved'
    ) AND v_host_id != v_user_id THEN
        RAISE EXCEPTION 'Not a participant of this event';
    END IF;
    
    RETURN QUERY
    WITH participants AS (
        SELECT ea.applicant_id as pid
        FROM event_applications ea
        WHERE ea.event_id = p_event_id AND ea.status = 'approved'
        UNION
        SELECT e.host_id as pid FROM events e WHERE e.id = p_event_id
    )
    SELECT 
        p.id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt),
        (SELECT up.photo_url FROM user_photos up WHERE up.user_id = p.id ORDER BY up.is_main DESC LIMIT 1),
        p.looking_for::text[],
        (p.id = v_host_id),
        NOT EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status IN ('pending', 'accepted')
        ) AND NOT have_blocked_each_other(v_user_id, p.id),
        EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status = 'accepted'
        ),
        get_profile_access_level(v_user_id, p.id)
    FROM participants part
    JOIN profiles p ON p.id = part.pid
    WHERE p.id != v_user_id
    AND NOT have_blocked_each_other(v_user_id, p.id);
END;
$$;


ALTER FUNCTION "public"."get_finished_event_participants"("p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_group_members_for_invitee"("p_group_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "avatar_url" "text", "role" "text", "status" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    -- Check if user is either a member OR has a pending invite
    IF NOT EXISTS (
        SELECT 1 FROM group_members gm
        WHERE gm.group_id = p_group_id AND gm.user_id = v_user_id
    ) AND NOT EXISTS (
        SELECT 1 FROM group_invites gi
        WHERE gi.group_id = p_group_id 
        AND gi.invited_user_id = v_user_id 
        AND gi.status = 'pending'
    ) THEN
        RAISE EXCEPTION 'Not a member or invitee of this group';
    END IF;
    
    -- Return active members
    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id AND up.is_main = true
            LIMIT 1
        ) as avatar_url,
        gm.role::text,
        'active'::text as status
    FROM group_members gm
    JOIN profiles p ON p.id = gm.user_id
    WHERE gm.group_id = p_group_id
    ORDER BY 
        CASE gm.role 
            WHEN 'owner' THEN 0 
            WHEN 'admin' THEN 1 
            ELSE 2 
        END,
        gm.joined_at ASC;
END;
$$;


ALTER FUNCTION "public"."get_group_members_for_invitee"("p_group_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_group_members_with_connections"("p_group_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "main_photo_url" "text", "frame_id" "uuid", "looking_for" "text"[], "role" "public"."member_role_enum", "joined_at" timestamp with time zone, "is_matched" boolean, "can_send_request" boolean, "has_pending_request" boolean, "access_level" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM group_members gm
        WHERE gm.group_id = p_group_id AND gm.user_id = v_user_id
    ) THEN
        RAISE EXCEPTION 'Not a member of this group';
    END IF;
    
    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt) as bio,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as main_photo_url,
        CASE 
            WHEN get_profile_access_level(v_user_id, p.id) = 'full' 
            THEN p.frame_id 
            ELSE NULL 
        END as frame_id,
        p.looking_for::text[],
        gm.role,
        gm.joined_at,
        EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status = 'accepted'
        ) as is_matched,
        NOT EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status IN ('pending', 'accepted')
        ) AND NOT have_blocked_each_other(v_user_id, p.id) as can_send_request,
        EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE ((mr.requester_id = v_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_user_id))
            AND mr.status = 'pending'
        ) as has_pending_request,
        get_profile_access_level(v_user_id, p.id) as access_level
    FROM group_members gm
    JOIN profiles p ON p.id = gm.user_id
    WHERE gm.group_id = p_group_id
    AND gm.user_id != v_user_id
    AND NOT have_blocked_each_other(v_user_id, gm.user_id)
    ORDER BY gm.role, gm.joined_at;
END;
$$;


ALTER FUNCTION "public"."get_group_members_with_connections"("p_group_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_group_pending_invites_for_invitee"("p_group_id" "uuid", "p_exclude_invite_id" "uuid" DEFAULT NULL::"uuid") RETURNS TABLE("invite_id" "uuid", "user_id" "uuid", "full_name" "text", "avatar_url" "text", "role" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    -- Check if user is either a member OR has a pending invite
    IF NOT EXISTS (
        SELECT 1 FROM group_members gm
        WHERE gm.group_id = p_group_id AND gm.user_id = v_user_id
    ) AND NOT EXISTS (
        SELECT 1 FROM group_invites gi
        WHERE gi.group_id = p_group_id 
        AND gi.invited_user_id = v_user_id 
        AND gi.status = 'pending'
    ) THEN
        RAISE EXCEPTION 'Not a member or invitee of this group';
    END IF;
    
    -- Return pending invitees (excluding current user's invite if specified)
    RETURN QUERY
    SELECT 
        gi.id as invite_id,
        p.id as user_id,
        p.full_name,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id AND up.is_main = true
            LIMIT 1
        ) as avatar_url,
        gi.role::text
    FROM group_invites gi
    JOIN profiles p ON p.id = gi.invited_user_id
    WHERE gi.group_id = p_group_id
    AND gi.status = 'pending'
    AND (p_exclude_invite_id IS NULL OR gi.id != p_exclude_invite_id)
    ORDER BY gi.created_at ASC;
END;
$$;


ALTER FUNCTION "public"."get_group_pending_invites_for_invitee"("p_group_id" "uuid", "p_exclude_invite_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_host_rating_summary"("p_host_id" "uuid") RETURNS TABLE("total_events_hosted" bigint, "total_ratings" bigint, "average_rating" numeric)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
    SELECT 
        COUNT(DISTINCT e.id) AS total_events_hosted,
        COUNT(DISTINCT er.id) AS total_ratings,
        ROUND(AVG(er.rating), 1) AS average_rating
    FROM events e
    LEFT JOIN event_ratings er ON e.id = er.event_id
    WHERE e.host_id = p_host_id
    AND e.status IN ('finished', 'expired');
$$;


ALTER FUNCTION "public"."get_host_rating_summary"("p_host_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_host_ratings"() RETURNS TABLE("host_id" "uuid", "total_ratings" bigint, "average_rating" numeric, "min_rating" numeric, "max_rating" numeric)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
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
$$;


ALTER FUNCTION "public"."get_host_ratings"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_map_cards"() RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "frame_id" "text", "approx_lat" numeric, "approx_lng" numeric, "main_photo_url" "text", "looking_for" "text"[], "access_level" "text")
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_current_user_id uuid := auth.uid();
BEGIN
    IF v_current_user_id IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;

    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt) as bio,
        CASE 
            WHEN get_profile_access_level(v_current_user_id, p.id) = 'full' 
            THEN p.frame_id::text 
            ELSE NULL 
        END as frame_id,
        ROUND(
            p.lat::numeric + 
            ((abs(hashtext(p.id::text)) % 20000 - 10000) / 1000000.0)::numeric, 
            6
        ) as approx_lat,
        ROUND(
            p.lng::numeric + 
            ((abs(hashtext(p.id::text || 'lng')) % 20000 - 10000) / 1000000.0)::numeric, 
            6
        ) as approx_lng,
        (
            SELECT up.photo_url
            FROM user_photos up 
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as main_photo_url,
        p.looking_for::text[] as looking_for,
        get_profile_access_level(v_current_user_id, p.id) as access_level
    FROM profiles p
    WHERE 
        p.id != v_current_user_id
        AND can_see_on_map(v_current_user_id, p.id)
        AND NOT EXISTS(
            SELECT 1 FROM match_requests mr
            WHERE mr.status = 'denied'
            AND ((mr.requester_id = v_current_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_current_user_id))
        )
        AND NOT have_blocked_each_other(v_current_user_id, p.id)
    ORDER BY p.last_seen DESC;
END;
$$;


ALTER FUNCTION "public"."get_map_cards"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_map_cards_live"() RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "frame_id" "uuid", "approx_lat" numeric, "approx_lng" numeric, "main_photo_url" "text", "looking_for" "text"[], "last_seen" timestamp with time zone, "access_level" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
DECLARE
    v_current_user_id uuid := auth.uid();
BEGIN
    IF v_current_user_id IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;

    RETURN QUERY
    SELECT 
        p.id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt),
        CASE 
            WHEN get_profile_access_level(v_current_user_id, p.id) = 'full' 
            THEN p.frame_id 
            ELSE NULL 
        END,
        ROUND(
            p.lat + 
            ((abs(hashtext(p.id::text)) % 20000 - 10000) / 1000000.0)::numeric,
            6
        ),
        ROUND(
            p.lng + 
            ((abs(hashtext(p.id::text || 'lng')) % 20000 - 10000) / 1000000.0)::numeric,
            6
        ),
        (
            SELECT up.photo_url
            FROM user_photos up 
            WHERE up.user_id = p.id 
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ),
        p.looking_for::text[],
        p.last_seen,
        get_profile_access_level(v_current_user_id, p.id)
    FROM profiles p
    WHERE 
        p.last_seen > (now() - interval '5 minutes')
        AND can_see_on_map(v_current_user_id, p.id)
        AND NOT EXISTS(
            SELECT 1 FROM match_requests mr
            WHERE mr.status = 'denied'
            AND ((mr.requester_id = v_current_user_id AND mr.target_id = p.id)
                OR (mr.requester_id = p.id AND mr.target_id = v_current_user_id))
        )
        AND NOT have_blocked_each_other(v_current_user_id, p.id)
        AND p.id != v_current_user_id
    ORDER BY p.last_seen DESC;
END;
$$;


ALTER FUNCTION "public"."get_map_cards_live"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_match_status"("target_user_id" "uuid") RETURNS TABLE("status" "public"."match_status_enum", "is_requester" boolean, "match_id" "uuid")
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        mr.status,
        (mr.requester_id = auth.uid()) as is_requester,
        mr.id as match_id
    FROM match_requests mr
    WHERE ((mr.requester_id = auth.uid() AND mr.target_id = target_user_id)
        OR (mr.requester_id = target_user_id AND mr.target_id = auth.uid()))
    ORDER BY mr.created_at DESC
    LIMIT 1;
END;
$$;


ALTER FUNCTION "public"."get_match_status"("target_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_match_status_extended"("target_user_id" "uuid") RETURNS TABLE("status" "public"."match_status_enum", "is_requester" boolean, "match_id" "uuid", "sender_message" "text", "created_at" timestamp with time zone, "responded_at" timestamp with time zone)
    LANGUAGE "sql" STABLE
    AS $$
    SELECT 
        mr.status,
        (mr.requester_id = auth.uid()) as is_requester,
        mr.id as match_id,
        mr.sender_message,
        mr.created_at,
        mr.responded_at
    FROM match_requests mr
    WHERE (
        (mr.requester_id = auth.uid() AND mr.target_id = target_user_id)
        OR 
        (mr.target_id = auth.uid() AND mr.requester_id = target_user_id)
    )
    ORDER BY mr.created_at DESC
    LIMIT 1;
$$;


ALTER FUNCTION "public"."get_match_status_extended"("target_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_matched_user_profile"("target_user_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "main_photo_url" "text", "frame_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    caller uuid := auth.uid();
BEGIN
    -- Must be authenticated
    IF caller IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;
    
    -- Check if there's a match_request between these users (either direction, any status)
    -- This allows viewing profile for:
    -- 1. Pending requests (incoming or outgoing)
    -- 2. Accepted matches
    -- 3. Users you've interacted with via requests
    IF NOT EXISTS (
        SELECT 1 FROM match_requests mr
        WHERE (
            (mr.requester_id = caller AND mr.target_id = target_user_id) OR
            (mr.requester_id = target_user_id AND mr.target_id = caller)
        )
    ) THEN
        -- Also allow if user is visible on map (fallback)
        IF NOT can_view_preview(caller, target_user_id) THEN
            RETURN; -- Return empty if no relationship and not on map
        END IF;
    END IF;
    
    -- Block check
    IF have_blocked_each_other(caller, target_user_id) THEN
        RETURN;
    END IF;
    
    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt) as bio,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as main_photo_url,
        p.frame_id
    FROM profiles p
    WHERE p.id = target_user_id;
END;
$$;


ALTER FUNCTION "public"."get_matched_user_profile"("target_user_id" "uuid") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."get_matched_user_profile"("target_user_id" "uuid") IS 'Returns profile data for a user you have a match_request relationship with. Works even if user is not currently on the map.';



CREATE OR REPLACE FUNCTION "public"."get_my_communities"() RETURNS TABLE("community_id" "uuid", "name" "text", "description" "text", "cover_image_url" "text", "icon_url" "text", "member_count" integer, "category" "public"."community_category_enum", "my_role" "public"."member_role_enum", "is_verified" boolean, "created_at" timestamp with time zone)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
    SELECT 
        c.id,
        c.name,
        c.description,
        c.cover_image_url,
        c.icon_url,
        c.member_count,
        c.category,
        cm.role,
        c.is_verified,
        c.created_at
    FROM communities c
    JOIN community_members cm ON c.id = cm.community_id
    WHERE cm.user_id = auth.uid()
    ORDER BY cm.joined_at DESC;
$$;


ALTER FUNCTION "public"."get_my_communities"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_groups"() RETURNS TABLE("group_id" "uuid", "name" "text", "description" "text", "cover_image_url" "text", "member_count" integer, "my_role" "public"."member_role_enum", "is_private" boolean, "created_at" timestamp with time zone)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
    SELECT 
        g.id,
        g.name,
        g.description,
        g.cover_image_url,
        g.member_count,
        gm.role,
        g.is_private,
        g.created_at
    FROM groups g
    JOIN group_members gm ON g.id = gm.group_id
    WHERE gm.user_id = auth.uid()
    ORDER BY gm.joined_at DESC;
$$;


ALTER FUNCTION "public"."get_my_groups"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_hosted_events"("p_user_id" "uuid") RETURNS TABLE("id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "location_name" "text", "time_start" timestamp with time zone, "time_end" timestamp with time zone, "status" "public"."event_status_enum", "attendee_count" bigint, "avg_rating" numeric)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT 
    e.id,
    e.event_name,
    e.category,
    e.location_name,
    e.time_start,
    e.time_end,
    e.status,
    (SELECT COUNT(*) FROM event_applications ea 
     WHERE ea.event_id = e.id AND ea.status = 'approved') as attendee_count,
    (SELECT ROUND(AVG(er.rating), 1) FROM event_ratings er 
     WHERE er.event_id = e.id) as avg_rating
  FROM events e
  WHERE e.host_id = p_user_id
    AND e.status IN ('finished', 'expired')
  ORDER BY e.time_start DESC
  LIMIT 20;
$$;


ALTER FUNCTION "public"."get_my_hosted_events"("p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_joined_events"("p_user_id" "uuid") RETURNS TABLE("id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "location_name" "text", "time_start" timestamp with time zone, "time_end" timestamp with time zone, "host_id" "uuid", "host_name" "text")
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT 
        e.id,
        e.event_name,
        e.category,
        e.location_name,
        e.time_start,
        e.time_end,
        e.host_id,
        p.full_name as host_name
    FROM event_applications ea
    JOIN events e ON e.id = ea.event_id
    LEFT JOIN profiles p ON p.id = e.host_id
    WHERE ea.applicant_id = p_user_id
    AND ea.status = 'approved'
    AND e.status IN ('finished', 'expired')
    ORDER BY e.time_start DESC
    LIMIT 50;
$$;


ALTER FUNCTION "public"."get_my_joined_events"("p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_nearby_events"() RETURNS TABLE("id" "uuid", "host_id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "event_description" "text", "location" "public"."geography", "location_name" "text", "time_start" timestamp with time zone, "time_end" timestamp with time zone, "capacity" integer, "gender_allowed" "public"."gender_filter_enum", "age_min" integer, "age_max" integer, "status" "public"."event_status_enum", "created_at" timestamp with time zone, "updated_at" timestamp with time zone, "latitude" double precision, "longitude" double precision, "distance_km" numeric, "attendee_count" bigint)
    LANGUAGE "plpgsql" STABLE
    AS $$
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
$$;


ALTER FUNCTION "public"."get_my_nearby_events"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_pending_group_invites"() RETURNS TABLE("invite_id" "uuid", "group_id" "uuid", "group_name" "text", "group_description" "text", "group_cover_image_url" "text", "group_member_count" integer, "invited_by_id" "uuid", "invited_by_name" "text", "invited_by_photo_url" "text", "role" "public"."member_role_enum", "message" "text", "created_at" timestamp with time zone)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT 
        gi.id as invite_id,
        gi.group_id,
        g.name as group_name,
        g.description as group_description,
        g.cover_image_url as group_cover_image_url,
        g.member_count as group_member_count,
        gi.invited_by as invited_by_id,
        p.full_name as invited_by_name,
        (
            SELECT up.photo_url 
            FROM user_photos up 
            WHERE up.user_id = gi.invited_by 
            AND up.is_main = true 
            LIMIT 1
        ) as invited_by_photo_url,
        gi.role,
        gi.message,
        gi.created_at
    FROM group_invites gi
    JOIN groups g ON g.id = gi.group_id
    JOIN profiles p ON p.id = gi.invited_by
    WHERE gi.invited_user_id = auth.uid()
    AND gi.status = 'pending'
    ORDER BY gi.created_at DESC;
$$;


ALTER FUNCTION "public"."get_my_pending_group_invites"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_nearby_events_with_coordinates"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_meters" integer DEFAULT 30000, "p_status" "text" DEFAULT 'active'::"text") RETURNS TABLE("id" "uuid", "host_id" "uuid", "event_name" "text", "category" "public"."event_category_enum", "event_description" "text", "location_name" "text", "latitude" double precision, "longitude" double precision, "time_start" timestamp with time zone, "time_end" timestamp with time zone, "capacity" integer, "gender_allowed" "public"."gender_filter_enum", "age_min" integer, "age_max" integer, "status" "public"."event_status_enum", "event_type" "public"."event_type_enum", "fuzzy_radius_meters" integer, "group_id" "uuid", "community_id" "uuid", "created_at" timestamp with time zone, "updated_at" timestamp with time zone, "accepted_count" bigint)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    e.id,
    e.host_id,
    e.event_name,
    e.category,
    e.event_description,
    e.location_name,
    -- Extract lat/lng from PostGIS location column
    ST_Y(e.location::geometry) as latitude,
    ST_X(e.location::geometry) as longitude,
    e.time_start,
    e.time_end,
    e.capacity,
    e.gender_allowed,
    e.age_min,
    e.age_max,
    e.status,
    e.event_type,
    COALESCE(e.fuzzy_radius_meters, 500)::INTEGER as fuzzy_radius_meters,
    e.group_id,
    e.community_id,
    e.created_at,
    e.updated_at,
    COALESCE((
      SELECT COUNT(*)::BIGINT 
      FROM event_applications ea 
      WHERE ea.event_id = e.id AND ea.status = 'approved'
    ), 0::BIGINT) as accepted_count
  FROM events e
  WHERE 
    e.status = p_status::event_status_enum
    AND e.location IS NOT NULL
    AND ST_DWithin(
      e.location::geography,
      ST_SetSRID(ST_MakePoint(p_user_lng, p_user_lat), 4326)::geography,
      p_radius_meters
    );
END;
$$;


ALTER FUNCTION "public"."get_nearby_events_with_coordinates"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_meters" integer, "p_status" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_profile_access_level"("p_viewer_id" "uuid", "p_target_id" "uuid") RETURNS "text"
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_visibility profile_visibility_enum;
BEGIN
    -- 1. Self always gets full access
    IF p_viewer_id = p_target_id THEN
        RETURN 'full';
    END IF;
    
    -- 2. Blocked = no access
    IF have_blocked_each_other(p_viewer_id, p_target_id) THEN
        RETURN 'none';
    END IF;
    
    -- 3. Matched (accepted) = always full access
    IF EXISTS (
        SELECT 1 FROM match_requests mr
        WHERE mr.status = 'accepted'
        AND ((mr.requester_id = p_viewer_id AND mr.target_id = p_target_id)
            OR (mr.requester_id = p_target_id AND mr.target_id = p_viewer_id))
    ) THEN
        RETURN 'full';
    END IF;
    
    -- 4. Check for valid viewing context
    IF NOT (
        -- Proximity (can see on map)
        can_see_on_map(p_viewer_id, p_target_id) 
        OR
        -- Same finished event (both participated)
        were_in_same_finished_event(p_viewer_id, p_target_id) 
        OR
        -- Same active event (both approved)
        EXISTS (
            SELECT 1 
            FROM event_applications ea1
            JOIN event_applications ea2 ON ea1.event_id = ea2.event_id
            JOIN events e ON e.id = ea1.event_id
            WHERE ea1.applicant_id = p_viewer_id
            AND ea2.applicant_id = p_target_id
            AND ea1.status = 'approved'
            AND ea2.status = 'approved'
            AND e.time_end > now()
            AND e.status = 'active'
        )
        OR
        -- Viewer is host, target is approved in viewer's active event
        EXISTS (
            SELECT 1 
            FROM events e
            JOIN event_applications ea ON ea.event_id = e.id
            WHERE e.host_id = p_viewer_id
            AND ea.applicant_id = p_target_id
            AND ea.status = 'approved'
            AND e.status = 'active'
        )
        OR
        -- Target is host, viewer is approved in target's active event
        EXISTS (
            SELECT 1 
            FROM events e
            JOIN event_applications ea ON ea.event_id = e.id
            WHERE e.host_id = p_target_id
            AND ea.applicant_id = p_viewer_id
            AND ea.status = 'approved'
            AND e.status = 'active'
        )
        OR
        -- Same group
        are_in_same_group(p_viewer_id, p_target_id) 
        OR
        -- Same community
        are_in_same_community(p_viewer_id, p_target_id)
        OR
        -- Same community event (finished)
        were_in_same_community_event(p_viewer_id, p_target_id)
        OR
        -- Pending match request (either direction)
        EXISTS (
            SELECT 1 FROM match_requests mr
            WHERE mr.status = 'pending'
            AND ((mr.requester_id = p_viewer_id AND mr.target_id = p_target_id)
                OR (mr.requester_id = p_target_id AND mr.target_id = p_viewer_id))
        )
        OR
        -- Host viewing applicant (any status)
        EXISTS (
            SELECT 1 
            FROM event_applications ea
            JOIN events e ON e.id = ea.event_id
            WHERE ea.applicant_id = p_target_id
            AND e.host_id = p_viewer_id
        )
        OR
        -- Applicant viewing host
        EXISTS (
            SELECT 1 
            FROM event_applications ea
            JOIN events e ON e.id = ea.event_id
            WHERE ea.applicant_id = p_viewer_id
            AND e.host_id = p_target_id
        )
        OR
        -- Invited to event - can see host
        EXISTS (
            SELECT 1
            FROM event_invites ei
            JOIN events e ON e.id = ei.event_id
            WHERE ei.invited_user_id = p_viewer_id
            AND e.host_id = p_target_id
        )
        OR
        -- Invited to event - can see inviter
        EXISTS (
            SELECT 1
            FROM event_invites ei
            WHERE ei.invited_user_id = p_viewer_id
            AND ei.invited_by = p_target_id
        )
    ) THEN
        RETURN 'none';
    END IF;
    
    -- 5. Has valid context - check visibility setting
    SELECT profile_visibility INTO v_visibility
    FROM profiles WHERE id = p_target_id;
    
    IF v_visibility = 'public' THEN
        RETURN 'full';
    ELSE
        RETURN 'limited';
    END IF;
END;
$$;


ALTER FUNCTION "public"."get_profile_access_level"("p_viewer_id" "uuid", "p_target_id" "uuid") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."get_profile_access_level"("p_viewer_id" "uuid", "p_target_id" "uuid") IS 'Returns access level for viewing a profile: full, limited, or none';



CREATE OR REPLACE FUNCTION "public"."get_profile_for_viewer"("p_target_user_id" "uuid") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_access_level text;
    v_result jsonb;
    v_viewer_id uuid := auth.uid();
BEGIN
    IF v_viewer_id IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;
    
    v_access_level := get_profile_access_level(v_viewer_id, p_target_user_id);
    
    IF v_access_level = 'none' THEN
        RETURN NULL;
    END IF;
    
    -- LIMITED: main_photo, name, age, bio, looking_for, marital_status ONLY
    IF v_access_level = 'limited' THEN
        SELECT jsonb_build_object(
            'access_level', 'limited',
            'user_id', p.id,
            'full_name', p.full_name,
            'age', p.age,
            'bio', COALESCE(p.bio, p.prompt),
            'looking_for', p.looking_for::text[],
            'marital_status', p.marital_status::text,
            'main_photo_url', (
                SELECT up.photo_url 
                FROM user_photos up
                WHERE up.user_id = p.id
                ORDER BY up.is_main DESC, up.id ASC 
                LIMIT 1
            )
        ) INTO v_result
        FROM profiles p 
        WHERE p.id = p_target_user_id;
        
        RETURN v_result;
    END IF;
    
    -- FULL: everything (rest of the function stays the same)
    SELECT jsonb_build_object(
        'access_level', 'full',
        'user_id', p.id,
        'full_name', p.full_name,
        'age', p.age,
        'bio', COALESCE(p.bio, p.prompt),
        'looking_for', p.looking_for::text[],
        'frame_id', p.frame_id,
        'gender', p.gender,
        'gender_subtype', p.gender_subtype,
        'sexual_orientation', p.sexual_orientation::text,
        'show_gender_on_profile', p.show_gender_on_profile,
        'show_orientation_on_profile', p.show_orientation_on_profile,
        'orientation_custom', p.orientation_custom,
        'height_cm', p.height_cm,
        'education', p.education,
        'institution', p.institution,
        'prompt_answers', p.prompt_answers,
        'marital_status', p.marital_status::text,
        'vehicles', p.vehicles::text[],
        'hometown', p.hometown,
        'values', p.values::text[],
        'main_photo_url', (
            SELECT up.photo_url 
            FROM user_photos up
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC 
            LIMIT 1
        ),
        'photos', COALESCE((
            SELECT jsonb_agg(jsonb_build_object(
                'id', up.id,
                'photo_url', up.photo_url,
                'is_main', up.is_main,
                'created_at', up.created_at
            ) ORDER BY up.is_main DESC, up.created_at ASC)
            FROM user_photos up 
            WHERE up.user_id = p.id
        ), '[]'::jsonb),
        'active_frames', COALESCE((
            SELECT jsonb_agg(jsonb_build_object(
                'id', f.id,
                'media_url', f.media_url,
                'caption', f.caption,
                'media_kind', f.media_kind,
                'created_at', f.created_at,
                'expires_at', f.expires_at
            ) ORDER BY f.created_at DESC)
            FROM frames f
            WHERE f.user_id = p.id
            AND f.expires_at > now()
            AND f.is_expired = false
        ), '[]'::jsonb),
        'lifestyle', (
            SELECT jsonb_build_object(
                'drinking', l.drinking,
                'smoking', l.smoking,
                'zodiac', l.zodiac,
                'religion', l.religion,
                'politics', l.politics,
                'workout', l.workout,
                'communication', l.communication,
                'love_language', l.love_language,
                'pets', l.pets,
                'kids', l.kids,
                'communities', l.communities
            )
            FROM lifestyle l 
            WHERE l.user_id = p.id
        ),
        'hobbies', COALESCE((
            SELECT jsonb_agg(hm.label ORDER BY hm.label)
            FROM user_hobbies uh
            JOIN hobbies_master hm ON uh.hobby_id = hm.id
            WHERE uh.user_id = p.id
        ), '[]'::jsonb),
        'languages', COALESCE((
            SELECT jsonb_agg(jsonb_build_object(
                'id', lm.id, 
                'code', lm.code, 
                'label', lm.label
            ) ORDER BY lm.label)
            FROM user_languages ul
            JOIN languages_master lm ON ul.language_id = lm.id
            WHERE ul.user_id = p.id
        ), '[]'::jsonb)
    ) INTO v_result
    FROM profiles p 
    WHERE p.id = p_target_user_id;
    
    RETURN v_result;
END;
$$;


ALTER FUNCTION "public"."get_profile_for_viewer"("p_target_user_id" "uuid") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."get_profile_for_viewer"("p_target_user_id" "uuid") IS 'Unified profile fetch with visibility control. Returns full or limited profile data based on access level.';



CREATE OR REPLACE FUNCTION "public"."get_profile_full_for_user"("target_user" "uuid") RETURNS TABLE("id" "uuid", "full_name" "text", "age" integer, "gender" "text", "gender_subtype" "text", "show_gender_on_profile" boolean, "sexual_orientation" "text", "show_orientation_on_profile" boolean, "orientation_custom" "text", "interested_in" "text"[], "age_pref_min" integer, "age_pref_max" integer, "height_cm" integer, "education" "text", "institution" "text", "bio" "text", "prompt_answers" "jsonb", "today_frame" "uuid", "main_photo_url" "text", "last_seen" timestamp with time zone, "discoverable" boolean, "onboarding_completed" boolean, "created_at" timestamp with time zone, "updated_at" timestamp with time zone, "marital_status" "text", "vehicles" "text"[], "hometown" "text", "looking_for" "text"[], "values" "text"[])
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_catalog', 'auth'
    AS $$
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
      p.updated_at,
      p.marital_status::text,
      p.vehicles::text[],
      p.hometown,
      p.looking_for::text[],
      p.values::text[]
    FROM public.profiles p
    WHERE p.id = target_user;
END;
$$;


ALTER FUNCTION "public"."get_profile_full_for_user"("target_user" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_profile_if_matched"("target" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "gender" "text", "sexual_orientation" "text", "bio" "text", "height_cm" integer, "education" "text", "prompt_answers" "jsonb", "lifestyle" "jsonb", "hobbies" "text"[], "photos" "text"[])
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
BEGIN
    IF auth.uid() IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;

    IF NOT EXISTS(
        SELECT 1 FROM match_requests mr
        WHERE mr.status = 'accepted'
        AND ((mr.requester_id = auth.uid() AND mr.target_id = target)
            OR (mr.requester_id = target AND mr.target_id = auth.uid()))
    ) OR have_blocked_each_other(auth.uid(), target) THEN
        RAISE EXCEPTION 'no access: match not accepted or users blocked';
    END IF;

    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        p.gender,
        p.sexual_orientation::text,
        COALESCE(p.bio, p.prompt) as bio,
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
                SELECT hm.label
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
$$;


ALTER FUNCTION "public"."get_profile_if_matched"("target" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_profile_preview_for_user"("target_user" "uuid") RETURNS TABLE("user_id" "uuid", "age" integer, "bio" "text", "today_frame" "uuid", "frame_prompt" "text", "main_photo_url" "text")
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_catalog', 'auth'
    AS $$
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
$$;


ALTER FUNCTION "public"."get_profile_preview_for_user"("target_user" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_active_frames"("target_user_id" "uuid") RETURNS TABLE("id" "uuid", "media_url" "text", "caption" "text", "media_kind" "public"."media_type", "created_at" timestamp with time zone, "expires_at" timestamp with time zone)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_access_level text;
BEGIN
    v_access_level := get_profile_access_level(auth.uid(), target_user_id);
    
    -- Frames ONLY visible with FULL access
    IF v_access_level != 'full' THEN
        RETURN;
    END IF;
    
    RETURN QUERY
    SELECT 
        f.id,
        f.media_url,
        f.caption,
        f.media_kind,
        f.created_at,
        f.expires_at
    FROM frames f
    WHERE f.user_id = target_user_id
    AND f.expires_at > now()
    AND f.is_expired = false
    ORDER BY f.created_at DESC;
END;
$$;


ALTER FUNCTION "public"."get_user_active_frames"("target_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_preview_extended"("target_user_id" "uuid") RETURNS TABLE("user_id" "uuid", "full_name" "text", "age" integer, "bio" "text", "sexual_orientation" "text", "looking_for" "text"[], "main_photo_url" "text", "frame_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    caller uuid := auth.uid();
BEGIN
    -- Must be authenticated
    IF caller IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;
    
    -- Must be able to see on map (discoverable, in range, not blocked)
    IF NOT can_view_preview(caller, target_user_id) THEN
        RETURN; -- Return empty if can't view
    END IF;
    
    RETURN QUERY
    SELECT 
        p.id as user_id,
        p.full_name,
        p.age,
        COALESCE(p.bio, p.prompt) as bio,
        p.sexual_orientation::text,
        -- Get looking_for from latest user_modes
        (
            SELECT ARRAY(
                SELECT unnest(
                    CASE 
                        WHEN um.mode = 'dating' THEN um.looking_for_date::text[]
                        ELSE um.looking_for_friend::text[]
                    END
                )
            )
            FROM user_modes um
            WHERE um.user_id = p.id
            ORDER BY um.created_at DESC
            LIMIT 1
        ) as looking_for,
        (
            SELECT up.photo_url
            FROM user_photos up
            WHERE up.user_id = p.id
            ORDER BY up.is_main DESC, up.id ASC
            LIMIT 1
        ) as main_photo_url,
        p.frame_id
    FROM profiles p
    WHERE p.id = target_user_id;
END;
$$;


ALTER FUNCTION "public"."get_user_preview_extended"("target_user_id" "uuid") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."get_user_preview_extended"("target_user_id" "uuid") IS 'Returns extended preview data for a user visible on the map. Includes sexual_orientation and looking_for preferences.';



CREATE OR REPLACE FUNCTION "public"."handle_event_application_approval"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
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
$$;


ALTER FUNCTION "public"."handle_event_application_approval"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_group_invite_acceptance"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
    v_current_count INTEGER;
    v_max_members INTEGER;
BEGIN
    -- Only proceed if status changed to 'accepted'
    IF NEW.status = 'accepted' AND (OLD.status IS NULL OR OLD.status != 'accepted') THEN
        -- Set responded_at
        NEW.responded_at := now();
        
        -- Check if group is at capacity
        SELECT g.member_count, g.max_members 
        INTO v_current_count, v_max_members
        FROM groups g WHERE g.id = NEW.group_id;
        
        IF v_current_count >= v_max_members THEN
            RAISE EXCEPTION 'Group is at full capacity';
        END IF;
        
        -- Add user to group_members with the specified role
        INSERT INTO group_members (group_id, user_id, role)
        VALUES (NEW.group_id, NEW.invited_user_id, NEW.role)
        ON CONFLICT (group_id, user_id) DO NOTHING;
        
        -- The trigger trg_sync_group_conversation_member will handle
        -- adding the user to the conversation
    END IF;
    
    -- Set responded_at for declined as well
    IF NEW.status = 'declined' AND OLD.status = 'pending' THEN
        NEW.responded_at := now();
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_group_invite_acceptance"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_lifestyle_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;


ALTER FUNCTION "public"."handle_lifestyle_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_match_acceptance"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id uuid;
BEGIN
    IF NEW.status = 'accepted' AND (OLD.status IS NULL OR OLD.status != 'accepted') THEN
        INSERT INTO conversations (type, match_request_id)
        VALUES ('match', NEW.id)
        RETURNING id INTO v_conversation_id;
        
        INSERT INTO conversation_members (conversation_id, user_id)
        VALUES 
            (v_conversation_id, NEW.requester_id),
            (v_conversation_id, NEW.target_id);
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_match_acceptance"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."have_blocked_each_other"("me" "uuid", "other" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE
    SET "search_path" TO 'public', 'pg_catalog'
    AS $$
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
$$;


ALTER FUNCTION "public"."have_blocked_each_other"("me" "uuid", "other" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."haversine_km"("lat1" numeric, "lon1" numeric, "lat2" numeric, "lon2" numeric) RETURNS numeric
    LANGUAGE "sql" IMMUTABLE
    AS $_$
  select 2 * 6371 * asin(
    sqrt(
      power(sin(radians($3 - $1)/2), 2) +
      cos(radians($1)) * cos(radians($3)) * power(sin(radians($4 - $2)/2), 2)
    )
  );
$_$;


ALTER FUNCTION "public"."haversine_km"("lat1" numeric, "lon1" numeric, "lat2" numeric, "lon2" numeric) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_community_member_direct"("p_community_id" "uuid", "p_user_id" "uuid") RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$ SELECT EXISTS (SELECT 1 FROM community_members WHERE community_id = p_community_id AND user_id = p_user_id); $$;


ALTER FUNCTION "public"."is_community_member_direct"("p_community_id" "uuid", "p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_group_member_direct"("p_group_id" "uuid", "p_user_id" "uuid") RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$ SELECT EXISTS (SELECT 1 FROM group_members WHERE group_id = p_group_id AND user_id = p_user_id); $$;


ALTER FUNCTION "public"."is_group_member_direct"("p_group_id" "uuid", "p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_matched_with"("other_user_id" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT EXISTS (
    SELECT 1 FROM match_requests mr
    WHERE mr.status = 'accepted'
    AND (
      (mr.requester_id = auth.uid() AND mr.target_id = other_user_id)
      OR
      (mr.requester_id = other_user_id AND mr.target_id = auth.uid())
    )
  );
$$;


ALTER FUNCTION "public"."is_matched_with"("other_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."join_community_by_code"("p_invite_code" "uuid") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_community_id UUID;
    v_member_count INTEGER;
    v_max_members INTEGER;
BEGIN
    SELECT id, member_count, max_members 
    INTO v_community_id, v_member_count, v_max_members
    FROM communities
    WHERE invite_code = p_invite_code;
    
    IF v_community_id IS NULL THEN
        RAISE EXCEPTION 'Invalid invite code';
    END IF;
    
    IF v_member_count >= v_max_members THEN
        RAISE EXCEPTION 'Community is full';
    END IF;
    
    IF EXISTS (SELECT 1 FROM community_members WHERE community_id = v_community_id AND user_id = auth.uid()) THEN
        RAISE EXCEPTION 'Already a member of this community';
    END IF;
    
    INSERT INTO community_members (community_id, user_id, role)
    VALUES (v_community_id, auth.uid(), 'member');
    
    RETURN v_community_id;
END;
$$;


ALTER FUNCTION "public"."join_community_by_code"("p_invite_code" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."join_event_direct"("p_event_id" "uuid") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_event RECORD;
    v_application_id UUID;
    v_can_join BOOLEAN;
    v_join_method TEXT;
    v_reason TEXT;
BEGIN
    -- Check if can join
    SELECT * INTO v_can_join, v_join_method, v_reason
    FROM can_join_event(v_user_id, p_event_id);
    
    IF NOT v_can_join THEN
        RAISE EXCEPTION '%', v_reason;
    END IF;
    
    IF v_join_method != 'direct' THEN
        RAISE EXCEPTION 'This event requires application or invite, use appropriate method';
    END IF;
    
    -- Create approved application
    INSERT INTO event_applications (event_id, applicant_id, status)
    VALUES (p_event_id, v_user_id, 'approved')
    ON CONFLICT (event_id, applicant_id) 
    DO UPDATE SET status = 'approved', updated_at = now()
    RETURNING id INTO v_application_id;
    
    RETURN v_application_id;
END;
$$;


ALTER FUNCTION "public"."join_event_direct"("p_event_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."join_group_by_code"("p_invite_code" "uuid") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_group_id UUID;
    v_member_count INTEGER;
    v_max_members INTEGER;
BEGIN
    SELECT id, member_count, max_members 
    INTO v_group_id, v_member_count, v_max_members
    FROM groups
    WHERE invite_code = p_invite_code;
    
    IF v_group_id IS NULL THEN
        RAISE EXCEPTION 'Invalid invite code';
    END IF;
    
    IF v_member_count >= v_max_members THEN
        RAISE EXCEPTION 'Group is full';
    END IF;
    
    IF EXISTS (SELECT 1 FROM group_members WHERE group_id = v_group_id AND user_id = auth.uid()) THEN
        RAISE EXCEPTION 'Already a member of this group';
    END IF;
    
    INSERT INTO group_members (group_id, user_id, role)
    VALUES (v_group_id, auth.uid(), 'member');
    
    RETURN v_group_id;
END;
$$;


ALTER FUNCTION "public"."join_group_by_code"("p_invite_code" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."mark_all_expired_frames"() RETURNS TABLE("updated_count" bigint)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
$$;


ALTER FUNCTION "public"."mark_all_expired_frames"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."mark_expired_frames"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."mark_expired_frames"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."mark_messages_read"("p_conversation_id" "uuid", "p_user_id" "uuid" DEFAULT "auth"."uid"()) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    -- Update last_read_at in conversation_members
    UPDATE conversation_members
    SET last_read_at = now()
    WHERE conversation_id = p_conversation_id
    AND user_id = p_user_id;
    
    -- Insert read receipts for unread messages (optional granular tracking)
    INSERT INTO message_reads (message_id, user_id, read_at)
    SELECT m.id, p_user_id, now()
    FROM messages m
    WHERE m.conversation_id = p_conversation_id
    AND m.sender_id != p_user_id
    AND NOT EXISTS (
        SELECT 1 FROM message_reads mr 
        WHERE mr.message_id = m.id AND mr.user_id = p_user_id
    )
    ON CONFLICT (message_id, user_id) DO NOTHING;
END;
$$;


ALTER FUNCTION "public"."mark_messages_read"("p_conversation_id" "uuid", "p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."remove_user_from_event_chat"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    -- Only proceed if status changed to cancelled or rejected (was approved before)
    IF NEW.status IN ('cancelled', 'rejected') AND OLD.status = 'approved' THEN
        -- Find the event group chat
        SELECT id INTO v_conversation_id
        FROM conversations
        WHERE event_id = NEW.event_id AND type = 'event_group';
        
        IF v_conversation_id IS NOT NULL THEN
            -- Remove from conversation
            DELETE FROM conversation_members
            WHERE conversation_id = v_conversation_id AND user_id = NEW.applicant_id;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."remove_user_from_event_chat"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."send_match_request_full"("p_target_id" "uuid", "p_message" "text" DEFAULT NULL::"text", "p_origin_event_id" "uuid" DEFAULT NULL::"uuid", "p_origin_group_id" "uuid" DEFAULT NULL::"uuid", "p_origin_community_id" "uuid" DEFAULT NULL::"uuid") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_can_send BOOLEAN;
    v_reason TEXT;
    v_context TEXT;
    v_request_id UUID;
BEGIN
    SELECT * INTO v_can_send, v_reason, v_context
    FROM can_send_match_request(v_user_id, p_target_id);
    
    IF NOT v_can_send THEN
        RAISE EXCEPTION '%', v_reason;
    END IF;
    
    INSERT INTO match_requests (
        requester_id,
        target_id,
        status,
        sender_message,
        origin_event_id,
        origin_group_id,
        origin_community_id,
        origin_context
    )
    VALUES (
        v_user_id,
        p_target_id,
        'pending',
        p_message,
        p_origin_event_id,
        p_origin_group_id,
        p_origin_community_id,
        v_context
    )
    RETURNING id INTO v_request_id;
    
    RETURN v_request_id;
END;
$$;


ALTER FUNCTION "public"."send_match_request_full"("p_target_id" "uuid", "p_message" "text", "p_origin_event_id" "uuid", "p_origin_group_id" "uuid", "p_origin_community_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."send_match_request_with_context"("p_target_id" "uuid", "p_message" "text" DEFAULT NULL::"text") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_can_send BOOLEAN;
    v_reason TEXT;
    v_context TEXT;
    v_request_id UUID;
BEGIN
    SELECT * INTO v_can_send, v_reason, v_context
    FROM can_send_match_request(v_user_id, p_target_id);
    
    IF NOT v_can_send THEN
        RAISE EXCEPTION '%', v_reason;
    END IF;
    
    INSERT INTO match_requests (
        requester_id,
        target_id,
        status,
        sender_message,
        origin_context
    )
    VALUES (
        v_user_id,
        p_target_id,
        'pending',
        p_message,
        v_context
    )
    RETURNING id INTO v_request_id;
    
    RETURN v_request_id;
END;
$$;


ALTER FUNCTION "public"."send_match_request_with_context"("p_target_id" "uuid", "p_message" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_community_conversation_member"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    SELECT id INTO v_conversation_id
    FROM conversations
    WHERE community_id = COALESCE(NEW.community_id, OLD.community_id) AND type = 'community_chat';
    
    IF v_conversation_id IS NOT NULL THEN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO conversation_members (conversation_id, user_id)
            VALUES (v_conversation_id, NEW.user_id)
            ON CONFLICT DO NOTHING;
        ELSIF TG_OP = 'DELETE' THEN
            DELETE FROM conversation_members
            WHERE conversation_id = v_conversation_id AND user_id = OLD.user_id;
        END IF;
    END IF;
    
    RETURN COALESCE(NEW, OLD);
END;
$$;


ALTER FUNCTION "public"."sync_community_conversation_member"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_group_conversation_member"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
    v_conversation_id UUID;
BEGIN
    SELECT id INTO v_conversation_id
    FROM conversations
    WHERE group_id = COALESCE(NEW.group_id, OLD.group_id) AND type = 'group_chat';
    
    IF v_conversation_id IS NOT NULL THEN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO conversation_members (conversation_id, user_id)
            VALUES (v_conversation_id, NEW.user_id)
            ON CONFLICT DO NOTHING;
        ELSIF TG_OP = 'DELETE' THEN
            DELETE FROM conversation_members
            WHERE conversation_id = v_conversation_id AND user_id = OLD.user_id;
        END IF;
    END IF;
    
    RETURN COALESCE(NEW, OLD);
END;
$$;


ALTER FUNCTION "public"."sync_group_conversation_member"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_community_member_count"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE communities SET member_count = member_count + 1, updated_at = now()
        WHERE id = NEW.community_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE communities SET member_count = GREATEST(0, member_count - 1), updated_at = now()
        WHERE id = OLD.community_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."update_community_member_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_group_member_count"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE groups SET member_count = member_count + 1, updated_at = now()
        WHERE id = NEW.group_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE groups SET member_count = GREATEST(0, member_count - 1), updated_at = now()
        WHERE id = OLD.group_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."update_group_member_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_location_from_coords"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NEW.latitude IS NOT NULL AND NEW.longitude IS NOT NULL THEN
    NEW.location := ST_SetSRID(ST_MakePoint(NEW.longitude, NEW.latitude), 4326);
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_location_from_coords"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_user_location"("p_user_id" "uuid", "p_latitude" numeric, "p_longitude" numeric, "p_distance_meters" integer DEFAULT 4000) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    UPDATE profiles
    SET 
        lat = p_latitude,
        lng = p_longitude,
        distance_meters = p_distance_meters,
        updated_at = now()
    WHERE id = p_user_id;
END;
$$;


ALTER FUNCTION "public"."update_user_location"("p_user_id" "uuid", "p_latitude" numeric, "p_longitude" numeric, "p_distance_meters" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_event_description_word_count"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."validate_event_description_word_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_event_rating"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
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
$$;


ALTER FUNCTION "public"."validate_event_rating"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."were_in_same_community_event"("p_user1" "uuid", "p_user2" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT EXISTS (
        SELECT 1 
        FROM event_applications ea1
        JOIN event_applications ea2 ON ea1.event_id = ea2.event_id
        JOIN events e ON e.id = ea1.event_id
        WHERE ea1.applicant_id = p_user1
        AND ea2.applicant_id = p_user2
        AND ea1.status = 'approved'
        AND ea2.status = 'approved'
        AND e.time_end < now()
        AND e.event_type = 'community_event'
    );
$$;


ALTER FUNCTION "public"."were_in_same_community_event"("p_user1" "uuid", "p_user2" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."were_in_same_finished_event"("p_user1" "uuid", "p_user2" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT EXISTS (
        -- Check if both users were approved participants in the same finished event
        SELECT 1 
        FROM event_applications ea1
        JOIN event_applications ea2 ON ea1.event_id = ea2.event_id
        JOIN events e ON e.id = ea1.event_id
        WHERE ea1.applicant_id = p_user1
        AND ea2.applicant_id = p_user2
        AND ea1.status = 'approved'
        AND ea2.status = 'approved'
        AND e.time_end < now()  -- Event has finished
        AND e.status IN ('finished', 'expired', 'active')  -- Valid completed events
        
        UNION
        
        -- Check if user1 is host and user2 was approved participant
        SELECT 1
        FROM events e
        JOIN event_applications ea ON ea.event_id = e.id
        WHERE e.host_id = p_user1
        AND ea.applicant_id = p_user2
        AND ea.status = 'approved'
        AND e.time_end < now()
        AND e.status IN ('finished', 'expired', 'active')
        
        UNION
        
        -- Check if user2 is host and user1 was approved participant
        SELECT 1
        FROM events e
        JOIN event_applications ea ON ea.event_id = e.id
        WHERE e.host_id = p_user2
        AND ea.applicant_id = p_user1
        AND ea.status = 'approved'
        AND e.time_end < now()
        AND e.status IN ('finished', 'expired', 'active')
    );
$$;


ALTER FUNCTION "public"."were_in_same_finished_event"("p_user1" "uuid", "p_user2" "uuid") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."were_in_same_finished_event"("p_user1" "uuid", "p_user2" "uuid") IS 'Checks if two users were both participants (including host) in the same finished event. Updated to include hosts who are not in event_applications.';


SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."blocks" (
    "blocker_id" "uuid" NOT NULL,
    "blocked_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "blocks_no_self" CHECK (("blocker_id" <> "blocked_id"))
);

ALTER TABLE ONLY "public"."blocks" FORCE ROW LEVEL SECURITY;


ALTER TABLE "public"."blocks" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."communities" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "cover_image_url" "text",
    "icon_url" "text",
    "created_by" "uuid" NOT NULL,
    "min_members" integer DEFAULT 50,
    "max_members" integer DEFAULT 1000,
    "member_count" integer DEFAULT 1,
    "category" "public"."community_category_enum" DEFAULT 'other'::"public"."community_category_enum",
    "is_verified" boolean DEFAULT false,
    "is_private" boolean DEFAULT false,
    "invite_code" "uuid" DEFAULT "gen_random_uuid"(),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "communities_max_members_limit" CHECK ((("max_members" <= 1000) AND ("max_members" >= "min_members"))),
    CONSTRAINT "communities_member_count_valid" CHECK (("member_count" >= 0)),
    CONSTRAINT "communities_name_length" CHECK ((("char_length"("name") >= 2) AND ("char_length"("name") <= 100)))
);


ALTER TABLE "public"."communities" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_announcements" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "community_id" "uuid" NOT NULL,
    "author_id" "uuid" NOT NULL,
    "title" "text",
    "content" "text" NOT NULL,
    "pinned" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "announcements_content_length" CHECK ((("char_length"("content") >= 1) AND ("char_length"("content") <= 5000)))
);


ALTER TABLE "public"."community_announcements" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_members" (
    "community_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "public"."member_role_enum" DEFAULT 'member'::"public"."member_role_enum",
    "joined_at" timestamp with time zone DEFAULT "now"(),
    "muted_announcements" boolean DEFAULT false,
    "muted_chat" boolean DEFAULT false
);


ALTER TABLE "public"."community_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conversation_members" (
    "conversation_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "muted" boolean DEFAULT false NOT NULL,
    "last_read_at" timestamp with time zone
);


ALTER TABLE "public"."conversation_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conversations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "type" "public"."conversation_type_enum" NOT NULL,
    "match_request_id" "uuid",
    "event_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "group_id" "uuid",
    "community_id" "uuid",
    CONSTRAINT "conversations_check" CHECK (((("type" = 'match'::"public"."conversation_type_enum") AND ("match_request_id" IS NOT NULL) AND ("event_id" IS NULL) AND ("group_id" IS NULL) AND ("community_id" IS NULL)) OR (("type" = 'event_group'::"public"."conversation_type_enum") AND ("event_id" IS NOT NULL) AND ("match_request_id" IS NULL) AND ("group_id" IS NULL) AND ("community_id" IS NULL)) OR (("type" = 'group_chat'::"public"."conversation_type_enum") AND ("group_id" IS NOT NULL) AND ("match_request_id" IS NULL) AND ("event_id" IS NULL) AND ("community_id" IS NULL)) OR (("type" = 'community_chat'::"public"."conversation_type_enum") AND ("community_id" IS NOT NULL) AND ("match_request_id" IS NULL) AND ("event_id" IS NULL) AND ("group_id" IS NULL))))
);


ALTER TABLE "public"."conversations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."event_applications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_id" "uuid" NOT NULL,
    "applicant_id" "uuid" NOT NULL,
    "status" "public"."event_application_status_enum" DEFAULT 'pending'::"public"."event_application_status_enum" NOT NULL,
    "add_as_friend" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "message" "text"
);


ALTER TABLE "public"."event_applications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."event_invites" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_id" "uuid" NOT NULL,
    "invited_by" "uuid" NOT NULL,
    "invited_user_id" "uuid",
    "group_id" "uuid",
    "community_id" "uuid",
    "status" "text" DEFAULT 'pending'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "invite_has_target" CHECK ((("invited_user_id" IS NOT NULL) OR ("group_id" IS NOT NULL) OR ("community_id" IS NOT NULL))),
    CONSTRAINT "invite_status_valid" CHECK (("status" = ANY (ARRAY['pending'::"text", 'accepted'::"text", 'declined'::"text"])))
);


ALTER TABLE "public"."event_invites" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."event_ratings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_id" "uuid" NOT NULL,
    "rater_id" "uuid" NOT NULL,
    "rating" numeric(2,1) NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "event_ratings_rating_check" CHECK ((("rating" >= 0.5) AND ("rating" <= 5.0) AND (((("rating" * (10)::numeric))::integer % 5) = 0)))
);


ALTER TABLE "public"."event_ratings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."events" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "host_id" "uuid" NOT NULL,
    "event_name" "text" NOT NULL,
    "category" "public"."event_category_enum" NOT NULL,
    "event_description" "text" NOT NULL,
    "location" "public"."geography"(Point,4326) NOT NULL,
    "location_name" "text" NOT NULL,
    "time_start" timestamp with time zone NOT NULL,
    "time_end" timestamp with time zone NOT NULL,
    "capacity" integer NOT NULL,
    "gender_allowed" "public"."gender_filter_enum" NOT NULL,
    "age_min" integer NOT NULL,
    "age_max" integer NOT NULL,
    "status" "public"."event_status_enum" DEFAULT 'active'::"public"."event_status_enum" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "latitude" double precision,
    "longitude" double precision,
    "visibility" "public"."event_visibility_enum" DEFAULT 'public'::"public"."event_visibility_enum",
    "fuzzy_radius_meters" integer DEFAULT 500,
    "invite_code" "uuid" DEFAULT "gen_random_uuid"(),
    "event_type" "public"."event_type_enum" DEFAULT 'public'::"public"."event_type_enum" NOT NULL,
    "group_id" "uuid",
    "community_id" "uuid",
    "allow_member_invites" boolean DEFAULT false,
    "requires_approval" boolean DEFAULT true,
    CONSTRAINT "events_age_min_check" CHECK (("age_min" >= 18)),
    CONSTRAINT "events_capacity_check" CHECK (("capacity" > 0)),
    CONSTRAINT "events_check" CHECK (("time_end" > "time_start")),
    CONSTRAINT "events_check1" CHECK (("age_max" >= "age_min")),
    CONSTRAINT "events_community_type_check" CHECK (((("event_type" = 'community_event'::"public"."event_type_enum") AND ("community_id" IS NOT NULL)) OR (("event_type" <> 'community_event'::"public"."event_type_enum") AND ("community_id" IS NULL)))),
    CONSTRAINT "events_group_type_check" CHECK (((("event_type" = 'group_event'::"public"."event_type_enum") AND ("group_id" IS NOT NULL)) OR (("event_type" <> 'group_event'::"public"."event_type_enum") AND ("group_id" IS NULL)))),
    CONSTRAINT "events_type_approval_check" CHECK (((("event_type" = 'public'::"public"."event_type_enum") AND ("requires_approval" = false)) OR (("event_type" = ANY (ARRAY['public_application'::"public"."event_type_enum", 'private'::"public"."event_type_enum"])) AND ("requires_approval" = true)) OR ("event_type" = ANY (ARRAY['invite_only'::"public"."event_type_enum", 'group_event'::"public"."event_type_enum", 'community_event'::"public"."event_type_enum"]))))
);


ALTER TABLE "public"."events" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."frames" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "media_url" "text" NOT NULL,
    "caption" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "expires_at" timestamp with time zone DEFAULT ("now"() + '24:00:00'::interval) NOT NULL,
    "archived_at" timestamp with time zone,
    "media_kind" "public"."media_type" DEFAULT 'image'::"public"."media_type" NOT NULL,
    "is_expired" boolean DEFAULT false NOT NULL,
    CONSTRAINT "frames_expires_after_create" CHECK (("expires_at" > "created_at"))
);

ALTER TABLE ONLY "public"."frames" FORCE ROW LEVEL SECURITY;


ALTER TABLE "public"."frames" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."group_invites" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "group_id" "uuid" NOT NULL,
    "invited_by" "uuid" NOT NULL,
    "invited_user_id" "uuid" NOT NULL,
    "role" "public"."member_role_enum" DEFAULT 'member'::"public"."member_role_enum" NOT NULL,
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "message" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "responded_at" timestamp with time zone,
    CONSTRAINT "group_invites_no_self_invite" CHECK (("invited_by" <> "invited_user_id")),
    CONSTRAINT "group_invites_role_check" CHECK (("role" = ANY (ARRAY['member'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"]))),
    CONSTRAINT "group_invites_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'accepted'::"text", 'declined'::"text"])))
);


ALTER TABLE "public"."group_invites" OWNER TO "postgres";


COMMENT ON TABLE "public"."group_invites" IS 'Stores invitations to join groups. Users can only invite their matches.';



COMMENT ON COLUMN "public"."group_invites"."role" IS 'The role the invited user will have when they accept (member or admin)';



COMMENT ON COLUMN "public"."group_invites"."status" IS 'pending, accepted, or declined';



CREATE TABLE IF NOT EXISTS "public"."group_members" (
    "group_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "public"."member_role_enum" DEFAULT 'member'::"public"."member_role_enum",
    "joined_at" timestamp with time zone DEFAULT "now"(),
    "muted" boolean DEFAULT false
);


ALTER TABLE "public"."group_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."groups" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "cover_image_url" "text",
    "created_by" "uuid" NOT NULL,
    "max_members" integer DEFAULT 50,
    "member_count" integer DEFAULT 0,
    "is_private" boolean DEFAULT false,
    "invite_code" "uuid" DEFAULT "gen_random_uuid"(),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "groups_max_members_limit" CHECK ((("max_members" <= 50) AND ("max_members" >= 2))),
    CONSTRAINT "groups_member_count_valid" CHECK ((("member_count" >= 0) AND ("member_count" <= "max_members"))),
    CONSTRAINT "groups_name_length" CHECK ((("char_length"("name") >= 2) AND ("char_length"("name") <= 100)))
);


ALTER TABLE "public"."groups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."hobbies_master" (
    "id" integer NOT NULL,
    "label" "text"
);


ALTER TABLE "public"."hobbies_master" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."hobbies_master_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."hobbies_master_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."hobbies_master_id_seq" OWNED BY "public"."hobbies_master"."id";



CREATE TABLE IF NOT EXISTS "public"."languages_master" (
    "id" integer NOT NULL,
    "code" "text" NOT NULL,
    "label" "text" NOT NULL
);


ALTER TABLE "public"."languages_master" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."languages_master_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."languages_master_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."languages_master_id_seq" OWNED BY "public"."languages_master"."id";



CREATE TABLE IF NOT EXISTS "public"."lifestyle" (
    "user_id" "uuid" NOT NULL,
    "drinking" "text",
    "smoking" "text",
    "kids" "text",
    "workout" "text",
    "communication" "text",
    "love_language" "text",
    "zodiac" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "religion" "text",
    "politics" "text",
    "pets" "text",
    "communities" "text"[]
);


ALTER TABLE "public"."lifestyle" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."match_requests" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "requester_id" "uuid" NOT NULL,
    "target_id" "uuid" NOT NULL,
    "status" "public"."match_status_enum" DEFAULT 'pending'::"public"."match_status_enum" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "responded_at" timestamp with time zone,
    "origin_event_id" "uuid",
    "sender_message" "text",
    "origin_context" "text" DEFAULT 'proximity'::"text",
    "origin_group_id" "uuid",
    "origin_community_id" "uuid",
    CONSTRAINT "match_requests_origin_context_check" CHECK (("origin_context" = ANY (ARRAY['proximity'::"text", 'event'::"text", 'group'::"text", 'community_event'::"text"])))
);


ALTER TABLE "public"."match_requests" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."message_reads" (
    "message_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "read_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."message_reads" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "conversation_id" "uuid" NOT NULL,
    "sender_id" "uuid" NOT NULL,
    "content" "text" NOT NULL,
    "edited" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "edited_at" timestamp with time zone,
    "message_type" "public"."message_type_enum" DEFAULT 'text'::"public"."message_type_enum" NOT NULL,
    CONSTRAINT "messages_content_check" CHECK (("length"(TRIM(BOTH FROM "content")) > 0))
);


ALTER TABLE "public"."messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "full_name" "text",
    "age" integer,
    "gender" "text" NOT NULL,
    "sexual_orientation" "public"."orientation_enum",
    "age_pref_min" integer,
    "age_pref_max" integer,
    "interested_in" "public"."gender_enum"[] NOT NULL,
    "height_cm" integer,
    "education" "text",
    "prompt" "text" NOT NULL,
    "onboarding_step" integer DEFAULT 0,
    "onboarding_completed" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "gender_subtype" "text",
    "show_gender_on_profile" boolean DEFAULT true,
    "show_orientation_on_profile" boolean DEFAULT true,
    "orientation_custom" "text",
    "distance_km" integer DEFAULT 1,
    "distance_meters" integer,
    "institution" "text",
    "prompt_answers" "jsonb" DEFAULT '[]'::"jsonb",
    "lat" numeric(9,6),
    "lng" numeric(9,6),
    "discoverable" boolean DEFAULT true NOT NULL,
    "frame_id" "uuid",
    "last_seen" timestamp with time zone DEFAULT "now"(),
    "bio" "text",
    "marital_status" "public"."marital_status_enum",
    "vehicles" "public"."vehicle_enum"[],
    "hometown" "text",
    "looking_for" "public"."looking_for_enum"[],
    "values" "public"."value_enum"[],
    "profile_visibility" "public"."profile_visibility_enum" DEFAULT 'public'::"public"."profile_visibility_enum" NOT NULL,
    CONSTRAINT "interested_in_min" CHECK (("array_length"("interested_in", 1) >= 1)),
    CONSTRAINT "profiles_age_check" CHECK (("age" >= 18)),
    CONSTRAINT "profiles_distance_km_check" CHECK ((("distance_km" >= 0) AND ("distance_km" <= 4)))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_hobbies" (
    "user_id" "uuid" NOT NULL,
    "hobby_id" integer NOT NULL
);


ALTER TABLE "public"."user_hobbies" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_languages" (
    "user_id" "uuid" NOT NULL,
    "language_id" integer NOT NULL
);


ALTER TABLE "public"."user_languages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_photos" (
    "id" integer NOT NULL,
    "user_id" "uuid",
    "photo_url" "text" NOT NULL,
    "is_main" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."user_photos" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."user_photos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."user_photos_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."user_photos_id_seq" OWNED BY "public"."user_photos"."id";



ALTER TABLE ONLY "public"."hobbies_master" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."hobbies_master_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."languages_master" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."languages_master_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."user_photos" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."user_photos_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."blocks"
    ADD CONSTRAINT "blocks_pkey" PRIMARY KEY ("blocker_id", "blocked_id");



ALTER TABLE ONLY "public"."communities"
    ADD CONSTRAINT "communities_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_announcements"
    ADD CONSTRAINT "community_announcements_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_members"
    ADD CONSTRAINT "community_members_pkey" PRIMARY KEY ("community_id", "user_id");



ALTER TABLE ONLY "public"."conversation_members"
    ADD CONSTRAINT "conversation_members_pkey" PRIMARY KEY ("conversation_id", "user_id");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_applications"
    ADD CONSTRAINT "event_applications_event_id_applicant_id_key" UNIQUE ("event_id", "applicant_id");



ALTER TABLE ONLY "public"."event_applications"
    ADD CONSTRAINT "event_applications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_invites"
    ADD CONSTRAINT "event_invites_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_ratings"
    ADD CONSTRAINT "event_ratings_event_id_rater_id_key" UNIQUE ("event_id", "rater_id");



ALTER TABLE ONLY "public"."event_ratings"
    ADD CONSTRAINT "event_ratings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."frames"
    ADD CONSTRAINT "frames_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."group_invites"
    ADD CONSTRAINT "group_invites_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_pkey" PRIMARY KEY ("group_id", "user_id");



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."hobbies_master"
    ADD CONSTRAINT "hobbies_master_label_key" UNIQUE ("label");



ALTER TABLE ONLY "public"."hobbies_master"
    ADD CONSTRAINT "hobbies_master_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."languages_master"
    ADD CONSTRAINT "languages_master_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."languages_master"
    ADD CONSTRAINT "languages_master_label_key" UNIQUE ("label");



ALTER TABLE ONLY "public"."languages_master"
    ADD CONSTRAINT "languages_master_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lifestyle"
    ADD CONSTRAINT "lifestyle_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."lifestyle"
    ADD CONSTRAINT "lifestyle_user_id_unique" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."match_requests"
    ADD CONSTRAINT "match_requests_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."message_reads"
    ADD CONSTRAINT "message_reads_pkey" PRIMARY KEY ("message_id", "user_id");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_hobbies"
    ADD CONSTRAINT "user_hobbies_pkey" PRIMARY KEY ("user_id", "hobby_id");



ALTER TABLE ONLY "public"."user_languages"
    ADD CONSTRAINT "user_languages_pkey" PRIMARY KEY ("user_id", "language_id");



ALTER TABLE ONLY "public"."user_photos"
    ADD CONSTRAINT "user_photos_pkey" PRIMARY KEY ("id");



CREATE INDEX "blocks_blocked_blocker_idx" ON "public"."blocks" USING "btree" ("blocked_id", "blocker_id");



CREATE UNIQUE INDEX "event_invites_user_unique" ON "public"."event_invites" USING "btree" ("event_id", "invited_user_id") WHERE ("invited_user_id" IS NOT NULL);



CREATE INDEX "frames_created_idx" ON "public"."frames" USING "btree" ("created_at");



CREATE INDEX "frames_user_expires_idx" ON "public"."frames" USING "btree" ("user_id", "expires_at" DESC);



CREATE UNIQUE INDEX "group_invites_unique_pending" ON "public"."group_invites" USING "btree" ("group_id", "invited_user_id") WHERE ("status" = 'pending'::"text");



CREATE INDEX "idx_communities_category" ON "public"."communities" USING "btree" ("category");



CREATE INDEX "idx_communities_created_by" ON "public"."communities" USING "btree" ("created_by");



CREATE INDEX "idx_communities_invite_code" ON "public"."communities" USING "btree" ("invite_code");



CREATE INDEX "idx_community_announcements_community" ON "public"."community_announcements" USING "btree" ("community_id");



CREATE INDEX "idx_community_announcements_pinned" ON "public"."community_announcements" USING "btree" ("community_id", "pinned" DESC, "created_at" DESC);



CREATE INDEX "idx_community_members_user" ON "public"."community_members" USING "btree" ("user_id");



CREATE INDEX "idx_conversation_members_last_read" ON "public"."conversation_members" USING "btree" ("last_read_at");



CREATE INDEX "idx_conversation_members_user" ON "public"."conversation_members" USING "btree" ("user_id");



CREATE INDEX "idx_conversations_community" ON "public"."conversations" USING "btree" ("community_id") WHERE ("community_id" IS NOT NULL);



CREATE INDEX "idx_conversations_created" ON "public"."conversations" USING "btree" ("created_at");



CREATE INDEX "idx_conversations_event" ON "public"."conversations" USING "btree" ("event_id");



CREATE INDEX "idx_conversations_group" ON "public"."conversations" USING "btree" ("group_id") WHERE ("group_id" IS NOT NULL);



CREATE INDEX "idx_conversations_match_request" ON "public"."conversations" USING "btree" ("match_request_id");



CREATE INDEX "idx_conversations_type" ON "public"."conversations" USING "btree" ("type");



CREATE INDEX "idx_event_applications_applicant" ON "public"."event_applications" USING "btree" ("applicant_id");



CREATE INDEX "idx_event_applications_event" ON "public"."event_applications" USING "btree" ("event_id");



CREATE INDEX "idx_event_applications_status" ON "public"."event_applications" USING "btree" ("status");



CREATE INDEX "idx_event_invites_community" ON "public"."event_invites" USING "btree" ("community_id") WHERE ("community_id" IS NOT NULL);



CREATE INDEX "idx_event_invites_event" ON "public"."event_invites" USING "btree" ("event_id");



CREATE INDEX "idx_event_invites_group" ON "public"."event_invites" USING "btree" ("group_id") WHERE ("group_id" IS NOT NULL);



CREATE INDEX "idx_event_invites_invited_user" ON "public"."event_invites" USING "btree" ("invited_user_id");



CREATE INDEX "idx_event_ratings_event" ON "public"."event_ratings" USING "btree" ("event_id");



CREATE INDEX "idx_event_ratings_rater" ON "public"."event_ratings" USING "btree" ("rater_id");



CREATE INDEX "idx_event_ratings_rating" ON "public"."event_ratings" USING "btree" ("rating");



CREATE INDEX "idx_events_community_id" ON "public"."events" USING "btree" ("community_id") WHERE ("community_id" IS NOT NULL);



CREATE INDEX "idx_events_event_type" ON "public"."events" USING "btree" ("event_type");



CREATE INDEX "idx_events_group_id" ON "public"."events" USING "btree" ("group_id") WHERE ("group_id" IS NOT NULL);



CREATE INDEX "idx_events_invite_code" ON "public"."events" USING "btree" ("invite_code") WHERE ("visibility" = 'invite_only'::"public"."event_visibility_enum");



CREATE INDEX "idx_events_location" ON "public"."events" USING "gist" ("location");



CREATE INDEX "idx_events_visibility" ON "public"."events" USING "btree" ("visibility");



CREATE INDEX "idx_group_invites_group" ON "public"."group_invites" USING "btree" ("group_id");



CREATE INDEX "idx_group_invites_invited_by" ON "public"."group_invites" USING "btree" ("invited_by");



CREATE INDEX "idx_group_invites_invited_user" ON "public"."group_invites" USING "btree" ("invited_user_id");



CREATE INDEX "idx_group_invites_status" ON "public"."group_invites" USING "btree" ("status");



CREATE INDEX "idx_group_members_user" ON "public"."group_members" USING "btree" ("user_id");



CREATE INDEX "idx_groups_created_by" ON "public"."groups" USING "btree" ("created_by");



CREATE INDEX "idx_groups_invite_code" ON "public"."groups" USING "btree" ("invite_code");



CREATE INDEX "idx_match_requests_origin_context" ON "public"."match_requests" USING "btree" ("origin_context");



CREATE INDEX "idx_match_requests_origin_event" ON "public"."match_requests" USING "btree" ("origin_event_id");



CREATE INDEX "idx_match_requests_origin_group" ON "public"."match_requests" USING "btree" ("origin_group_id") WHERE ("origin_group_id" IS NOT NULL);



CREATE INDEX "idx_match_requests_requester" ON "public"."match_requests" USING "btree" ("requester_id");



CREATE INDEX "idx_match_requests_status" ON "public"."match_requests" USING "btree" ("status");



CREATE INDEX "idx_match_requests_target" ON "public"."match_requests" USING "btree" ("target_id");



CREATE INDEX "idx_message_reads_message" ON "public"."message_reads" USING "btree" ("message_id");



CREATE INDEX "idx_message_reads_user" ON "public"."message_reads" USING "btree" ("user_id");



CREATE INDEX "idx_messages_conversation" ON "public"."messages" USING "btree" ("conversation_id");



CREATE INDEX "idx_messages_conversation_created" ON "public"."messages" USING "btree" ("conversation_id", "created_at" DESC);



CREATE INDEX "idx_messages_created" ON "public"."messages" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_messages_sender" ON "public"."messages" USING "btree" ("sender_id");



CREATE INDEX "idx_profiles_lat_lng" ON "public"."profiles" USING "btree" ("lat", "lng");



CREATE INDEX "idx_profiles_looking_for" ON "public"."profiles" USING "gin" ("looking_for");



CREATE INDEX "idx_profiles_marital_status" ON "public"."profiles" USING "btree" ("marital_status");



CREATE INDEX "idx_profiles_prompt_answers" ON "public"."profiles" USING "gin" ("prompt_answers");



CREATE INDEX "idx_profiles_values" ON "public"."profiles" USING "gin" ("values");



CREATE INDEX "idx_profiles_visibility" ON "public"."profiles" USING "btree" ("profile_visibility");



CREATE INDEX "idx_user_languages_language" ON "public"."user_languages" USING "btree" ("language_id");



CREATE INDEX "idx_user_languages_user" ON "public"."user_languages" USING "btree" ("user_id");



CREATE INDEX "idx_user_photos_user_id_is_main" ON "public"."user_photos" USING "btree" ("user_id", "is_main");



CREATE UNIQUE INDEX "match_requests_unique_pair" ON "public"."match_requests" USING "btree" (LEAST("requester_id", "target_id"), GREATEST("requester_id", "target_id"));



CREATE UNIQUE INDEX "user_photos_one_main_per_user_idx" ON "public"."user_photos" USING "btree" ("user_id") WHERE ("is_main" = true);



CREATE OR REPLACE TRIGGER "check_event_description_word_count" BEFORE INSERT OR UPDATE ON "public"."events" FOR EACH ROW EXECUTE FUNCTION "public"."validate_event_description_word_count"();



CREATE OR REPLACE TRIGGER "check_event_rating_validity" BEFORE INSERT OR UPDATE ON "public"."event_ratings" FOR EACH ROW EXECUTE FUNCTION "public"."validate_event_rating"();



CREATE OR REPLACE TRIGGER "create_conversation_on_match_accept" AFTER INSERT OR UPDATE ON "public"."match_requests" FOR EACH ROW EXECUTE FUNCTION "public"."handle_match_acceptance"();



CREATE OR REPLACE TRIGGER "handle_event_friend_add" AFTER INSERT OR UPDATE ON "public"."event_applications" FOR EACH ROW EXECUTE FUNCTION "public"."handle_event_application_approval"();



CREATE OR REPLACE TRIGGER "lifestyle_updated_at_trigger" BEFORE UPDATE ON "public"."lifestyle" FOR EACH ROW EXECUTE FUNCTION "public"."handle_lifestyle_updated_at"();



CREATE OR REPLACE TRIGGER "set_location_from_coords" BEFORE INSERT OR UPDATE ON "public"."events" FOR EACH ROW EXECUTE FUNCTION "public"."update_location_from_coords"();



CREATE OR REPLACE TRIGGER "trg_add_approved_to_event_chat" AFTER INSERT OR UPDATE ON "public"."event_applications" FOR EACH ROW EXECUTE FUNCTION "public"."add_approved_applicant_to_event_chat"();



CREATE OR REPLACE TRIGGER "trg_add_invited_to_event_chat" AFTER UPDATE ON "public"."event_invites" FOR EACH ROW EXECUTE FUNCTION "public"."add_invited_user_to_event_chat"();



CREATE OR REPLACE TRIGGER "trg_create_community_conversation" AFTER INSERT ON "public"."communities" FOR EACH ROW EXECUTE FUNCTION "public"."create_community_conversation"();



CREATE OR REPLACE TRIGGER "trg_create_event_group_chat" AFTER INSERT ON "public"."events" FOR EACH ROW EXECUTE FUNCTION "public"."create_event_group_chat"();



CREATE OR REPLACE TRIGGER "trg_create_group_conversation" AFTER INSERT ON "public"."groups" FOR EACH ROW EXECUTE FUNCTION "public"."create_group_conversation"();



CREATE OR REPLACE TRIGGER "trg_enforce_photo_max_4" BEFORE INSERT ON "public"."user_photos" FOR EACH ROW EXECUTE FUNCTION "public"."enforce_photo_max_4"();



CREATE OR REPLACE TRIGGER "trg_frames_after_insert_set_pointer" AFTER INSERT ON "public"."frames" FOR EACH ROW EXECUTE FUNCTION "public"."frames_after_insert_set_pointer"();



CREATE OR REPLACE TRIGGER "trg_frames_after_update_clear_pointer" AFTER UPDATE ON "public"."frames" FOR EACH ROW EXECUTE FUNCTION "public"."frames_after_update_clear_pointer"();



CREATE OR REPLACE TRIGGER "trg_frames_before_insert_rotate" BEFORE INSERT ON "public"."frames" FOR EACH ROW EXECUTE FUNCTION "public"."frames_before_insert_rotate"();



CREATE OR REPLACE TRIGGER "trg_handle_group_invite_acceptance" BEFORE UPDATE ON "public"."group_invites" FOR EACH ROW EXECUTE FUNCTION "public"."handle_group_invite_acceptance"();



CREATE OR REPLACE TRIGGER "trg_mark_expired_frames" BEFORE INSERT OR UPDATE ON "public"."frames" FOR EACH ROW EXECUTE FUNCTION "public"."mark_expired_frames"();



CREATE OR REPLACE TRIGGER "trg_remove_from_event_chat" AFTER UPDATE ON "public"."event_applications" FOR EACH ROW EXECUTE FUNCTION "public"."remove_user_from_event_chat"();



CREATE OR REPLACE TRIGGER "trg_sync_community_conversation_member" AFTER INSERT OR DELETE ON "public"."community_members" FOR EACH ROW EXECUTE FUNCTION "public"."sync_community_conversation_member"();



CREATE OR REPLACE TRIGGER "trg_sync_group_conversation_member" AFTER INSERT OR DELETE ON "public"."group_members" FOR EACH ROW EXECUTE FUNCTION "public"."sync_group_conversation_member"();



CREATE OR REPLACE TRIGGER "trg_update_community_member_count" AFTER INSERT OR DELETE ON "public"."community_members" FOR EACH ROW EXECUTE FUNCTION "public"."update_community_member_count"();



CREATE OR REPLACE TRIGGER "trg_update_group_member_count" AFTER INSERT OR DELETE ON "public"."group_members" FOR EACH ROW EXECUTE FUNCTION "public"."update_group_member_count"();



CREATE OR REPLACE TRIGGER "update_announcements_updated_at" BEFORE UPDATE ON "public"."community_announcements" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_communities_updated_at" BEFORE UPDATE ON "public"."communities" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_event_applications_updated_at" BEFORE UPDATE ON "public"."event_applications" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_events_updated_at" BEFORE UPDATE ON "public"."events" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_groups_updated_at" BEFORE UPDATE ON "public"."groups" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



ALTER TABLE ONLY "public"."blocks"
    ADD CONSTRAINT "blocks_blocked_id_fkey" FOREIGN KEY ("blocked_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."blocks"
    ADD CONSTRAINT "blocks_blocker_id_fkey" FOREIGN KEY ("blocker_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."communities"
    ADD CONSTRAINT "communities_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_announcements"
    ADD CONSTRAINT "community_announcements_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_announcements"
    ADD CONSTRAINT "community_announcements_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "public"."communities"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_members"
    ADD CONSTRAINT "community_members_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "public"."communities"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_members"
    ADD CONSTRAINT "community_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversation_members"
    ADD CONSTRAINT "conversation_members_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversation_members"
    ADD CONSTRAINT "conversation_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "public"."communities"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_match_request_id_fkey" FOREIGN KEY ("match_request_id") REFERENCES "public"."match_requests"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_applications"
    ADD CONSTRAINT "event_applications_applicant_id_fkey" FOREIGN KEY ("applicant_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_applications"
    ADD CONSTRAINT "event_applications_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_invites"
    ADD CONSTRAINT "event_invites_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "public"."communities"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_invites"
    ADD CONSTRAINT "event_invites_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_invites"
    ADD CONSTRAINT "event_invites_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_invites"
    ADD CONSTRAINT "event_invites_invited_by_fkey" FOREIGN KEY ("invited_by") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_invites"
    ADD CONSTRAINT "event_invites_invited_user_id_fkey" FOREIGN KEY ("invited_user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_ratings"
    ADD CONSTRAINT "event_ratings_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_ratings"
    ADD CONSTRAINT "event_ratings_rater_id_fkey" FOREIGN KEY ("rater_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "public"."communities"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_host_id_fkey" FOREIGN KEY ("host_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."frames"
    ADD CONSTRAINT "frames_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_invites"
    ADD CONSTRAINT "group_invites_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_invites"
    ADD CONSTRAINT "group_invites_invited_by_fkey" FOREIGN KEY ("invited_by") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_invites"
    ADD CONSTRAINT "group_invites_invited_user_id_fkey" FOREIGN KEY ("invited_user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lifestyle"
    ADD CONSTRAINT "lifestyle_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."match_requests"
    ADD CONSTRAINT "match_requests_origin_community_fk" FOREIGN KEY ("origin_community_id") REFERENCES "public"."communities"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."match_requests"
    ADD CONSTRAINT "match_requests_origin_event_fk" FOREIGN KEY ("origin_event_id") REFERENCES "public"."events"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."match_requests"
    ADD CONSTRAINT "match_requests_origin_group_fk" FOREIGN KEY ("origin_group_id") REFERENCES "public"."groups"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."match_requests"
    ADD CONSTRAINT "match_requests_requester_id_fkey" FOREIGN KEY ("requester_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."match_requests"
    ADD CONSTRAINT "match_requests_target_id_fkey" FOREIGN KEY ("target_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."message_reads"
    ADD CONSTRAINT "message_reads_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "public"."messages"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."message_reads"
    ADD CONSTRAINT "message_reads_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_frame_id_fkey" FOREIGN KEY ("frame_id") REFERENCES "public"."frames"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."user_hobbies"
    ADD CONSTRAINT "user_hobbies_hobby_id_fkey" FOREIGN KEY ("hobby_id") REFERENCES "public"."hobbies_master"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."user_hobbies"
    ADD CONSTRAINT "user_hobbies_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."user_languages"
    ADD CONSTRAINT "user_languages_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "public"."languages_master"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."user_languages"
    ADD CONSTRAINT "user_languages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_photos"
    ADD CONSTRAINT "user_photos_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



CREATE POLICY "Host can update their own events" ON "public"."events" FOR UPDATE USING (("host_id" = "auth"."uid"())) WITH CHECK (("host_id" = "auth"."uid"()));



CREATE POLICY "announcements:delete_author_or_admin" ON "public"."community_announcements" FOR DELETE TO "authenticated" USING ((("author_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "cm"."community_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"])))))));



CREATE POLICY "announcements:insert_admin" ON "public"."community_announcements" FOR INSERT TO "authenticated" WITH CHECK ((("author_id" = "auth"."uid"()) AND (EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "cm"."community_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum", 'moderator'::"public"."member_role_enum"])))))));



CREATE POLICY "announcements:select_member" ON "public"."community_announcements" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "cm"."community_id") AND ("cm"."user_id" = "auth"."uid"())))));



CREATE POLICY "announcements:update_author_or_admin" ON "public"."community_announcements" FOR UPDATE TO "authenticated" USING ((("author_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "cm"."community_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"])))))));



ALTER TABLE "public"."blocks" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "blocks: delete self" ON "public"."blocks" FOR DELETE TO "authenticated" USING (("blocker_id" = "auth"."uid"()));



CREATE POLICY "blocks: insert self" ON "public"."blocks" FOR INSERT TO "authenticated" WITH CHECK (("blocker_id" = "auth"."uid"()));



CREATE POLICY "blocks: select self-related" ON "public"."blocks" FOR SELECT TO "authenticated" USING ((("blocker_id" = "auth"."uid"()) OR ("blocked_id" = "auth"."uid"())));



ALTER TABLE "public"."communities" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "communities:delete_owner" ON "public"."communities" FOR DELETE TO "authenticated" USING (("created_by" = "auth"."uid"()));



CREATE POLICY "communities:insert_own" ON "public"."communities" FOR INSERT TO "authenticated" WITH CHECK (("created_by" = "auth"."uid"()));



CREATE POLICY "communities:select_public" ON "public"."communities" FOR SELECT TO "authenticated" USING (((NOT "is_private") OR ("created_by" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "communities"."id") AND ("cm"."user_id" = "auth"."uid"()))))));



CREATE POLICY "communities:update_admin" ON "public"."communities" FOR UPDATE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "communities"."id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"]))))));



ALTER TABLE "public"."community_announcements" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."community_members" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "community_members:delete_self_or_admin" ON "public"."community_members" FOR DELETE TO "authenticated" USING ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "cm"."community_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum", 'moderator'::"public"."member_role_enum"])))))));



CREATE POLICY "community_members:insert_self" ON "public"."community_members" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "community_members:select_member" ON "public"."community_members" FOR SELECT TO "authenticated" USING ((("user_id" = "auth"."uid"()) OR "public"."is_community_member_direct"("community_id", "auth"."uid"())));



CREATE POLICY "community_members:update_admin" ON "public"."community_members" FOR UPDATE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "cm"."community_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"]))))));



ALTER TABLE "public"."conversation_members" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "conversation_members:delete_self" ON "public"."conversation_members" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "conversation_members:select_self" ON "public"."conversation_members" FOR SELECT TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "conversation_members:update_self" ON "public"."conversation_members" FOR UPDATE TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."conversations" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "conversations:select_member" ON "public"."conversations" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."conversation_members" "cm"
  WHERE (("cm"."conversation_id" = "conversations"."id") AND ("cm"."user_id" = "auth"."uid"())))));



ALTER TABLE "public"."event_applications" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "event_applications:insert_own" ON "public"."event_applications" FOR INSERT TO "authenticated" WITH CHECK ((("auth"."uid"() = "applicant_id") AND (NOT (EXISTS ( SELECT 1
   FROM "public"."events" "e"
  WHERE (("e"."id" = "event_applications"."event_id") AND "public"."have_blocked_each_other"("auth"."uid"(), "e"."host_id")))))));



CREATE POLICY "event_applications:select_own_or_host" ON "public"."event_applications" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "applicant_id") OR ("auth"."uid"() = "public"."get_event_host_id"("event_id"))));



CREATE POLICY "event_applications:update_cancel_own" ON "public"."event_applications" FOR UPDATE TO "authenticated" USING ((("auth"."uid"() = "applicant_id") AND ("status" = 'pending'::"public"."event_application_status_enum"))) WITH CHECK ((("auth"."uid"() = "applicant_id") AND ("status" = 'cancelled'::"public"."event_application_status_enum")));



CREATE POLICY "event_applications:update_host" ON "public"."event_applications" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "public"."get_event_host_id"("event_id"))) WITH CHECK (("auth"."uid"() = "public"."get_event_host_id"("event_id")));



ALTER TABLE "public"."event_invites" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "event_invites:delete_host_or_inviter" ON "public"."event_invites" FOR DELETE TO "authenticated" USING ((("invited_by" = "auth"."uid"()) OR ("auth"."uid"() = "public"."get_event_host_id"("event_id"))));



CREATE POLICY "event_invites:insert_host_or_member" ON "public"."event_invites" FOR INSERT TO "authenticated" WITH CHECK ((("invited_by" = "auth"."uid"()) AND (EXISTS ( SELECT 1
   FROM "public"."events" "e"
  WHERE (("e"."id" = "event_invites"."event_id") AND (("e"."host_id" = "auth"."uid"()) OR ("e"."visibility" <> 'invite_only'::"public"."event_visibility_enum")))))));



CREATE POLICY "event_invites:select_involved" ON "public"."event_invites" FOR SELECT TO "authenticated" USING ((("invited_by" = "auth"."uid"()) OR ("invited_user_id" = "auth"."uid"()) OR ("auth"."uid"() = "public"."get_event_host_id"("event_id"))));



CREATE POLICY "event_invites:update_invited" ON "public"."event_invites" FOR UPDATE TO "authenticated" USING (("invited_user_id" = "auth"."uid"())) WITH CHECK (("invited_user_id" = "auth"."uid"()));



ALTER TABLE "public"."event_ratings" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "event_ratings:insert_self" ON "public"."event_ratings" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "rater_id"));



CREATE POLICY "event_ratings:select_all" ON "public"."event_ratings" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."events" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "events:delete_own" ON "public"."events" FOR DELETE TO "authenticated" USING (("host_id" = "auth"."uid"()));



CREATE POLICY "events:insert_by_type" ON "public"."events" FOR INSERT TO "authenticated" WITH CHECK ((("host_id" = "auth"."uid"()) AND (("event_type" = ANY (ARRAY['public'::"public"."event_type_enum", 'public_application'::"public"."event_type_enum", 'private'::"public"."event_type_enum", 'invite_only'::"public"."event_type_enum"])) OR (("event_type" = 'group_event'::"public"."event_type_enum") AND (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "events"."group_id") AND ("gm"."user_id" = "auth"."uid"()))))) OR (("event_type" = 'community_event'::"public"."event_type_enum") AND (EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "events"."community_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"])))))))));



CREATE POLICY "events:select_by_type" ON "public"."events" FOR SELECT TO "authenticated" USING ((("auth"."uid"() IS NOT NULL) AND (NOT "public"."have_blocked_each_other"("auth"."uid"(), "host_id")) AND (("host_id" = "auth"."uid"()) OR ("event_type" = ANY (ARRAY['public'::"public"."event_type_enum", 'public_application'::"public"."event_type_enum", 'private'::"public"."event_type_enum"])) OR (("event_type" = 'invite_only'::"public"."event_type_enum") AND ((EXISTS ( SELECT 1
   FROM "public"."event_invites" "ei"
  WHERE (("ei"."event_id" = "events"."id") AND ("ei"."invited_user_id" = "auth"."uid"())))) OR (EXISTS ( SELECT 1
   FROM "public"."event_applications" "ea"
  WHERE (("ea"."event_id" = "events"."id") AND ("ea"."applicant_id" = "auth"."uid"()) AND ("ea"."status" = 'approved'::"public"."event_application_status_enum")))))) OR (("event_type" = 'group_event'::"public"."event_type_enum") AND (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "events"."group_id") AND ("gm"."user_id" = "auth"."uid"()))))) OR (("event_type" = 'community_event'::"public"."event_type_enum") AND (EXISTS ( SELECT 1
   FROM "public"."community_members" "cm"
  WHERE (("cm"."community_id" = "events"."community_id") AND ("cm"."user_id" = "auth"."uid"()))))))));



ALTER TABLE "public"."frames" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "frames: delete own" ON "public"."frames" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "frames: insert own" ON "public"."frames" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "frames: select own" ON "public"."frames" FOR SELECT TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "frames: update own" ON "public"."frames" FOR UPDATE TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "frames: viewable with full access" ON "public"."frames" FOR SELECT TO "authenticated" USING ((("user_id" = "auth"."uid"()) OR (("public"."get_profile_access_level"("auth"."uid"(), "user_id") = 'full'::"text") AND ("expires_at" > "now"()) AND ("is_expired" = false))));



ALTER TABLE "public"."group_invites" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "group_invites:delete_pending" ON "public"."group_invites" FOR DELETE TO "authenticated" USING ((("status" = 'pending'::"text") AND (("invited_by" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "group_invites"."group_id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"]))))))));



CREATE POLICY "group_invites:insert_member" ON "public"."group_invites" FOR INSERT TO "authenticated" WITH CHECK ((("invited_by" = "auth"."uid"()) AND (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "group_invites"."group_id") AND ("gm"."user_id" = "auth"."uid"())))) AND (("role" = 'member'::"public"."member_role_enum") OR (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "group_invites"."group_id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"])))))) AND (EXISTS ( SELECT 1
   FROM "public"."match_requests" "mr"
  WHERE (("mr"."status" = 'accepted'::"public"."match_status_enum") AND ((("mr"."requester_id" = "auth"."uid"()) AND ("mr"."target_id" = "group_invites"."invited_user_id")) OR (("mr"."requester_id" = "group_invites"."invited_user_id") AND ("mr"."target_id" = "auth"."uid"())))))) AND (NOT (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "group_invites"."group_id") AND ("gm"."user_id" = "group_invites"."invited_user_id"))))) AND (NOT "public"."have_blocked_each_other"("auth"."uid"(), "invited_user_id"))));



CREATE POLICY "group_invites:select_involved" ON "public"."group_invites" FOR SELECT TO "authenticated" USING ((("invited_by" = "auth"."uid"()) OR ("invited_user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "group_invites"."group_id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"])))))));



CREATE POLICY "group_invites:update_invitee" ON "public"."group_invites" FOR UPDATE TO "authenticated" USING ((("invited_user_id" = "auth"."uid"()) AND ("status" = 'pending'::"text"))) WITH CHECK ((("invited_user_id" = "auth"."uid"()) AND ("status" = ANY (ARRAY['accepted'::"text", 'declined'::"text"]))));



ALTER TABLE "public"."group_members" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "group_members:delete_self_or_admin" ON "public"."group_members" FOR DELETE TO "authenticated" USING ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "gm"."group_id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"])))))));



CREATE POLICY "group_members:insert_self" ON "public"."group_members" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "group_members:select_member" ON "public"."group_members" FOR SELECT TO "authenticated" USING ((("user_id" = "auth"."uid"()) OR "public"."is_group_member_direct"("group_id", "auth"."uid"())));



CREATE POLICY "group_members:update_admin" ON "public"."group_members" FOR UPDATE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "gm"."group_id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"]))))));



ALTER TABLE "public"."groups" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "groups:delete_owner" ON "public"."groups" FOR DELETE TO "authenticated" USING (("created_by" = "auth"."uid"()));



CREATE POLICY "groups:insert_own" ON "public"."groups" FOR INSERT TO "authenticated" WITH CHECK (("created_by" = "auth"."uid"()));



CREATE POLICY "groups:select_public" ON "public"."groups" FOR SELECT TO "authenticated" USING (((NOT "is_private") OR ("created_by" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "groups"."id") AND ("gm"."user_id" = "auth"."uid"()))))));



CREATE POLICY "groups:update_admin" ON "public"."groups" FOR UPDATE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "groups"."id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."role" = ANY (ARRAY['owner'::"public"."member_role_enum", 'admin'::"public"."member_role_enum"]))))));



ALTER TABLE "public"."hobbies_master" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "hobbies_master: read" ON "public"."hobbies_master" FOR SELECT USING (true);



CREATE POLICY "hobbies_master: seed by service_role" ON "public"."hobbies_master" FOR INSERT TO "service_role" WITH CHECK (true);



ALTER TABLE "public"."languages_master" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "languages_master: read" ON "public"."languages_master" FOR SELECT USING (true);



CREATE POLICY "languages_master: seed by service_role" ON "public"."languages_master" FOR INSERT TO "service_role" WITH CHECK (true);



ALTER TABLE "public"."lifestyle" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "lifestyle: delete self" ON "public"."lifestyle" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "lifestyle: insert self" ON "public"."lifestyle" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "lifestyle: matched users can view" ON "public"."lifestyle" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "user_id") OR "public"."is_matched_with"("user_id")));



CREATE POLICY "lifestyle: update self" ON "public"."lifestyle" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "lifestyle_insert_own" ON "public"."lifestyle" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "lifestyle_update_own" ON "public"."lifestyle" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."match_requests" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "match_requests: create request" ON "public"."match_requests" FOR INSERT TO "authenticated" WITH CHECK ((("requester_id" = "auth"."uid"()) AND ("requester_id" <> "target_id") AND ("status" = 'pending'::"public"."match_status_enum")));



CREATE POLICY "match_requests: read mine" ON "public"."match_requests" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "requester_id") OR ("auth"."uid"() = "target_id")));



CREATE POLICY "match_requests: read own" ON "public"."match_requests" FOR SELECT TO "authenticated" USING ((("requester_id" = "auth"."uid"()) OR ("target_id" = "auth"."uid"())));



CREATE POLICY "match_requests: requester cancel" ON "public"."match_requests" FOR DELETE TO "authenticated" USING ((("auth"."uid"() = "requester_id") AND ("status" = 'pending'::"public"."match_status_enum")));



CREATE POLICY "match_requests: requester insert" ON "public"."match_requests" FOR INSERT TO "authenticated" WITH CHECK ((("auth"."uid"() = "requester_id") AND ("requester_id" <> "target_id")));



CREATE POLICY "match_requests: respond" ON "public"."match_requests" FOR UPDATE TO "authenticated" USING ((("target_id" = "auth"."uid"()) AND ("status" = 'pending'::"public"."match_status_enum"))) WITH CHECK ((("target_id" = "auth"."uid"()) AND ("status" = ANY (ARRAY['accepted'::"public"."match_status_enum", 'rejected'::"public"."match_status_enum"]))));



CREATE POLICY "match_requests: target respond" ON "public"."match_requests" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "target_id")) WITH CHECK (("auth"."uid"() = "target_id"));



ALTER TABLE "public"."message_reads" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "message_reads:delete_self" ON "public"."message_reads" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "message_reads:insert_self" ON "public"."message_reads" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "message_reads:select_conversation_members" ON "public"."message_reads" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ("public"."messages" "m"
     JOIN "public"."conversation_members" "cm" ON (("cm"."conversation_id" = "m"."conversation_id")))
  WHERE (("m"."id" = "message_reads"."message_id") AND ("cm"."user_id" = "auth"."uid"())))));



CREATE POLICY "message_reads:select_self" ON "public"."message_reads" FOR SELECT TO "authenticated" USING (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."messages" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "messages:insert_member" ON "public"."messages" FOR INSERT TO "authenticated" WITH CHECK ((("sender_id" = "auth"."uid"()) AND (EXISTS ( SELECT 1
   FROM "public"."conversation_members" "cm"
  WHERE (("cm"."conversation_id" = "messages"."conversation_id") AND ("cm"."user_id" = "auth"."uid"())))) AND (NOT (EXISTS ( SELECT 1
   FROM ("public"."conversations" "c"
     JOIN "public"."match_requests" "mr" ON (("c"."match_request_id" = "mr"."id")))
  WHERE (("c"."id" = "messages"."conversation_id") AND "public"."have_blocked_each_other"("mr"."requester_id", "mr"."target_id")))))));



CREATE POLICY "messages:select_member" ON "public"."messages" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."conversation_members" "cm"
  WHERE (("cm"."conversation_id" = "messages"."conversation_id") AND ("cm"."user_id" = "auth"."uid"())))));



ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "profiles: insert self" ON "public"."profiles" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "profiles: matched users can view" ON "public"."profiles" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "id") OR "public"."is_matched_with"("id")));



CREATE POLICY "profiles: read self" ON "public"."profiles" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "id"));



CREATE POLICY "profiles: self read" ON "public"."profiles" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "id"));



CREATE POLICY "profiles: self update" ON "public"."profiles" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "profiles: update self" ON "public"."profiles" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));



ALTER TABLE "public"."user_hobbies" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_hobbies: delete self" ON "public"."user_hobbies" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "user_hobbies: insert self" ON "public"."user_hobbies" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "user_hobbies: manage self" ON "public"."user_hobbies" USING (("public"."current_user_id"() = "user_id")) WITH CHECK (("public"."current_user_id"() = "user_id"));



CREATE POLICY "user_hobbies: matched users can view" ON "public"."user_hobbies" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "user_id") OR "public"."is_matched_with"("user_id")));



CREATE POLICY "user_hobbies: update self" ON "public"."user_hobbies" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."user_languages" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_languages: delete self" ON "public"."user_languages" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "user_languages: insert self" ON "public"."user_languages" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "user_languages: select matched" ON "public"."user_languages" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "user_id") OR "public"."is_matched_with"("user_id")));



ALTER TABLE "public"."user_photos" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_photos: delete self" ON "public"."user_photos" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "user_photos: insert self" ON "public"."user_photos" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "user_photos: matched users can view" ON "public"."user_photos" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "user_id") OR "public"."is_matched_with"("user_id")));



CREATE POLICY "user_photos: update self" ON "public"."user_photos" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."messages";



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



GRANT ALL ON FUNCTION "public"."box2d_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."box2d_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."box2d_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box2d_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."box2d_out"("public"."box2d") TO "postgres";
GRANT ALL ON FUNCTION "public"."box2d_out"("public"."box2d") TO "anon";
GRANT ALL ON FUNCTION "public"."box2d_out"("public"."box2d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box2d_out"("public"."box2d") TO "service_role";



GRANT ALL ON FUNCTION "public"."box2df_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."box2df_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."box2df_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box2df_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."box2df_out"("public"."box2df") TO "postgres";
GRANT ALL ON FUNCTION "public"."box2df_out"("public"."box2df") TO "anon";
GRANT ALL ON FUNCTION "public"."box2df_out"("public"."box2df") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box2df_out"("public"."box2df") TO "service_role";



GRANT ALL ON FUNCTION "public"."box3d_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."box3d_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."box3d_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box3d_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."box3d_out"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."box3d_out"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."box3d_out"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box3d_out"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_analyze"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_analyze"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_analyze"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_analyze"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_in"("cstring", "oid", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_in"("cstring", "oid", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geography_in"("cstring", "oid", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_in"("cstring", "oid", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_out"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_out"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_out"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_out"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_recv"("internal", "oid", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_recv"("internal", "oid", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geography_recv"("internal", "oid", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_recv"("internal", "oid", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_send"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_send"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_send"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_send"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_typmod_in"("cstring"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_typmod_in"("cstring"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."geography_typmod_in"("cstring"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_typmod_in"("cstring"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_typmod_out"(integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_typmod_out"(integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geography_typmod_out"(integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_typmod_out"(integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_analyze"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_analyze"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_analyze"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_analyze"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_out"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_out"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_out"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_out"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_recv"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_recv"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_recv"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_recv"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_send"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_send"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_send"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_send"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_typmod_in"("cstring"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_typmod_in"("cstring"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_typmod_in"("cstring"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_typmod_in"("cstring"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_typmod_out"(integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_typmod_out"(integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_typmod_out"(integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_typmod_out"(integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."gidx_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gidx_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gidx_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gidx_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."gidx_out"("public"."gidx") TO "postgres";
GRANT ALL ON FUNCTION "public"."gidx_out"("public"."gidx") TO "anon";
GRANT ALL ON FUNCTION "public"."gidx_out"("public"."gidx") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gidx_out"("public"."gidx") TO "service_role";



GRANT ALL ON FUNCTION "public"."spheroid_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."spheroid_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."spheroid_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."spheroid_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."spheroid_out"("public"."spheroid") TO "postgres";
GRANT ALL ON FUNCTION "public"."spheroid_out"("public"."spheroid") TO "anon";
GRANT ALL ON FUNCTION "public"."spheroid_out"("public"."spheroid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."spheroid_out"("public"."spheroid") TO "service_role";



GRANT ALL ON FUNCTION "public"."box3d"("public"."box2d") TO "postgres";
GRANT ALL ON FUNCTION "public"."box3d"("public"."box2d") TO "anon";
GRANT ALL ON FUNCTION "public"."box3d"("public"."box2d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box3d"("public"."box2d") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("public"."box2d") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("public"."box2d") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("public"."box2d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("public"."box2d") TO "service_role";



GRANT ALL ON FUNCTION "public"."box"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."box"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."box"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."box2d"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."box2d"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."box2d"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box2d"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."geography"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."bytea"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."bytea"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."bytea"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."bytea"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography"("public"."geography", integer, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."geography"("public"."geography", integer, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."geography"("public"."geography", integer, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography"("public"."geography", integer, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."box"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."box"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."box"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."box2d"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."box2d"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."box2d"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box2d"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."box3d"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."box3d"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."box3d"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box3d"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."bytea"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."bytea"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."bytea"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."bytea"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geography"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("public"."geometry", integer, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("public"."geometry", integer, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("public"."geometry", integer, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("public"."geometry", integer, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."json"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."json"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."json"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."json"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."jsonb"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."jsonb"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."jsonb"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."jsonb"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."path"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."path"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."path"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."path"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."point"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."point"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."point"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."point"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."polygon"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."polygon"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."polygon"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."polygon"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."text"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."text"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."text"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."text"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("path") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("path") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("path") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("path") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("point") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("point") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("point") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("point") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("polygon") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("polygon") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("polygon") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("polygon") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry"("text") TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."_postgis_deprecate"("oldname" "text", "newname" "text", "version" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."_postgis_deprecate"("oldname" "text", "newname" "text", "version" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_postgis_deprecate"("oldname" "text", "newname" "text", "version" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_postgis_deprecate"("oldname" "text", "newname" "text", "version" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_postgis_index_extent"("tbl" "regclass", "col" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."_postgis_index_extent"("tbl" "regclass", "col" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_postgis_index_extent"("tbl" "regclass", "col" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_postgis_index_extent"("tbl" "regclass", "col" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_postgis_join_selectivity"("regclass", "text", "regclass", "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."_postgis_join_selectivity"("regclass", "text", "regclass", "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_postgis_join_selectivity"("regclass", "text", "regclass", "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_postgis_join_selectivity"("regclass", "text", "regclass", "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_postgis_pgsql_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."_postgis_pgsql_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."_postgis_pgsql_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_postgis_pgsql_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_postgis_scripts_pgsql_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."_postgis_scripts_pgsql_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."_postgis_scripts_pgsql_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_postgis_scripts_pgsql_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_postgis_selectivity"("tbl" "regclass", "att_name" "text", "geom" "public"."geometry", "mode" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."_postgis_selectivity"("tbl" "regclass", "att_name" "text", "geom" "public"."geometry", "mode" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_postgis_selectivity"("tbl" "regclass", "att_name" "text", "geom" "public"."geometry", "mode" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_postgis_selectivity"("tbl" "regclass", "att_name" "text", "geom" "public"."geometry", "mode" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_postgis_stats"("tbl" "regclass", "att_name" "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."_postgis_stats"("tbl" "regclass", "att_name" "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_postgis_stats"("tbl" "regclass", "att_name" "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_postgis_stats"("tbl" "regclass", "att_name" "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_asgml"(integer, "public"."geometry", integer, integer, "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_asgml"(integer, "public"."geometry", integer, integer, "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_asgml"(integer, "public"."geometry", integer, integer, "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_asgml"(integer, "public"."geometry", integer, integer, "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_asx3d"(integer, "public"."geometry", integer, integer, "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_asx3d"(integer, "public"."geometry", integer, integer, "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_asx3d"(integer, "public"."geometry", integer, integer, "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_asx3d"(integer, "public"."geometry", integer, integer, "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_bestsrid"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography", double precision, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography", double precision, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography", double precision, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_distancetree"("public"."geography", "public"."geography", double precision, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", double precision, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", double precision, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", double precision, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_distanceuncached"("public"."geography", "public"."geography", double precision, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_dwithinuncached"("public"."geography", "public"."geography", double precision, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_expand"("public"."geography", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_expand"("public"."geography", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_expand"("public"."geography", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_expand"("public"."geography", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_geomfromgml"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_geomfromgml"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_geomfromgml"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_geomfromgml"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_pointoutside"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_pointoutside"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_pointoutside"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_pointoutside"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_sortablehash"("geom" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_sortablehash"("geom" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_sortablehash"("geom" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_sortablehash"("geom" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_voronoi"("g1" "public"."geometry", "clip" "public"."geometry", "tolerance" double precision, "return_polygons" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_voronoi"("g1" "public"."geometry", "clip" "public"."geometry", "tolerance" double precision, "return_polygons" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."_st_voronoi"("g1" "public"."geometry", "clip" "public"."geometry", "tolerance" double precision, "return_polygons" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_voronoi"("g1" "public"."geometry", "clip" "public"."geometry", "tolerance" double precision, "return_polygons" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."_st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."_st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."_st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."accept_event_invite"("p_invite_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."accept_event_invite"("p_invite_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."accept_event_invite"("p_invite_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."accept_group_invite"("p_invite_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."accept_group_invite"("p_invite_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."accept_group_invite"("p_invite_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."add_approved_applicant_to_event_chat"() TO "anon";
GRANT ALL ON FUNCTION "public"."add_approved_applicant_to_event_chat"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_approved_applicant_to_event_chat"() TO "service_role";



GRANT ALL ON FUNCTION "public"."add_invited_user_to_event_chat"() TO "anon";
GRANT ALL ON FUNCTION "public"."add_invited_user_to_event_chat"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_invited_user_to_event_chat"() TO "service_role";



GRANT ALL ON FUNCTION "public"."addauth"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."addauth"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."addauth"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."addauth"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."addgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer, "new_type" character varying, "new_dim" integer, "use_typmod" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."apply_to_event"("p_event_id" "uuid", "p_message" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."apply_to_event"("p_event_id" "uuid", "p_message" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."apply_to_event"("p_event_id" "uuid", "p_message" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."are_in_same_community"("p_user1" "uuid", "p_user2" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."are_in_same_community"("p_user1" "uuid", "p_user2" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."are_in_same_community"("p_user1" "uuid", "p_user2" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."are_in_same_group"("p_user1" "uuid", "p_user2" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."are_in_same_group"("p_user1" "uuid", "p_user2" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."are_in_same_group"("p_user1" "uuid", "p_user2" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."box3dtobox"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."box3dtobox"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."box3dtobox"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."box3dtobox"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_invite_to_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_invite_to_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_invite_to_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_join_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_join_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_join_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_manage_group_photo"("file_path" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."can_manage_group_photo"("file_path" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_manage_group_photo"("file_path" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_rate_event"("p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_rate_event"("p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_rate_event"("p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_see_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_see_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_see_event"("p_user_id" "uuid", "p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_see_on_map"("me" "uuid", "other" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_see_on_map"("me" "uuid", "other" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_see_on_map"("me" "uuid", "other" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_send_match_request"("p_requester_id" "uuid", "p_target_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_send_match_request"("p_requester_id" "uuid", "p_target_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_send_match_request"("p_requester_id" "uuid", "p_target_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_view_full"("me" "uuid", "other" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_view_full"("me" "uuid", "other" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_view_full"("me" "uuid", "other" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."can_view_preview"("me" "uuid", "other" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."can_view_preview"("me" "uuid", "other" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."can_view_preview"("me" "uuid", "other" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."check_user_exists"("user_email" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."check_user_exists"("user_email" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_user_exists"("user_email" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."checkauth"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."checkauth"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."checkauth"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."checkauth"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."checkauth"("text", "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."checkauth"("text", "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."checkauth"("text", "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."checkauth"("text", "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."checkauthtrigger"() TO "postgres";
GRANT ALL ON FUNCTION "public"."checkauthtrigger"() TO "anon";
GRANT ALL ON FUNCTION "public"."checkauthtrigger"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."checkauthtrigger"() TO "service_role";



GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."box2df") TO "postgres";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."box2df") TO "anon";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."box2df") TO "authenticated";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."box2df") TO "service_role";



GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."box2df", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."contains_2d"("public"."geometry", "public"."box2df") TO "postgres";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."geometry", "public"."box2df") TO "anon";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."geometry", "public"."box2df") TO "authenticated";
GRANT ALL ON FUNCTION "public"."contains_2d"("public"."geometry", "public"."box2df") TO "service_role";



GRANT ALL ON FUNCTION "public"."create_community_conversation"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_community_conversation"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_community_conversation"() TO "service_role";



GRANT ALL ON FUNCTION "public"."create_event_group_chat"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_event_group_chat"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_event_group_chat"() TO "service_role";



GRANT ALL ON FUNCTION "public"."create_event_v2"("p_event_data" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."create_event_v2"("p_event_data" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_event_v2"("p_event_data" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."create_event_with_location"("p_event_data" json) TO "anon";
GRANT ALL ON FUNCTION "public"."create_event_with_location"("p_event_data" json) TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_event_with_location"("p_event_data" json) TO "service_role";



GRANT ALL ON FUNCTION "public"."create_group_conversation"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_group_conversation"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_group_conversation"() TO "service_role";



GRANT ALL ON FUNCTION "public"."current_user_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."current_user_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."current_user_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."decline_group_invite"("p_invite_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."decline_group_invite"("p_invite_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."decline_group_invite"("p_invite_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."disablelongtransactions"() TO "postgres";
GRANT ALL ON FUNCTION "public"."disablelongtransactions"() TO "anon";
GRANT ALL ON FUNCTION "public"."disablelongtransactions"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."disablelongtransactions"() TO "service_role";



GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("table_name" character varying, "column_name" character varying) TO "postgres";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("table_name" character varying, "column_name" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("table_name" character varying, "column_name" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("table_name" character varying, "column_name" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "postgres";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "postgres";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."dropgeometrycolumn"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."dropgeometrytable"("table_name" character varying) TO "postgres";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("table_name" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("table_name" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("table_name" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."dropgeometrytable"("schema_name" character varying, "table_name" character varying) TO "postgres";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("schema_name" character varying, "table_name" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("schema_name" character varying, "table_name" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("schema_name" character varying, "table_name" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."dropgeometrytable"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying) TO "postgres";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."dropgeometrytable"("catalog_name" character varying, "schema_name" character varying, "table_name" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."enablelongtransactions"() TO "postgres";
GRANT ALL ON FUNCTION "public"."enablelongtransactions"() TO "anon";
GRANT ALL ON FUNCTION "public"."enablelongtransactions"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enablelongtransactions"() TO "service_role";



GRANT ALL ON FUNCTION "public"."enforce_hobby_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_hobby_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_hobby_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."enforce_hobby_count_stmt"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_hobby_count_stmt"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_hobby_count_stmt"() TO "service_role";



GRANT ALL ON FUNCTION "public"."enforce_photo_max_4"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_photo_max_4"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_photo_max_4"() TO "service_role";



GRANT ALL ON FUNCTION "public"."equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."expire_ended_events"() TO "anon";
GRANT ALL ON FUNCTION "public"."expire_ended_events"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."expire_ended_events"() TO "service_role";



GRANT ALL ON FUNCTION "public"."find_srid"(character varying, character varying, character varying) TO "postgres";
GRANT ALL ON FUNCTION "public"."find_srid"(character varying, character varying, character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."find_srid"(character varying, character varying, character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."find_srid"(character varying, character varying, character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."frames_after_insert_set_pointer"() TO "anon";
GRANT ALL ON FUNCTION "public"."frames_after_insert_set_pointer"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."frames_after_insert_set_pointer"() TO "service_role";



GRANT ALL ON FUNCTION "public"."frames_after_update_clear_pointer"() TO "anon";
GRANT ALL ON FUNCTION "public"."frames_after_update_clear_pointer"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."frames_after_update_clear_pointer"() TO "service_role";



GRANT ALL ON FUNCTION "public"."frames_before_insert_rotate"() TO "anon";
GRANT ALL ON FUNCTION "public"."frames_before_insert_rotate"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."frames_before_insert_rotate"() TO "service_role";



GRANT ALL ON FUNCTION "public"."geog_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geog_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geog_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geog_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_cmp"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_cmp"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_cmp"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_cmp"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_distance_knn"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_distance_knn"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_distance_knn"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_distance_knn"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_eq"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_eq"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_eq"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_eq"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_ge"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_ge"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_ge"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_ge"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_consistent"("internal", "public"."geography", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_consistent"("internal", "public"."geography", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_consistent"("internal", "public"."geography", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_consistent"("internal", "public"."geography", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_decompress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_decompress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_decompress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_decompress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_distance"("internal", "public"."geography", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_distance"("internal", "public"."geography", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_distance"("internal", "public"."geography", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_distance"("internal", "public"."geography", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_same"("public"."box2d", "public"."box2d", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_same"("public"."box2d", "public"."box2d", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_same"("public"."box2d", "public"."box2d", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_same"("public"."box2d", "public"."box2d", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gist_union"("bytea", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gist_union"("bytea", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gist_union"("bytea", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gist_union"("bytea", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_gt"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_gt"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_gt"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_gt"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_le"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_le"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_le"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_le"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_lt"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_lt"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_lt"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_lt"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_overlaps"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_overlaps"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_overlaps"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_overlaps"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_spgist_choose_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_spgist_choose_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_spgist_choose_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_spgist_choose_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_spgist_compress_nd"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_spgist_compress_nd"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_spgist_compress_nd"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_spgist_compress_nd"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_spgist_config_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_spgist_config_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_spgist_config_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_spgist_config_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_spgist_inner_consistent_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_spgist_inner_consistent_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_spgist_inner_consistent_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_spgist_inner_consistent_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_spgist_leaf_consistent_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_spgist_leaf_consistent_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_spgist_leaf_consistent_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_spgist_leaf_consistent_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geography_spgist_picksplit_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geography_spgist_picksplit_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geography_spgist_picksplit_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geography_spgist_picksplit_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geom2d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geom2d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geom2d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geom2d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geom3d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geom3d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geom3d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geom3d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geom4d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geom4d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geom4d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geom4d_brin_inclusion_add_value"("internal", "internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_above"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_above"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_above"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_above"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_below"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_below"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_below"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_below"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_cmp"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_cmp"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_cmp"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_cmp"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_contained_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_contained_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_contained_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_contained_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_contains_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_contains_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_contains_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_contains_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_contains_nd"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_contains_nd"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_contains_nd"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_contains_nd"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_distance_box"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_distance_box"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_distance_box"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_distance_box"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_distance_centroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_distance_centroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_distance_centroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_distance_centroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_distance_centroid_nd"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_distance_centroid_nd"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_distance_centroid_nd"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_distance_centroid_nd"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_distance_cpa"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_distance_cpa"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_distance_cpa"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_distance_cpa"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_eq"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_eq"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_eq"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_eq"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_ge"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_ge"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_ge"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_ge"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_compress_2d"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_compress_2d"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_compress_2d"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_compress_2d"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_compress_nd"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_compress_nd"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_compress_nd"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_compress_nd"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_2d"("internal", "public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_2d"("internal", "public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_2d"("internal", "public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_2d"("internal", "public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_nd"("internal", "public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_nd"("internal", "public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_nd"("internal", "public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_consistent_nd"("internal", "public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_2d"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_2d"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_2d"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_2d"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_nd"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_nd"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_nd"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_decompress_nd"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_distance_2d"("internal", "public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_distance_2d"("internal", "public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_distance_2d"("internal", "public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_distance_2d"("internal", "public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_distance_nd"("internal", "public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_distance_nd"("internal", "public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_distance_nd"("internal", "public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_distance_nd"("internal", "public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_2d"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_2d"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_2d"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_2d"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_nd"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_nd"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_nd"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_penalty_nd"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_2d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_2d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_2d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_2d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_picksplit_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_same_2d"("geom1" "public"."geometry", "geom2" "public"."geometry", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_same_2d"("geom1" "public"."geometry", "geom2" "public"."geometry", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_same_2d"("geom1" "public"."geometry", "geom2" "public"."geometry", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_same_2d"("geom1" "public"."geometry", "geom2" "public"."geometry", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_same_nd"("public"."geometry", "public"."geometry", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_same_nd"("public"."geometry", "public"."geometry", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_same_nd"("public"."geometry", "public"."geometry", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_same_nd"("public"."geometry", "public"."geometry", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_sortsupport_2d"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_sortsupport_2d"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_sortsupport_2d"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_sortsupport_2d"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_union_2d"("bytea", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_union_2d"("bytea", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_union_2d"("bytea", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_union_2d"("bytea", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gist_union_nd"("bytea", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gist_union_nd"("bytea", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gist_union_nd"("bytea", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gist_union_nd"("bytea", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_gt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_gt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_gt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_gt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_hash"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_hash"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_hash"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_hash"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_le"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_le"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_le"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_le"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_left"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_left"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_left"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_left"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_lt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_lt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_lt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_lt"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_overabove"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_overabove"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_overabove"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_overabove"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_overbelow"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_overbelow"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_overbelow"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_overbelow"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_overlaps_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_overlaps_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_overlaps_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_overlaps_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_overlaps_nd"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_overlaps_nd"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_overlaps_nd"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_overlaps_nd"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_overleft"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_overleft"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_overleft"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_overleft"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_overright"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_overright"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_overright"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_overright"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_right"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_right"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_right"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_right"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_same"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_same"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_same"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_same"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_same_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_same_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_same_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_same_3d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_same_nd"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_same_nd"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_same_nd"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_same_nd"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_sortsupport"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_sortsupport"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_sortsupport"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_sortsupport"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_2d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_2d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_2d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_2d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_3d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_3d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_3d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_3d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_choose_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_2d"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_2d"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_2d"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_2d"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_3d"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_3d"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_3d"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_3d"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_nd"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_nd"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_nd"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_compress_nd"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_config_2d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_2d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_2d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_2d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_config_3d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_3d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_3d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_3d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_config_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_config_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_2d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_2d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_2d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_2d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_3d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_3d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_3d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_3d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_inner_consistent_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_2d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_2d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_2d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_2d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_3d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_3d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_3d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_3d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_leaf_consistent_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_2d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_2d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_2d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_2d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_3d"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_3d"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_3d"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_3d"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_nd"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_nd"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_nd"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_spgist_picksplit_nd"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometry_within_nd"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometry_within_nd"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometry_within_nd"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometry_within_nd"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geometrytype"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."geomfromewkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."geomfromewkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."geomfromewkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geomfromewkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."geomfromewkt"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."geomfromewkt"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."geomfromewkt"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geomfromewkt"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_all_events_with_coordinates"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_all_events_with_coordinates"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_all_events_with_coordinates"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_community_members_basic"("p_community_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_community_members_basic"("p_community_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_community_members_basic"("p_community_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_connection_options"("p_target_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_connection_options"("p_target_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_connection_options"("p_target_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_event_applications_for_host"("p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_event_applications_for_host"("p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_event_applications_for_host"("p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_event_host_id"("p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_event_host_id"("p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_event_host_id"("p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_event_members"("p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_event_members"("p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_event_members"("p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_event_participants_preview"("p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_event_participants_preview"("p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_event_participants_preview"("p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_events_by_type"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer, "p_event_types" "public"."event_type_enum"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."get_events_by_type"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer, "p_event_types" "public"."event_type_enum"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_events_by_type"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer, "p_event_types" "public"."event_type_enum"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_events_with_coordinates"("p_status" "public"."event_status_enum") TO "anon";
GRANT ALL ON FUNCTION "public"."get_events_with_coordinates"("p_status" "public"."event_status_enum") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_events_with_coordinates"("p_status" "public"."event_status_enum") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_events_with_visibility"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_events_with_visibility"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_events_with_visibility"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_km" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_finished_event_participants"("p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_finished_event_participants"("p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_finished_event_participants"("p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_group_members_for_invitee"("p_group_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_group_members_for_invitee"("p_group_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_group_members_for_invitee"("p_group_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_group_members_with_connections"("p_group_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_group_members_with_connections"("p_group_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_group_members_with_connections"("p_group_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_group_pending_invites_for_invitee"("p_group_id" "uuid", "p_exclude_invite_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_group_pending_invites_for_invitee"("p_group_id" "uuid", "p_exclude_invite_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_group_pending_invites_for_invitee"("p_group_id" "uuid", "p_exclude_invite_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_host_rating_summary"("p_host_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_host_rating_summary"("p_host_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_host_rating_summary"("p_host_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_host_ratings"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_host_ratings"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_host_ratings"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_map_cards"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_map_cards"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_map_cards"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_map_cards_live"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_map_cards_live"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_map_cards_live"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_match_status"("target_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_match_status"("target_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_match_status"("target_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_match_status_extended"("target_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_match_status_extended"("target_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_match_status_extended"("target_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_matched_user_profile"("target_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_matched_user_profile"("target_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_matched_user_profile"("target_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_communities"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_communities"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_communities"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_groups"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_groups"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_groups"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_hosted_events"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_hosted_events"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_hosted_events"("p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_joined_events"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_joined_events"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_joined_events"("p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_nearby_events"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_nearby_events"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_nearby_events"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_pending_group_invites"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_pending_group_invites"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_pending_group_invites"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_nearby_events_with_coordinates"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_meters" integer, "p_status" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."get_nearby_events_with_coordinates"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_meters" integer, "p_status" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_nearby_events_with_coordinates"("p_user_lat" double precision, "p_user_lng" double precision, "p_radius_meters" integer, "p_status" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_profile_access_level"("p_viewer_id" "uuid", "p_target_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_profile_access_level"("p_viewer_id" "uuid", "p_target_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_profile_access_level"("p_viewer_id" "uuid", "p_target_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_profile_for_viewer"("p_target_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_profile_for_viewer"("p_target_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_profile_for_viewer"("p_target_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_profile_full_for_user"("target_user" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_profile_full_for_user"("target_user" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_profile_full_for_user"("target_user" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_profile_if_matched"("target" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_profile_if_matched"("target" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_profile_if_matched"("target" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_profile_preview_for_user"("target_user" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_profile_preview_for_user"("target_user" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_profile_preview_for_user"("target_user" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_proj4_from_srid"(integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."get_proj4_from_srid"(integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_proj4_from_srid"(integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_proj4_from_srid"(integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_user_active_frames"("target_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_active_frames"("target_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_active_frames"("target_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_user_preview_extended"("target_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_preview_extended"("target_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_preview_extended"("target_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."gettransactionid"() TO "postgres";
GRANT ALL ON FUNCTION "public"."gettransactionid"() TO "anon";
GRANT ALL ON FUNCTION "public"."gettransactionid"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."gettransactionid"() TO "service_role";



GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_2d"("internal", "oid", "internal", smallint) TO "postgres";
GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_2d"("internal", "oid", "internal", smallint) TO "anon";
GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_2d"("internal", "oid", "internal", smallint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_2d"("internal", "oid", "internal", smallint) TO "service_role";



GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_nd"("internal", "oid", "internal", smallint) TO "postgres";
GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_nd"("internal", "oid", "internal", smallint) TO "anon";
GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_nd"("internal", "oid", "internal", smallint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."gserialized_gist_joinsel_nd"("internal", "oid", "internal", smallint) TO "service_role";



GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_2d"("internal", "oid", "internal", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_2d"("internal", "oid", "internal", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_2d"("internal", "oid", "internal", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_2d"("internal", "oid", "internal", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_nd"("internal", "oid", "internal", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_nd"("internal", "oid", "internal", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_nd"("internal", "oid", "internal", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."gserialized_gist_sel_nd"("internal", "oid", "internal", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_event_application_approval"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_event_application_approval"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_event_application_approval"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_group_invite_acceptance"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_group_invite_acceptance"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_group_invite_acceptance"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_lifestyle_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_lifestyle_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_lifestyle_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_match_acceptance"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_match_acceptance"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_match_acceptance"() TO "service_role";



GRANT ALL ON FUNCTION "public"."have_blocked_each_other"("me" "uuid", "other" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."have_blocked_each_other"("me" "uuid", "other" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."have_blocked_each_other"("me" "uuid", "other" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."haversine_km"("lat1" numeric, "lon1" numeric, "lat2" numeric, "lon2" numeric) TO "anon";
GRANT ALL ON FUNCTION "public"."haversine_km"("lat1" numeric, "lon1" numeric, "lat2" numeric, "lon2" numeric) TO "authenticated";
GRANT ALL ON FUNCTION "public"."haversine_km"("lat1" numeric, "lon1" numeric, "lat2" numeric, "lon2" numeric) TO "service_role";



GRANT ALL ON FUNCTION "public"."is_community_member_direct"("p_community_id" "uuid", "p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_community_member_direct"("p_community_id" "uuid", "p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_community_member_direct"("p_community_id" "uuid", "p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."box2df") TO "postgres";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."box2df") TO "anon";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."box2df") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."box2df") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."box2df", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."geometry", "public"."box2df") TO "postgres";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."geometry", "public"."box2df") TO "anon";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."geometry", "public"."box2df") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_contained_2d"("public"."geometry", "public"."box2df") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_group_member_direct"("p_group_id" "uuid", "p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_group_member_direct"("p_group_id" "uuid", "p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_group_member_direct"("p_group_id" "uuid", "p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_matched_with"("other_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_matched_with"("other_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_matched_with"("other_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."join_community_by_code"("p_invite_code" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."join_community_by_code"("p_invite_code" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."join_community_by_code"("p_invite_code" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."join_event_direct"("p_event_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."join_event_direct"("p_event_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."join_event_direct"("p_event_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."join_group_by_code"("p_invite_code" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."join_group_by_code"("p_invite_code" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."join_group_by_code"("p_invite_code" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", timestamp without time zone) TO "postgres";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", timestamp without time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", timestamp without time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", timestamp without time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text", timestamp without time zone) TO "postgres";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text", timestamp without time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text", timestamp without time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."lockrow"("text", "text", "text", "text", timestamp without time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."longtransactionsenabled"() TO "postgres";
GRANT ALL ON FUNCTION "public"."longtransactionsenabled"() TO "anon";
GRANT ALL ON FUNCTION "public"."longtransactionsenabled"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."longtransactionsenabled"() TO "service_role";



GRANT ALL ON FUNCTION "public"."mark_all_expired_frames"() TO "anon";
GRANT ALL ON FUNCTION "public"."mark_all_expired_frames"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."mark_all_expired_frames"() TO "service_role";



GRANT ALL ON FUNCTION "public"."mark_expired_frames"() TO "anon";
GRANT ALL ON FUNCTION "public"."mark_expired_frames"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."mark_expired_frames"() TO "service_role";



GRANT ALL ON FUNCTION "public"."mark_messages_read"("p_conversation_id" "uuid", "p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."mark_messages_read"("p_conversation_id" "uuid", "p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."mark_messages_read"("p_conversation_id" "uuid", "p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."box2df") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."box2df") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."box2df") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."box2df") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."box2df", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."geometry", "public"."box2df") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."geometry", "public"."box2df") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."geometry", "public"."box2df") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_2d"("public"."geometry", "public"."box2df") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."geography", "public"."gidx") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."geography", "public"."gidx") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."geography", "public"."gidx") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."geography", "public"."gidx") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."gidx") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."gidx") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."gidx") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_geog"("public"."gidx", "public"."gidx") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."geometry", "public"."gidx") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."geometry", "public"."gidx") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."geometry", "public"."gidx") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."geometry", "public"."gidx") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."gidx") TO "postgres";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."gidx") TO "anon";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."gidx") TO "authenticated";
GRANT ALL ON FUNCTION "public"."overlaps_nd"("public"."gidx", "public"."gidx") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean, "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean, "text") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean, "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asflatgeobuf_transfn"("internal", "anyelement", boolean, "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asgeobuf_transfn"("internal", "anyelement", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_combinefn"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_combinefn"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_combinefn"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_combinefn"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_deserialfn"("bytea", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_deserialfn"("bytea", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_deserialfn"("bytea", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_deserialfn"("bytea", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_serialfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_serialfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_serialfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_serialfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_asmvt_transfn"("internal", "anyelement", "text", integer, "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_accum_transfn"("internal", "public"."geometry", double precision, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterintersecting_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterintersecting_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterintersecting_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterintersecting_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterwithin_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterwithin_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterwithin_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_clusterwithin_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_collect_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_collect_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_collect_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_collect_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_makeline_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_makeline_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_makeline_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_makeline_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_polygonize_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_polygonize_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_polygonize_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_polygonize_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_combinefn"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_combinefn"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_combinefn"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_combinefn"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_deserialfn"("bytea", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_deserialfn"("bytea", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_deserialfn"("bytea", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_deserialfn"("bytea", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_finalfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_finalfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_finalfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_finalfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_serialfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_serialfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_serialfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_serialfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."pgis_geometry_union_parallel_transfn"("internal", "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("use_typmod" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("use_typmod" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("use_typmod" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("use_typmod" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("tbl_oid" "oid", "use_typmod" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("tbl_oid" "oid", "use_typmod" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("tbl_oid" "oid", "use_typmod" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."populate_geometry_columns"("tbl_oid" "oid", "use_typmod" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_addbbox"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_addbbox"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_addbbox"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_addbbox"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_cache_bbox"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_cache_bbox"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_cache_bbox"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_cache_bbox"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_constraint_dims"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_constraint_dims"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_constraint_dims"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_constraint_dims"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_constraint_srid"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_constraint_srid"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_constraint_srid"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_constraint_srid"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_constraint_type"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_constraint_type"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_constraint_type"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_constraint_type"("geomschema" "text", "geomtable" "text", "geomcolumn" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_dropbbox"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_dropbbox"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_dropbbox"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_dropbbox"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_extensions_upgrade"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_extensions_upgrade"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_extensions_upgrade"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_extensions_upgrade"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_full_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_full_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_full_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_full_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_geos_noop"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_geos_noop"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_geos_noop"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_geos_noop"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_geos_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_geos_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_geos_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_geos_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_getbbox"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_getbbox"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_getbbox"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_getbbox"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_hasbbox"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_hasbbox"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_hasbbox"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_hasbbox"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_index_supportfn"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_index_supportfn"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_index_supportfn"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_index_supportfn"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_lib_build_date"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_lib_build_date"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_lib_build_date"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_lib_build_date"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_lib_revision"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_lib_revision"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_lib_revision"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_lib_revision"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_lib_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_lib_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_lib_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_lib_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_libjson_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_libjson_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_libjson_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_libjson_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_liblwgeom_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_liblwgeom_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_liblwgeom_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_liblwgeom_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_libprotobuf_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_libprotobuf_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_libprotobuf_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_libprotobuf_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_libxml_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_libxml_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_libxml_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_libxml_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_noop"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_noop"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_noop"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_noop"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_proj_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_proj_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_proj_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_proj_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_scripts_build_date"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_scripts_build_date"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_scripts_build_date"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_scripts_build_date"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_scripts_installed"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_scripts_installed"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_scripts_installed"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_scripts_installed"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_scripts_released"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_scripts_released"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_scripts_released"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_scripts_released"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_svn_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_svn_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_svn_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_svn_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_transform_geometry"("geom" "public"."geometry", "text", "text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_transform_geometry"("geom" "public"."geometry", "text", "text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_transform_geometry"("geom" "public"."geometry", "text", "text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_transform_geometry"("geom" "public"."geometry", "text", "text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_type_name"("geomname" character varying, "coord_dimension" integer, "use_new_name" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_type_name"("geomname" character varying, "coord_dimension" integer, "use_new_name" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_type_name"("geomname" character varying, "coord_dimension" integer, "use_new_name" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_type_name"("geomname" character varying, "coord_dimension" integer, "use_new_name" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_typmod_dims"(integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_typmod_dims"(integer) TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_typmod_dims"(integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_typmod_dims"(integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_typmod_srid"(integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_typmod_srid"(integer) TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_typmod_srid"(integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_typmod_srid"(integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_typmod_type"(integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_typmod_type"(integer) TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_typmod_type"(integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_typmod_type"(integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."postgis_wagyu_version"() TO "postgres";
GRANT ALL ON FUNCTION "public"."postgis_wagyu_version"() TO "anon";
GRANT ALL ON FUNCTION "public"."postgis_wagyu_version"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."postgis_wagyu_version"() TO "service_role";



GRANT ALL ON FUNCTION "public"."remove_user_from_event_chat"() TO "anon";
GRANT ALL ON FUNCTION "public"."remove_user_from_event_chat"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."remove_user_from_event_chat"() TO "service_role";



GRANT ALL ON FUNCTION "public"."send_match_request_full"("p_target_id" "uuid", "p_message" "text", "p_origin_event_id" "uuid", "p_origin_group_id" "uuid", "p_origin_community_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."send_match_request_full"("p_target_id" "uuid", "p_message" "text", "p_origin_event_id" "uuid", "p_origin_group_id" "uuid", "p_origin_community_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."send_match_request_full"("p_target_id" "uuid", "p_message" "text", "p_origin_event_id" "uuid", "p_origin_group_id" "uuid", "p_origin_community_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."send_match_request_with_context"("p_target_id" "uuid", "p_message" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."send_match_request_with_context"("p_target_id" "uuid", "p_message" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."send_match_request_with_context"("p_target_id" "uuid", "p_message" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dclosestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dclosestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dclosestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dclosestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3ddfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3ddistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3ddistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3ddistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3ddistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3ddwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dintersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dlength"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dlength"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dlength"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dlength"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dlineinterpolatepoint"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dlineinterpolatepoint"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dlineinterpolatepoint"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dlineinterpolatepoint"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dlongestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dlongestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dlongestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dlongestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dmakebox"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dmakebox"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dmakebox"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dmakebox"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dmaxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dmaxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dmaxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dmaxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dperimeter"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dperimeter"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dperimeter"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dperimeter"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_3dshortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dshortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dshortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dshortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_addmeasure"("public"."geometry", double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_addmeasure"("public"."geometry", double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_addmeasure"("public"."geometry", double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_addmeasure"("public"."geometry", double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_addpoint"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_affine"("public"."geometry", double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_angle"("line1" "public"."geometry", "line2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_angle"("line1" "public"."geometry", "line2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_angle"("line1" "public"."geometry", "line2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_angle"("line1" "public"."geometry", "line2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_angle"("pt1" "public"."geometry", "pt2" "public"."geometry", "pt3" "public"."geometry", "pt4" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_angle"("pt1" "public"."geometry", "pt2" "public"."geometry", "pt3" "public"."geometry", "pt4" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_angle"("pt1" "public"."geometry", "pt2" "public"."geometry", "pt3" "public"."geometry", "pt4" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_angle"("pt1" "public"."geometry", "pt2" "public"."geometry", "pt3" "public"."geometry", "pt4" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_area"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_area"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_area"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_area"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_area"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_area"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_area"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_area"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_area"("geog" "public"."geography", "use_spheroid" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_area"("geog" "public"."geography", "use_spheroid" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_area"("geog" "public"."geography", "use_spheroid" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_area"("geog" "public"."geography", "use_spheroid" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_area2d"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_area2d"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_area2d"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_area2d"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geography", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asbinary"("public"."geometry", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asencodedpolyline"("geom" "public"."geometry", "nprecision" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asencodedpolyline"("geom" "public"."geometry", "nprecision" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asencodedpolyline"("geom" "public"."geometry", "nprecision" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asencodedpolyline"("geom" "public"."geometry", "nprecision" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asewkb"("public"."geometry", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asewkt"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asewkt"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asewkt"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asewkt"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geography", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asewkt"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgeojson"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgeojson"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgeojson"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgeojson"("r" "record", "geom_column" "text", "maxdecimaldigits" integer, "pretty_bool" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("r" "record", "geom_column" "text", "maxdecimaldigits" integer, "pretty_bool" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("r" "record", "geom_column" "text", "maxdecimaldigits" integer, "pretty_bool" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgeojson"("r" "record", "geom_column" "text", "maxdecimaldigits" integer, "pretty_bool" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgml"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgml"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgml"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgml"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgml"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgml"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgml"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgml"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgml"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgml"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgml"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgml"("geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geog" "public"."geography", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgml"("version" integer, "geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer, "nprefix" "text", "id" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_ashexewkb"("public"."geometry", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_askml"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_askml"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_askml"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_askml"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_askml"("geog" "public"."geography", "maxdecimaldigits" integer, "nprefix" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_askml"("geog" "public"."geography", "maxdecimaldigits" integer, "nprefix" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_askml"("geog" "public"."geography", "maxdecimaldigits" integer, "nprefix" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_askml"("geog" "public"."geography", "maxdecimaldigits" integer, "nprefix" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_askml"("geom" "public"."geometry", "maxdecimaldigits" integer, "nprefix" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_askml"("geom" "public"."geometry", "maxdecimaldigits" integer, "nprefix" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_askml"("geom" "public"."geometry", "maxdecimaldigits" integer, "nprefix" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_askml"("geom" "public"."geometry", "maxdecimaldigits" integer, "nprefix" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_aslatlontext"("geom" "public"."geometry", "tmpl" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_aslatlontext"("geom" "public"."geometry", "tmpl" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_aslatlontext"("geom" "public"."geometry", "tmpl" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_aslatlontext"("geom" "public"."geometry", "tmpl" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asmarc21"("geom" "public"."geometry", "format" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asmarc21"("geom" "public"."geometry", "format" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asmarc21"("geom" "public"."geometry", "format" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asmarc21"("geom" "public"."geometry", "format" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asmvtgeom"("geom" "public"."geometry", "bounds" "public"."box2d", "extent" integer, "buffer" integer, "clip_geom" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asmvtgeom"("geom" "public"."geometry", "bounds" "public"."box2d", "extent" integer, "buffer" integer, "clip_geom" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asmvtgeom"("geom" "public"."geometry", "bounds" "public"."box2d", "extent" integer, "buffer" integer, "clip_geom" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asmvtgeom"("geom" "public"."geometry", "bounds" "public"."box2d", "extent" integer, "buffer" integer, "clip_geom" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_assvg"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_assvg"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_assvg"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_assvg"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_assvg"("geog" "public"."geography", "rel" integer, "maxdecimaldigits" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_assvg"("geog" "public"."geography", "rel" integer, "maxdecimaldigits" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_assvg"("geog" "public"."geography", "rel" integer, "maxdecimaldigits" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_assvg"("geog" "public"."geography", "rel" integer, "maxdecimaldigits" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_assvg"("geom" "public"."geometry", "rel" integer, "maxdecimaldigits" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_assvg"("geom" "public"."geometry", "rel" integer, "maxdecimaldigits" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_assvg"("geom" "public"."geometry", "rel" integer, "maxdecimaldigits" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_assvg"("geom" "public"."geometry", "rel" integer, "maxdecimaldigits" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_astext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_astext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_astext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_astext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geography", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_astext"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry", "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry", "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry", "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry", "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry"[], "ids" bigint[], "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry"[], "ids" bigint[], "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry"[], "ids" bigint[], "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_astwkb"("geom" "public"."geometry"[], "ids" bigint[], "prec" integer, "prec_z" integer, "prec_m" integer, "with_sizes" boolean, "with_boxes" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asx3d"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asx3d"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asx3d"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asx3d"("geom" "public"."geometry", "maxdecimaldigits" integer, "options" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_azimuth"("geog1" "public"."geography", "geog2" "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_azimuth"("geog1" "public"."geography", "geog2" "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_azimuth"("geog1" "public"."geography", "geog2" "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_azimuth"("geog1" "public"."geography", "geog2" "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_azimuth"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_azimuth"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_azimuth"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_azimuth"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_bdmpolyfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_bdmpolyfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_bdmpolyfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_bdmpolyfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_bdpolyfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_bdpolyfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_bdpolyfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_bdpolyfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_boundary"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_boundary"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_boundary"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_boundary"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_boundingdiagonal"("geom" "public"."geometry", "fits" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_boundingdiagonal"("geom" "public"."geometry", "fits" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_boundingdiagonal"("geom" "public"."geometry", "fits" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_boundingdiagonal"("geom" "public"."geometry", "fits" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_box2dfromgeohash"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_box2dfromgeohash"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_box2dfromgeohash"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_box2dfromgeohash"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("text", double precision, "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("public"."geography", double precision, "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "quadsegs" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "quadsegs" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "quadsegs" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "quadsegs" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "options" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "options" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "options" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buffer"("geom" "public"."geometry", "radius" double precision, "options" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_buildarea"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_buildarea"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_buildarea"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_buildarea"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_centroid"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_centroid"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_centroid"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_centroid"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geography", "use_spheroid" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geography", "use_spheroid" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geography", "use_spheroid" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_centroid"("public"."geography", "use_spheroid" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_chaikinsmoothing"("public"."geometry", integer, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_chaikinsmoothing"("public"."geometry", integer, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_chaikinsmoothing"("public"."geometry", integer, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_chaikinsmoothing"("public"."geometry", integer, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_cleangeometry"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_cleangeometry"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_cleangeometry"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_cleangeometry"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_clipbybox2d"("geom" "public"."geometry", "box" "public"."box2d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_clipbybox2d"("geom" "public"."geometry", "box" "public"."box2d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_clipbybox2d"("geom" "public"."geometry", "box" "public"."box2d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_clipbybox2d"("geom" "public"."geometry", "box" "public"."box2d") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_closestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_closestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_closestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_closestpoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_closestpointofapproach"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_closestpointofapproach"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_closestpointofapproach"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_closestpointofapproach"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_clusterdbscan"("public"."geometry", "eps" double precision, "minpoints" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_clusterdbscan"("public"."geometry", "eps" double precision, "minpoints" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_clusterdbscan"("public"."geometry", "eps" double precision, "minpoints" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_clusterdbscan"("public"."geometry", "eps" double precision, "minpoints" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_clusterkmeans"("geom" "public"."geometry", "k" integer, "max_radius" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_clusterkmeans"("geom" "public"."geometry", "k" integer, "max_radius" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_clusterkmeans"("geom" "public"."geometry", "k" integer, "max_radius" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_clusterkmeans"("geom" "public"."geometry", "k" integer, "max_radius" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry"[], double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry"[], double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry"[], double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry"[], double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_collect"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_collect"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_collect"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_collect"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_collectionextract"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_collectionhomogenize"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_collectionhomogenize"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_collectionhomogenize"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_collectionhomogenize"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box2d", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box2d", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box2d", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box2d", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_combinebbox"("public"."box3d", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_concavehull"("param_geom" "public"."geometry", "param_pctconvex" double precision, "param_allow_holes" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_concavehull"("param_geom" "public"."geometry", "param_pctconvex" double precision, "param_allow_holes" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_concavehull"("param_geom" "public"."geometry", "param_pctconvex" double precision, "param_allow_holes" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_concavehull"("param_geom" "public"."geometry", "param_pctconvex" double precision, "param_allow_holes" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_contains"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_containsproperly"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_convexhull"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_convexhull"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_convexhull"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_convexhull"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_coorddim"("geometry" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_coorddim"("geometry" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_coorddim"("geometry" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_coorddim"("geometry" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_coveredby"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_coveredby"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_coveredby"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_coveredby"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_coveredby"("geog1" "public"."geography", "geog2" "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_coveredby"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_covers"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_covers"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_covers"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_covers"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_covers"("geog1" "public"."geography", "geog2" "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_covers"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_cpawithin"("public"."geometry", "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_cpawithin"("public"."geometry", "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_cpawithin"("public"."geometry", "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_cpawithin"("public"."geometry", "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_crosses"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_curvetoline"("geom" "public"."geometry", "tol" double precision, "toltype" integer, "flags" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_curvetoline"("geom" "public"."geometry", "tol" double precision, "toltype" integer, "flags" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_curvetoline"("geom" "public"."geometry", "tol" double precision, "toltype" integer, "flags" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_curvetoline"("geom" "public"."geometry", "tol" double precision, "toltype" integer, "flags" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_delaunaytriangles"("g1" "public"."geometry", "tolerance" double precision, "flags" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_delaunaytriangles"("g1" "public"."geometry", "tolerance" double precision, "flags" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_delaunaytriangles"("g1" "public"."geometry", "tolerance" double precision, "flags" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_delaunaytriangles"("g1" "public"."geometry", "tolerance" double precision, "flags" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dfullywithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_difference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_difference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_difference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_difference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dimension"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dimension"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_dimension"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dimension"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_disjoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_disjoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_disjoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_disjoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distance"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distance"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_distance"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distance"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_distance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distance"("geog1" "public"."geography", "geog2" "public"."geography", "use_spheroid" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distance"("geog1" "public"."geography", "geog2" "public"."geography", "use_spheroid" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_distance"("geog1" "public"."geography", "geog2" "public"."geography", "use_spheroid" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distance"("geog1" "public"."geography", "geog2" "public"."geography", "use_spheroid" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distancecpa"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distancecpa"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_distancecpa"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distancecpa"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry", "radius" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry", "radius" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry", "radius" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distancesphere"("geom1" "public"."geometry", "geom2" "public"."geometry", "radius" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry", "public"."spheroid") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry", "public"."spheroid") TO "anon";
GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry", "public"."spheroid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_distancespheroid"("geom1" "public"."geometry", "geom2" "public"."geometry", "public"."spheroid") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dump"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dump"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_dump"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dump"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dumppoints"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dumppoints"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_dumppoints"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dumppoints"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dumprings"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dumprings"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_dumprings"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dumprings"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dumpsegments"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dumpsegments"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_dumpsegments"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dumpsegments"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dwithin"("text", "text", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dwithin"("text", "text", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_dwithin"("text", "text", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dwithin"("text", "text", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dwithin"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_dwithin"("geog1" "public"."geography", "geog2" "public"."geography", "tolerance" double precision, "use_spheroid" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_endpoint"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_endpoint"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_endpoint"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_endpoint"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_envelope"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_envelope"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_envelope"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_envelope"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_equals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text", boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text", boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text", boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_estimatedextent"("text", "text", "text", boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_expand"("public"."box2d", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."box2d", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."box2d", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."box2d", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_expand"("public"."box3d", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."box3d", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."box3d", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."box3d", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_expand"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_expand"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box2d", "dx" double precision, "dy" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box2d", "dx" double precision, "dy" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box2d", "dx" double precision, "dy" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box2d", "dx" double precision, "dy" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box3d", "dx" double precision, "dy" double precision, "dz" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box3d", "dx" double precision, "dy" double precision, "dz" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box3d", "dx" double precision, "dy" double precision, "dz" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_expand"("box" "public"."box3d", "dx" double precision, "dy" double precision, "dz" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_expand"("geom" "public"."geometry", "dx" double precision, "dy" double precision, "dz" double precision, "dm" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_expand"("geom" "public"."geometry", "dx" double precision, "dy" double precision, "dz" double precision, "dm" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_expand"("geom" "public"."geometry", "dx" double precision, "dy" double precision, "dz" double precision, "dm" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_expand"("geom" "public"."geometry", "dx" double precision, "dy" double precision, "dz" double precision, "dm" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_exteriorring"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_exteriorring"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_exteriorring"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_exteriorring"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_filterbym"("public"."geometry", double precision, double precision, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_filterbym"("public"."geometry", double precision, double precision, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_filterbym"("public"."geometry", double precision, double precision, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_filterbym"("public"."geometry", double precision, double precision, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_findextent"("text", "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_flipcoordinates"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_flipcoordinates"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_flipcoordinates"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_flipcoordinates"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_force2d"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_force2d"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_force2d"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_force2d"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_force3d"("geom" "public"."geometry", "zvalue" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_force3d"("geom" "public"."geometry", "zvalue" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_force3d"("geom" "public"."geometry", "zvalue" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_force3d"("geom" "public"."geometry", "zvalue" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_force3dm"("geom" "public"."geometry", "mvalue" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_force3dm"("geom" "public"."geometry", "mvalue" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_force3dm"("geom" "public"."geometry", "mvalue" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_force3dm"("geom" "public"."geometry", "mvalue" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_force3dz"("geom" "public"."geometry", "zvalue" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_force3dz"("geom" "public"."geometry", "zvalue" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_force3dz"("geom" "public"."geometry", "zvalue" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_force3dz"("geom" "public"."geometry", "zvalue" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_force4d"("geom" "public"."geometry", "zvalue" double precision, "mvalue" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_force4d"("geom" "public"."geometry", "zvalue" double precision, "mvalue" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_force4d"("geom" "public"."geometry", "zvalue" double precision, "mvalue" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_force4d"("geom" "public"."geometry", "zvalue" double precision, "mvalue" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_forcecollection"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_forcecollection"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_forcecollection"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_forcecollection"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_forcecurve"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_forcecurve"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_forcecurve"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_forcecurve"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_forcepolygonccw"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_forcepolygonccw"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_forcepolygonccw"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_forcepolygonccw"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_forcepolygoncw"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_forcepolygoncw"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_forcepolygoncw"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_forcepolygoncw"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_forcerhr"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_forcerhr"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_forcerhr"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_forcerhr"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry", "version" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry", "version" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry", "version" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_forcesfs"("public"."geometry", "version" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_frechetdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_frechetdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_frechetdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_frechetdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_fromflatgeobuf"("anyelement", "bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_fromflatgeobuf"("anyelement", "bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_fromflatgeobuf"("anyelement", "bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_fromflatgeobuf"("anyelement", "bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_fromflatgeobuftotable"("text", "text", "bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_fromflatgeobuftotable"("text", "text", "bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_fromflatgeobuftotable"("text", "text", "bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_fromflatgeobuftotable"("text", "text", "bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer, "seed" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer, "seed" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer, "seed" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_generatepoints"("area" "public"."geometry", "npoints" integer, "seed" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geogfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geogfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geogfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geogfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geogfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geogfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geogfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geogfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geographyfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geographyfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geographyfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geographyfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geohash"("geog" "public"."geography", "maxchars" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geohash"("geog" "public"."geography", "maxchars" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geohash"("geog" "public"."geography", "maxchars" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geohash"("geog" "public"."geography", "maxchars" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geohash"("geom" "public"."geometry", "maxchars" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geohash"("geom" "public"."geometry", "maxchars" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geohash"("geom" "public"."geometry", "maxchars" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geohash"("geom" "public"."geometry", "maxchars" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomcollfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomcollfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geometricmedian"("g" "public"."geometry", "tolerance" double precision, "max_iter" integer, "fail_if_not_converged" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geometricmedian"("g" "public"."geometry", "tolerance" double precision, "max_iter" integer, "fail_if_not_converged" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geometricmedian"("g" "public"."geometry", "tolerance" double precision, "max_iter" integer, "fail_if_not_converged" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geometricmedian"("g" "public"."geometry", "tolerance" double precision, "max_iter" integer, "fail_if_not_converged" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geometryfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geometryn"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geometryn"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geometryn"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geometryn"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geometrytype"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geometrytype"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geometrytype"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geometrytype"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromewkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromewkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromewkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromewkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromewkt"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromewkt"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromewkt"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromewkt"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromgeohash"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromgeohash"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromgeohash"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromgeohash"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"(json) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"(json) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"(json) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"(json) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("jsonb") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromgeojson"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromgml"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromkml"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromkml"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromkml"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromkml"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfrommarc21"("marc21xml" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfrommarc21"("marc21xml" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfrommarc21"("marc21xml" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfrommarc21"("marc21xml" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromtwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromtwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromtwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromtwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_geomfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_gmltosql"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_gmltosql"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_gmltosql"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_gmltosql"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_gmltosql"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_gmltosql"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_gmltosql"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_gmltosql"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_hasarc"("geometry" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_hasarc"("geometry" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_hasarc"("geometry" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_hasarc"("geometry" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_hausdorffdistance"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_hexagon"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_hexagon"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_hexagon"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_hexagon"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_hexagongrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_hexagongrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_hexagongrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_hexagongrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_interiorringn"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_interiorringn"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_interiorringn"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_interiorringn"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_interpolatepoint"("line" "public"."geometry", "point" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_interpolatepoint"("line" "public"."geometry", "point" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_interpolatepoint"("line" "public"."geometry", "point" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_interpolatepoint"("line" "public"."geometry", "point" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_intersection"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_intersection"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_intersection"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_intersection"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_intersection"("public"."geography", "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_intersection"("public"."geography", "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_intersection"("public"."geography", "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_intersection"("public"."geography", "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_intersection"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_intersection"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_intersection"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_intersection"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_intersects"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_intersects"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_intersects"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_intersects"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_intersects"("geog1" "public"."geography", "geog2" "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_intersects"("geog1" "public"."geography", "geog2" "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_intersects"("geog1" "public"."geography", "geog2" "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_intersects"("geog1" "public"."geography", "geog2" "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_intersects"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isclosed"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isclosed"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_isclosed"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isclosed"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_iscollection"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_iscollection"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_iscollection"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_iscollection"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isempty"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isempty"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_isempty"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isempty"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_ispolygonccw"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_ispolygonccw"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_ispolygonccw"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_ispolygonccw"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_ispolygoncw"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_ispolygoncw"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_ispolygoncw"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_ispolygoncw"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isring"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isring"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_isring"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isring"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_issimple"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_issimple"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_issimple"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_issimple"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isvalid"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isvaliddetail"("geom" "public"."geometry", "flags" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isvaliddetail"("geom" "public"."geometry", "flags" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_isvaliddetail"("geom" "public"."geometry", "flags" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isvaliddetail"("geom" "public"."geometry", "flags" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isvalidreason"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_isvalidtrajectory"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_isvalidtrajectory"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_isvalidtrajectory"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_isvalidtrajectory"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_length"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_length"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_length"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_length"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_length"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_length"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_length"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_length"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_length"("geog" "public"."geography", "use_spheroid" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_length"("geog" "public"."geography", "use_spheroid" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_length"("geog" "public"."geography", "use_spheroid" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_length"("geog" "public"."geography", "use_spheroid" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_length2d"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_length2d"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_length2d"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_length2d"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_length2dspheroid"("public"."geometry", "public"."spheroid") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_length2dspheroid"("public"."geometry", "public"."spheroid") TO "anon";
GRANT ALL ON FUNCTION "public"."st_length2dspheroid"("public"."geometry", "public"."spheroid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_length2dspheroid"("public"."geometry", "public"."spheroid") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_lengthspheroid"("public"."geometry", "public"."spheroid") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_lengthspheroid"("public"."geometry", "public"."spheroid") TO "anon";
GRANT ALL ON FUNCTION "public"."st_lengthspheroid"("public"."geometry", "public"."spheroid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_lengthspheroid"("public"."geometry", "public"."spheroid") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_letters"("letters" "text", "font" json) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_letters"("letters" "text", "font" json) TO "anon";
GRANT ALL ON FUNCTION "public"."st_letters"("letters" "text", "font" json) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_letters"("letters" "text", "font" json) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linecrossingdirection"("line1" "public"."geometry", "line2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linefromencodedpolyline"("txtin" "text", "nprecision" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linefromencodedpolyline"("txtin" "text", "nprecision" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_linefromencodedpolyline"("txtin" "text", "nprecision" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linefromencodedpolyline"("txtin" "text", "nprecision" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linefrommultipoint"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linefrommultipoint"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linefrommultipoint"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linefrommultipoint"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linefromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linefromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linefromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linefromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linefromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linefromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_linefromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linefromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linefromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoint"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoint"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoint"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoint"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoints"("public"."geometry", double precision, "repeat" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoints"("public"."geometry", double precision, "repeat" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoints"("public"."geometry", double precision, "repeat" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_lineinterpolatepoints"("public"."geometry", double precision, "repeat" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linelocatepoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linelocatepoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linelocatepoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linelocatepoint"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry", boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry", boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry", boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linemerge"("public"."geometry", boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linestringfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linesubstring"("public"."geometry", double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linesubstring"("public"."geometry", double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_linesubstring"("public"."geometry", double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linesubstring"("public"."geometry", double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_linetocurve"("geometry" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_linetocurve"("geometry" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_linetocurve"("geometry" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_linetocurve"("geometry" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_locatealong"("geometry" "public"."geometry", "measure" double precision, "leftrightoffset" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_locatealong"("geometry" "public"."geometry", "measure" double precision, "leftrightoffset" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_locatealong"("geometry" "public"."geometry", "measure" double precision, "leftrightoffset" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_locatealong"("geometry" "public"."geometry", "measure" double precision, "leftrightoffset" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_locatebetween"("geometry" "public"."geometry", "frommeasure" double precision, "tomeasure" double precision, "leftrightoffset" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_locatebetween"("geometry" "public"."geometry", "frommeasure" double precision, "tomeasure" double precision, "leftrightoffset" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_locatebetween"("geometry" "public"."geometry", "frommeasure" double precision, "tomeasure" double precision, "leftrightoffset" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_locatebetween"("geometry" "public"."geometry", "frommeasure" double precision, "tomeasure" double precision, "leftrightoffset" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_locatebetweenelevations"("geometry" "public"."geometry", "fromelevation" double precision, "toelevation" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_locatebetweenelevations"("geometry" "public"."geometry", "fromelevation" double precision, "toelevation" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_locatebetweenelevations"("geometry" "public"."geometry", "fromelevation" double precision, "toelevation" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_locatebetweenelevations"("geometry" "public"."geometry", "fromelevation" double precision, "toelevation" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_longestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_m"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_m"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_m"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_m"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makebox2d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makebox2d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_makebox2d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makebox2d"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makeenvelope"(double precision, double precision, double precision, double precision, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makeenvelope"(double precision, double precision, double precision, double precision, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_makeenvelope"(double precision, double precision, double precision, double precision, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makeenvelope"(double precision, double precision, double precision, double precision, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makeline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makeline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_makeline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makeline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makepoint"(double precision, double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makepointm"(double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makepointm"(double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_makepointm"(double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makepointm"(double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry", "public"."geometry"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry", "public"."geometry"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry", "public"."geometry"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makepolygon"("public"."geometry", "public"."geometry"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makevalid"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makevalid"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_makevalid"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makevalid"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makevalid"("geom" "public"."geometry", "params" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makevalid"("geom" "public"."geometry", "params" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_makevalid"("geom" "public"."geometry", "params" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makevalid"("geom" "public"."geometry", "params" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_maxdistance"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_maximuminscribedcircle"("public"."geometry", OUT "center" "public"."geometry", OUT "nearest" "public"."geometry", OUT "radius" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_maximuminscribedcircle"("public"."geometry", OUT "center" "public"."geometry", OUT "nearest" "public"."geometry", OUT "radius" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_maximuminscribedcircle"("public"."geometry", OUT "center" "public"."geometry", OUT "nearest" "public"."geometry", OUT "radius" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_maximuminscribedcircle"("public"."geometry", OUT "center" "public"."geometry", OUT "nearest" "public"."geometry", OUT "radius" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_memsize"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_memsize"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_memsize"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_memsize"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_minimumboundingcircle"("inputgeom" "public"."geometry", "segs_per_quarter" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_minimumboundingcircle"("inputgeom" "public"."geometry", "segs_per_quarter" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_minimumboundingcircle"("inputgeom" "public"."geometry", "segs_per_quarter" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_minimumboundingcircle"("inputgeom" "public"."geometry", "segs_per_quarter" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_minimumboundingradius"("public"."geometry", OUT "center" "public"."geometry", OUT "radius" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_minimumboundingradius"("public"."geometry", OUT "center" "public"."geometry", OUT "radius" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_minimumboundingradius"("public"."geometry", OUT "center" "public"."geometry", OUT "radius" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_minimumboundingradius"("public"."geometry", OUT "center" "public"."geometry", OUT "radius" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_minimumclearance"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_minimumclearance"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_minimumclearance"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_minimumclearance"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_minimumclearanceline"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_minimumclearanceline"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_minimumclearanceline"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_minimumclearanceline"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mlinefromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mlinefromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpointfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpointfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpolyfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_mpolyfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multi"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multi"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_multi"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multi"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multilinefromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multilinefromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_multilinefromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multilinefromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multilinestringfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multipointfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multipointfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_multipointfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multipointfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multipointfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multipolyfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_multipolygonfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_ndims"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_ndims"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_ndims"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_ndims"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_node"("g" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_node"("g" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_node"("g" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_node"("g" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_normalize"("geom" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_normalize"("geom" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_normalize"("geom" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_normalize"("geom" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_npoints"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_npoints"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_npoints"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_npoints"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_nrings"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_nrings"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_nrings"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_nrings"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_numgeometries"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_numgeometries"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_numgeometries"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_numgeometries"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_numinteriorring"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_numinteriorring"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_numinteriorring"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_numinteriorring"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_numinteriorrings"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_numinteriorrings"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_numinteriorrings"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_numinteriorrings"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_numpatches"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_numpatches"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_numpatches"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_numpatches"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_numpoints"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_numpoints"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_numpoints"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_numpoints"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_offsetcurve"("line" "public"."geometry", "distance" double precision, "params" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_offsetcurve"("line" "public"."geometry", "distance" double precision, "params" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_offsetcurve"("line" "public"."geometry", "distance" double precision, "params" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_offsetcurve"("line" "public"."geometry", "distance" double precision, "params" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_orderingequals"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_orientedenvelope"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_orientedenvelope"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_orientedenvelope"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_orientedenvelope"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_overlaps"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_patchn"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_patchn"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_patchn"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_patchn"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_perimeter"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_perimeter"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_perimeter"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_perimeter"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_perimeter"("geog" "public"."geography", "use_spheroid" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_perimeter"("geog" "public"."geography", "use_spheroid" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_perimeter"("geog" "public"."geography", "use_spheroid" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_perimeter"("geog" "public"."geography", "use_spheroid" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_perimeter2d"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_perimeter2d"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_perimeter2d"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_perimeter2d"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision, "srid" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision, "srid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision, "srid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_point"(double precision, double precision, "srid" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointfromgeohash"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointfromgeohash"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointfromgeohash"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointfromgeohash"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointinsidecircle"("public"."geometry", double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointinsidecircle"("public"."geometry", double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointinsidecircle"("public"."geometry", double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointinsidecircle"("public"."geometry", double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointm"("xcoordinate" double precision, "ycoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointm"("xcoordinate" double precision, "ycoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointm"("xcoordinate" double precision, "ycoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointm"("xcoordinate" double precision, "ycoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointn"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointn"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointn"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointn"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointonsurface"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointonsurface"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointonsurface"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointonsurface"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_points"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_points"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_points"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_points"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointz"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "srid" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointz"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "srid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointz"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "srid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointz"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "srid" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_pointzm"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_pointzm"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_pointzm"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_pointzm"("xcoordinate" double precision, "ycoordinate" double precision, "zcoordinate" double precision, "mcoordinate" double precision, "srid" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polyfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polyfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polygon"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polygon"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_polygon"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polygon"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polygonfromtext"("text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polygonfromwkb"("bytea", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_project"("geog" "public"."geography", "distance" double precision, "azimuth" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_project"("geog" "public"."geography", "distance" double precision, "azimuth" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_project"("geog" "public"."geography", "distance" double precision, "azimuth" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_project"("geog" "public"."geography", "distance" double precision, "azimuth" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_quantizecoordinates"("g" "public"."geometry", "prec_x" integer, "prec_y" integer, "prec_z" integer, "prec_m" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_quantizecoordinates"("g" "public"."geometry", "prec_x" integer, "prec_y" integer, "prec_z" integer, "prec_m" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_quantizecoordinates"("g" "public"."geometry", "prec_x" integer, "prec_y" integer, "prec_z" integer, "prec_m" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_quantizecoordinates"("g" "public"."geometry", "prec_x" integer, "prec_y" integer, "prec_z" integer, "prec_m" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_reduceprecision"("geom" "public"."geometry", "gridsize" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_reduceprecision"("geom" "public"."geometry", "gridsize" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_reduceprecision"("geom" "public"."geometry", "gridsize" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_reduceprecision"("geom" "public"."geometry", "gridsize" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_relate"("geom1" "public"."geometry", "geom2" "public"."geometry", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_relatematch"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_relatematch"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_relatematch"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_relatematch"("text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_removepoint"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_removepoint"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_removepoint"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_removepoint"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_removerepeatedpoints"("geom" "public"."geometry", "tolerance" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_removerepeatedpoints"("geom" "public"."geometry", "tolerance" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_removerepeatedpoints"("geom" "public"."geometry", "tolerance" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_removerepeatedpoints"("geom" "public"."geometry", "tolerance" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_reverse"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_reverse"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_reverse"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_reverse"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_rotate"("public"."geometry", double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_rotatex"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_rotatex"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_rotatex"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_rotatex"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_rotatey"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_rotatey"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_rotatey"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_rotatey"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_rotatez"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_rotatez"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_rotatez"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_rotatez"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry", "origin" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry", "origin" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry", "origin" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", "public"."geometry", "origin" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_scale"("public"."geometry", double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_scroll"("public"."geometry", "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_scroll"("public"."geometry", "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_scroll"("public"."geometry", "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_scroll"("public"."geometry", "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_segmentize"("geog" "public"."geography", "max_segment_length" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_segmentize"("geog" "public"."geography", "max_segment_length" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_segmentize"("geog" "public"."geography", "max_segment_length" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_segmentize"("geog" "public"."geography", "max_segment_length" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_segmentize"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_segmentize"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_segmentize"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_segmentize"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_seteffectivearea"("public"."geometry", double precision, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_seteffectivearea"("public"."geometry", double precision, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_seteffectivearea"("public"."geometry", double precision, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_seteffectivearea"("public"."geometry", double precision, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_setpoint"("public"."geometry", integer, "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_setpoint"("public"."geometry", integer, "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_setpoint"("public"."geometry", integer, "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_setpoint"("public"."geometry", integer, "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_setsrid"("geog" "public"."geography", "srid" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_setsrid"("geog" "public"."geography", "srid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_setsrid"("geog" "public"."geography", "srid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_setsrid"("geog" "public"."geography", "srid" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_setsrid"("geom" "public"."geometry", "srid" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_setsrid"("geom" "public"."geometry", "srid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_setsrid"("geom" "public"."geometry", "srid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_setsrid"("geom" "public"."geometry", "srid" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_sharedpaths"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_sharedpaths"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_sharedpaths"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_sharedpaths"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_shiftlongitude"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_shiftlongitude"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_shiftlongitude"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_shiftlongitude"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_shortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_shortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_shortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_shortestline"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision, boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision, boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision, boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_simplify"("public"."geometry", double precision, boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_simplifypolygonhull"("geom" "public"."geometry", "vertex_fraction" double precision, "is_outer" boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_simplifypolygonhull"("geom" "public"."geometry", "vertex_fraction" double precision, "is_outer" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_simplifypolygonhull"("geom" "public"."geometry", "vertex_fraction" double precision, "is_outer" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_simplifypolygonhull"("geom" "public"."geometry", "vertex_fraction" double precision, "is_outer" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_simplifypreservetopology"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_simplifypreservetopology"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_simplifypreservetopology"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_simplifypreservetopology"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_simplifyvw"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_simplifyvw"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_simplifyvw"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_simplifyvw"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_snap"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_snap"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_snap"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_snap"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("public"."geometry", double precision, double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_snaptogrid"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision, double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision, double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision, double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_snaptogrid"("geom1" "public"."geometry", "geom2" "public"."geometry", double precision, double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_split"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_split"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_split"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_split"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_square"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_square"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_square"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_square"("size" double precision, "cell_i" integer, "cell_j" integer, "origin" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_squaregrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_squaregrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_squaregrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_squaregrid"("size" double precision, "bounds" "public"."geometry", OUT "geom" "public"."geometry", OUT "i" integer, OUT "j" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_srid"("geog" "public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_srid"("geog" "public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_srid"("geog" "public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_srid"("geog" "public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_srid"("geom" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_srid"("geom" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_srid"("geom" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_srid"("geom" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_startpoint"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_startpoint"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_startpoint"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_startpoint"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_subdivide"("geom" "public"."geometry", "maxvertices" integer, "gridsize" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_subdivide"("geom" "public"."geometry", "maxvertices" integer, "gridsize" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_subdivide"("geom" "public"."geometry", "maxvertices" integer, "gridsize" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_subdivide"("geom" "public"."geometry", "maxvertices" integer, "gridsize" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_summary"("public"."geography") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_summary"("public"."geography") TO "anon";
GRANT ALL ON FUNCTION "public"."st_summary"("public"."geography") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_summary"("public"."geography") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_summary"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_summary"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_summary"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_summary"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_swapordinates"("geom" "public"."geometry", "ords" "cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_swapordinates"("geom" "public"."geometry", "ords" "cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."st_swapordinates"("geom" "public"."geometry", "ords" "cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_swapordinates"("geom" "public"."geometry", "ords" "cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_symdifference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_symdifference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_symdifference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_symdifference"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_symmetricdifference"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_symmetricdifference"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_symmetricdifference"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_symmetricdifference"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_tileenvelope"("zoom" integer, "x" integer, "y" integer, "bounds" "public"."geometry", "margin" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_tileenvelope"("zoom" integer, "x" integer, "y" integer, "bounds" "public"."geometry", "margin" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_tileenvelope"("zoom" integer, "x" integer, "y" integer, "bounds" "public"."geometry", "margin" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_tileenvelope"("zoom" integer, "x" integer, "y" integer, "bounds" "public"."geometry", "margin" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_touches"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_transform"("public"."geometry", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_transform"("public"."geometry", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_transform"("public"."geometry", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_transform"("public"."geometry", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "to_proj" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "to_proj" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "to_proj" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "to_proj" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_srid" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_srid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_srid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_srid" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_proj" "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_proj" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_proj" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_transform"("geom" "public"."geometry", "from_proj" "text", "to_proj" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_translate"("public"."geometry", double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_transscale"("public"."geometry", double precision, double precision, double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_transscale"("public"."geometry", double precision, double precision, double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_transscale"("public"."geometry", double precision, double precision, double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_transscale"("public"."geometry", double precision, double precision, double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_triangulatepolygon"("g1" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_triangulatepolygon"("g1" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_triangulatepolygon"("g1" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_triangulatepolygon"("g1" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_unaryunion"("public"."geometry", "gridsize" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_unaryunion"("public"."geometry", "gridsize" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_unaryunion"("public"."geometry", "gridsize" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_unaryunion"("public"."geometry", "gridsize" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry"[]) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_union"("geom1" "public"."geometry", "geom2" "public"."geometry", "gridsize" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_voronoilines"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_voronoilines"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_voronoilines"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_voronoilines"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_voronoipolygons"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_voronoipolygons"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_voronoipolygons"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_voronoipolygons"("g1" "public"."geometry", "tolerance" double precision, "extend_to" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_within"("geom1" "public"."geometry", "geom2" "public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_wkbtosql"("wkb" "bytea") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_wkbtosql"("wkb" "bytea") TO "anon";
GRANT ALL ON FUNCTION "public"."st_wkbtosql"("wkb" "bytea") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_wkbtosql"("wkb" "bytea") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_wkttosql"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_wkttosql"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_wkttosql"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_wkttosql"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_wrapx"("geom" "public"."geometry", "wrap" double precision, "move" double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_wrapx"("geom" "public"."geometry", "wrap" double precision, "move" double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_wrapx"("geom" "public"."geometry", "wrap" double precision, "move" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_wrapx"("geom" "public"."geometry", "wrap" double precision, "move" double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_x"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_x"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_x"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_x"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_xmax"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_xmax"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_xmax"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_xmax"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_xmin"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_xmin"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_xmin"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_xmin"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_y"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_y"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_y"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_y"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_ymax"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_ymax"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_ymax"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_ymax"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_ymin"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_ymin"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_ymin"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_ymin"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_z"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_z"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_z"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_z"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_zmax"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_zmax"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_zmax"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_zmax"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_zmflag"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_zmflag"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_zmflag"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_zmflag"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_zmin"("public"."box3d") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_zmin"("public"."box3d") TO "anon";
GRANT ALL ON FUNCTION "public"."st_zmin"("public"."box3d") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_zmin"("public"."box3d") TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_community_conversation_member"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_community_conversation_member"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_community_conversation_member"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_group_conversation_member"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_group_conversation_member"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_group_conversation_member"() TO "service_role";



GRANT ALL ON FUNCTION "public"."unlockrows"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."unlockrows"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."unlockrows"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."unlockrows"("text") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_community_member_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_community_member_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_community_member_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_group_member_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_group_member_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_group_member_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_location_from_coords"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_location_from_coords"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_location_from_coords"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_user_location"("p_user_id" "uuid", "p_latitude" numeric, "p_longitude" numeric, "p_distance_meters" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."update_user_location"("p_user_id" "uuid", "p_latitude" numeric, "p_longitude" numeric, "p_distance_meters" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_user_location"("p_user_id" "uuid", "p_latitude" numeric, "p_longitude" numeric, "p_distance_meters" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, character varying, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, character varying, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, character varying, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"(character varying, character varying, character varying, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."updategeometrysrid"("catalogn_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"("catalogn_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"("catalogn_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."updategeometrysrid"("catalogn_name" character varying, "schema_name" character varying, "table_name" character varying, "column_name" character varying, "new_srid_in" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_event_description_word_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_event_description_word_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_event_description_word_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_event_rating"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_event_rating"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_event_rating"() TO "service_role";



GRANT ALL ON FUNCTION "public"."were_in_same_community_event"("p_user1" "uuid", "p_user2" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."were_in_same_community_event"("p_user1" "uuid", "p_user2" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."were_in_same_community_event"("p_user1" "uuid", "p_user2" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."were_in_same_finished_event"("p_user1" "uuid", "p_user2" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."were_in_same_finished_event"("p_user1" "uuid", "p_user2" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."were_in_same_finished_event"("p_user1" "uuid", "p_user2" "uuid") TO "service_role";












GRANT ALL ON FUNCTION "public"."st_3dextent"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_3dextent"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_3dextent"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_3dextent"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean, "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean, "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean, "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asflatgeobuf"("anyelement", boolean, "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asgeobuf"("anyelement", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_asmvt"("anyelement", "text", integer, "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_clusterintersecting"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_clusterwithin"("public"."geometry", double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_collect"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_extent"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_extent"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_extent"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_extent"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_makeline"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_memcollect"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_memcollect"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_memcollect"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_memcollect"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_memunion"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_memunion"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_memunion"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_memunion"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_polygonize"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry") TO "postgres";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry") TO "anon";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry") TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry", double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry", double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry", double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_union"("public"."geometry", double precision) TO "service_role";









GRANT ALL ON TABLE "public"."blocks" TO "anon";
GRANT ALL ON TABLE "public"."blocks" TO "authenticated";
GRANT ALL ON TABLE "public"."blocks" TO "service_role";



GRANT ALL ON TABLE "public"."communities" TO "anon";
GRANT ALL ON TABLE "public"."communities" TO "authenticated";
GRANT ALL ON TABLE "public"."communities" TO "service_role";



GRANT ALL ON TABLE "public"."community_announcements" TO "anon";
GRANT ALL ON TABLE "public"."community_announcements" TO "authenticated";
GRANT ALL ON TABLE "public"."community_announcements" TO "service_role";



GRANT ALL ON TABLE "public"."community_members" TO "anon";
GRANT ALL ON TABLE "public"."community_members" TO "authenticated";
GRANT ALL ON TABLE "public"."community_members" TO "service_role";



GRANT ALL ON TABLE "public"."conversation_members" TO "anon";
GRANT ALL ON TABLE "public"."conversation_members" TO "authenticated";
GRANT ALL ON TABLE "public"."conversation_members" TO "service_role";



GRANT ALL ON TABLE "public"."conversations" TO "anon";
GRANT ALL ON TABLE "public"."conversations" TO "authenticated";
GRANT ALL ON TABLE "public"."conversations" TO "service_role";



GRANT ALL ON TABLE "public"."event_applications" TO "anon";
GRANT ALL ON TABLE "public"."event_applications" TO "authenticated";
GRANT ALL ON TABLE "public"."event_applications" TO "service_role";



GRANT ALL ON TABLE "public"."event_invites" TO "anon";
GRANT ALL ON TABLE "public"."event_invites" TO "authenticated";
GRANT ALL ON TABLE "public"."event_invites" TO "service_role";



GRANT ALL ON TABLE "public"."event_ratings" TO "anon";
GRANT ALL ON TABLE "public"."event_ratings" TO "authenticated";
GRANT ALL ON TABLE "public"."event_ratings" TO "service_role";



GRANT ALL ON TABLE "public"."events" TO "anon";
GRANT ALL ON TABLE "public"."events" TO "authenticated";
GRANT ALL ON TABLE "public"."events" TO "service_role";



GRANT ALL ON TABLE "public"."frames" TO "anon";
GRANT ALL ON TABLE "public"."frames" TO "authenticated";
GRANT ALL ON TABLE "public"."frames" TO "service_role";



GRANT ALL ON TABLE "public"."group_invites" TO "anon";
GRANT ALL ON TABLE "public"."group_invites" TO "authenticated";
GRANT ALL ON TABLE "public"."group_invites" TO "service_role";



GRANT ALL ON TABLE "public"."group_members" TO "anon";
GRANT ALL ON TABLE "public"."group_members" TO "authenticated";
GRANT ALL ON TABLE "public"."group_members" TO "service_role";



GRANT ALL ON TABLE "public"."groups" TO "anon";
GRANT ALL ON TABLE "public"."groups" TO "authenticated";
GRANT ALL ON TABLE "public"."groups" TO "service_role";



GRANT ALL ON TABLE "public"."hobbies_master" TO "authenticated";
GRANT ALL ON TABLE "public"."hobbies_master" TO "service_role";
GRANT SELECT ON TABLE "public"."hobbies_master" TO "anon";



GRANT ALL ON SEQUENCE "public"."hobbies_master_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."hobbies_master_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."hobbies_master_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."languages_master" TO "anon";
GRANT ALL ON TABLE "public"."languages_master" TO "authenticated";
GRANT ALL ON TABLE "public"."languages_master" TO "service_role";



GRANT ALL ON SEQUENCE "public"."languages_master_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."languages_master_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."languages_master_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."lifestyle" TO "anon";
GRANT ALL ON TABLE "public"."lifestyle" TO "authenticated";
GRANT ALL ON TABLE "public"."lifestyle" TO "service_role";



GRANT ALL ON TABLE "public"."match_requests" TO "anon";
GRANT ALL ON TABLE "public"."match_requests" TO "authenticated";
GRANT ALL ON TABLE "public"."match_requests" TO "service_role";



GRANT ALL ON TABLE "public"."message_reads" TO "anon";
GRANT ALL ON TABLE "public"."message_reads" TO "authenticated";
GRANT ALL ON TABLE "public"."message_reads" TO "service_role";



GRANT ALL ON TABLE "public"."messages" TO "anon";
GRANT ALL ON TABLE "public"."messages" TO "authenticated";
GRANT ALL ON TABLE "public"."messages" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."user_hobbies" TO "anon";
GRANT ALL ON TABLE "public"."user_hobbies" TO "authenticated";
GRANT ALL ON TABLE "public"."user_hobbies" TO "service_role";



GRANT ALL ON TABLE "public"."user_languages" TO "anon";
GRANT ALL ON TABLE "public"."user_languages" TO "authenticated";
GRANT ALL ON TABLE "public"."user_languages" TO "service_role";



GRANT ALL ON TABLE "public"."user_photos" TO "anon";
GRANT ALL ON TABLE "public"."user_photos" TO "authenticated";
GRANT ALL ON TABLE "public"."user_photos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."user_photos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."user_photos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."user_photos_id_seq" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































RESET ALL;
