alter table "public"."lifestyle" add column "communities" text[];

alter table "public"."lifestyle" add column "created_at" timestamp with time zone not null default timezone('utc'::text, now());

alter table "public"."lifestyle" add column "pets" text;

alter table "public"."lifestyle" add column "politics" text;

alter table "public"."lifestyle" add column "religion" text;

alter table "public"."lifestyle" add column "updated_at" timestamp with time zone not null default timezone('utc'::text, now());

alter table "public"."profiles" drop column "politics";

alter table "public"."profiles" drop column "religion";

alter table "public"."profiles" add column "prompt_answers" jsonb default '[]'::jsonb;

CREATE INDEX idx_profiles_prompt_answers ON public.profiles USING gin (prompt_answers);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_lifestyle_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
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

CREATE TRIGGER lifestyle_updated_at_trigger BEFORE UPDATE ON public.lifestyle FOR EACH ROW EXECUTE FUNCTION handle_lifestyle_updated_at();



