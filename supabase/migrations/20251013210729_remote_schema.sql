drop policy "user_communities: self-manage" on "public"."user_communities";

drop policy "user_values: self-manage" on "public"."user_values";

alter table "public"."communities_master" drop constraint "communities_master_label_key";

alter table "public"."user_communities" drop constraint "user_communities_community_id_fkey";

alter table "public"."user_communities" drop constraint "user_communities_user_id_fkey";

alter table "public"."user_values" drop constraint "user_values_user_id_fkey";

alter table "public"."user_values" drop constraint "user_values_value_id_fkey";

alter table "public"."values_master" drop constraint "values_master_label_key";

alter table "public"."communities_master" drop constraint "communities_master_pkey";

alter table "public"."user_communities" drop constraint "user_communities_pkey";

alter table "public"."user_values" drop constraint "user_values_pkey";

alter table "public"."values_master" drop constraint "values_master_pkey";

drop index if exists "public"."communities_master_label_key";

drop index if exists "public"."communities_master_pkey";

drop index if exists "public"."user_communities_pkey";

drop index if exists "public"."user_values_pkey";

drop index if exists "public"."values_master_label_key";

drop index if exists "public"."values_master_pkey";

drop table "public"."communities_master";

drop table "public"."user_communities";

drop table "public"."user_values";

drop table "public"."values_master";

drop sequence if exists "public"."communities_master_id_seq";

drop sequence if exists "public"."values_master_id_seq";

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

create policy "Users can insert their own photos"
on "public"."user_photos"
as permissive
for insert
to public
with check ((auth.uid() = user_id));


create policy "Users can select their own photos"
on "public"."user_photos"
as permissive
for select
to public
using ((auth.uid() = user_id));




