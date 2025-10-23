drop policy "lifestyle: self-manage" on "public"."lifestyle";

drop policy "profiles: self-manage" on "public"."profiles";

drop policy "user_hobbies: self-manage" on "public"."user_hobbies";

drop policy "Users can insert their own photos" on "public"."user_photos";

drop policy "Users can select their own photos" on "public"."user_photos";

drop policy "user_photos: self-manage" on "public"."user_photos";

drop function if exists "public"."enforce_photo_count"();

drop function if exists "public"."enforce_photo_count_stmt"();

alter table "public"."user_modes" enable row level security;

alter table "public"."user_photos" add column "created_at" timestamp with time zone default now();

alter table "public"."user_photos" add column "is_main" boolean default false;

set check_function_bodies = off;

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
end; $function$
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

CREATE OR REPLACE FUNCTION public.handle_lifestyle_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pg_catalog'
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
 SET search_path TO 'public', 'pg_catalog'
AS $function$
BEGIN
  INSERT INTO public.user_info ("UID", created_at)
  VALUES (NEW.id, NOW());
  RETURN NEW;
END;
$function$
;

create policy "lifestyle: manage self"
on "public"."lifestyle"
as permissive
for all
to public
using ((current_user_id() = user_id))
with check ((current_user_id() = user_id));


create policy "Users can see and edit their own row"
on "public"."profiles"
as permissive
for all
to public
using ((current_user_id() = id))
with check ((current_user_id() = id));


create policy "user_hobbies: manage self"
on "public"."user_hobbies"
as permissive
for all
to public
using ((current_user_id() = user_id))
with check ((current_user_id() = user_id));


create policy "user_modes: manage self"
on "public"."user_modes"
as permissive
for all
to public
using ((current_user_id() = user_id))
with check ((current_user_id() = user_id));


create policy "user_modes: read others"
on "public"."user_modes"
as permissive
for select
to authenticated
using (true);


create policy "user_photos: manage self"
on "public"."user_photos"
as permissive
for all
to public
using ((current_user_id() = user_id))
with check ((current_user_id() = user_id));


CREATE TRIGGER trg_enforce_photo_max_4 BEFORE INSERT ON public.user_photos FOR EACH ROW EXECUTE FUNCTION enforce_photo_max_4();



  create policy "user_photos delete own folder"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'user_photos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "user_photos insert own folder"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'user_photos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "user_photos public read"
  on "storage"."objects"
  as permissive
  for select
  to public
using ((bucket_id = 'user_photos'::text));



  create policy "user_photos update own folder"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using (((bucket_id = 'user_photos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)))
with check (((bucket_id = 'user_photos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



