create type "public"."friend_value_enum" as enum ('loyalty', 'trustworthy', 'good_listener', 'sense_of_humor', 'supportive', 'non_judgmental', 'honest', 'reliable', 'fun_to_be_around', 'authentic', 'understanding', 'shared_interests', 'deep_conversations', 'adventurous', 'positive_energy', 'low_maintenance', 'makes_time_for_me', 'encouraging', 'respectful_of_boundaries', 'growth_minded');

drop trigger if exists "trg_enforce_hobby_count" on "public"."user_hobbies";

drop trigger if exists "trg_enforce_photo_count" on "public"."user_photos";

alter table "public"."user_modes" drop column "looking_for";

alter table "public"."user_modes" add column "looking_for_friend" friend_value_enum[];

drop type "public"."looking_enum__old_version_to_be_dropped";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.enforce_hobby_count_stmt()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
  uid uuid;
  affected_users uuid[];
BEGIN
  -- Gather affected users from both NEW/OLD if present
  IF TG_OP = 'DELETE' THEN
    affected_users := ARRAY(SELECT DISTINCT OLD.user_id FROM user_hobbies WHERE user_id = OLD.user_id);
  ELSIF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    affected_users := ARRAY[NEW.user_id];
  END IF;

  FOREACH uid IN ARRAY affected_users LOOP
    IF (SELECT COUNT(*) FROM public.user_hobbies WHERE user_id = uid) NOT BETWEEN 4 AND 10 THEN
      RAISE EXCEPTION 'User % must have between 4 and 10 hobbies', uid;
    END IF;
  END LOOP;

  RETURN NULL;
END;
$function$
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

CREATE TRIGGER trg_enforce_hobby_count AFTER INSERT OR DELETE OR UPDATE ON public.user_hobbies FOR EACH STATEMENT EXECUTE FUNCTION enforce_hobby_count_stmt();

CREATE TRIGGER trg_enforce_photo_count AFTER INSERT OR DELETE OR UPDATE ON public.user_photos FOR EACH STATEMENT EXECUTE FUNCTION enforce_photo_count_stmt();



