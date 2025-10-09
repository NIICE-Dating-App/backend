create type "public"."looking_friend_enum" as enum ('new_friends_nearby', 'workout_fitness_buddy', 'travel_companions', 'activity_hobby_partners', 'casual_hangouts', 'professional_networking', 'close_friendships');

create type "public"."value_date_enum" as enum ('honesty', 'kindness', 'sense_of_humor', 'good_communication', 'ambition', 'loyalty', 'emotional_intelligence', 'adventurous_spirit', 'intelligence', 'affectionate', 'family_oriented', 'open_mindedness', 'active_lifestyle', 'supportive', 'authenticity', 'similar_values', 'confidence', 'romantic', 'financial_stability', 'shared_interests');

drop trigger if exists "trg_enforce_hobby_count" on "public"."user_hobbies";

drop trigger if exists "trg_enforce_photo_count" on "public"."user_photos";

alter table "public"."lifestyle" add column "communication" text;

alter table "public"."lifestyle" add column "love_language" text;

alter table "public"."lifestyle" add column "workout" text;

alter table "public"."lifestyle" add column "zodiac" text;

alter table "public"."user_modes" drop column "brings_you";

alter table "public"."user_modes" drop column "interested_in";

alter table "public"."user_modes" add column "looking_for_date" looking_enum[];

alter table "public"."user_modes" add column "value_date" value_date_enum[];

alter table "public"."user_modes" add column "value_friend" friend_value_enum[];

alter table "public"."user_modes" alter column "looking_for_friend" set data type looking_friend_enum[] using "looking_for_friend"::looking_friend_enum[];

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.check_user_exists(user_email text)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
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

CREATE OR REPLACE FUNCTION public.enforce_hobby_count()
 RETURNS trigger
 LANGUAGE plpgsql
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

CREATE OR REPLACE FUNCTION public.enforce_photo_count()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare cnt int;
begin
  select count(*) into cnt from user_photos where user_id = new.user_id;
  if cnt < 2 or cnt > 5 then
    raise exception 'Each user must have between 2 and 5 photos';
  end if;
  return new;
end;$function$
;

CREATE OR REPLACE FUNCTION public.enforce_photo_count_stmt()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
  uid uuid;
  affected_users uuid[];
BEGIN
  IF TG_OP = 'DELETE' THEN
    affected_users := ARRAY(SELECT DISTINCT OLD.user_id FROM user_photos WHERE user_id = OLD.user_id);
  ELSIF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    affected_users := ARRAY[NEW.user_id];
  END IF;

  FOREACH uid IN ARRAY affected_users LOOP
    IF (SELECT COUNT(*) FROM public.user_photos WHERE user_id = uid) NOT BETWEEN 2 AND 5 THEN
      RAISE EXCEPTION 'Each user % must have between 2 and 5 photos', uid;
    END IF;
  END LOOP;

  RETURN NULL;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  INSERT INTO public.user_info ("UID", created_at)
  VALUES (NEW.id, NOW());
  RETURN NEW;
END;
$function$
;



