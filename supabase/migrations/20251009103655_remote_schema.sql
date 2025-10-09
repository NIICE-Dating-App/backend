



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






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."brings_enum" AS ENUM (
    'date',
    'friends',
    'date_and_friends'
);


ALTER TYPE "public"."brings_enum" OWNER TO "postgres";


CREATE TYPE "public"."gender_enum" AS ENUM (
    'man',
    'woman',
    'nonbinary'
);


ALTER TYPE "public"."gender_enum" OWNER TO "postgres";


CREATE TYPE "public"."looking_enum" AS ENUM (
    'long_term_relationship',
    'life_partner',
    'casual_dates',
    'intimacy',
    'marriage'
);


ALTER TYPE "public"."looking_enum" OWNER TO "postgres";


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


CREATE OR REPLACE FUNCTION "public"."check_user_exists"("user_email" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
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


CREATE OR REPLACE FUNCTION "public"."enforce_hobby_count"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare cnt int;
begin
  select count(*) into cnt from user_hobbies where user_id = new.user_id;
  if cnt < 4 or cnt > 10 then
    raise exception 'User must have between 4 and 10 hobbies';
  end if;
  return new;
end;$$;


ALTER FUNCTION "public"."enforce_hobby_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."enforce_photo_count"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare cnt int;
begin
  select count(*) into cnt from user_photos where user_id = new.user_id;
  if cnt < 2 or cnt > 5 then
    raise exception 'Each user must have between 2 and 5 photos';
  end if;
  return new;
end;$$;


ALTER FUNCTION "public"."enforce_photo_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.user_info ("UID", created_at)
  VALUES (NEW.id, NOW());
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."communities_master" (
    "id" integer NOT NULL,
    "label" "text"
);


ALTER TABLE "public"."communities_master" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."communities_master_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."communities_master_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."communities_master_id_seq" OWNED BY "public"."communities_master"."id";



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



CREATE TABLE IF NOT EXISTS "public"."lifestyle" (
    "user_id" "uuid" NOT NULL,
    "drinking" "text",
    "smoking" "text",
    "kids" "text"
);


ALTER TABLE "public"."lifestyle" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "full_name" "text",
    "age" integer,
    "gender" "text" NOT NULL,
    "sexual_orientation" "public"."orientation_enum" NOT NULL,
    "age_pref_min" integer,
    "age_pref_max" integer,
    "brings_you" "public"."brings_enum" NOT NULL,
    "interested_in" "public"."gender_enum"[] NOT NULL,
    "height_cm" integer,
    "education" "text",
    "religion" "text",
    "politics" "text",
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
    CONSTRAINT "interested_in_min" CHECK (("array_length"("interested_in", 1) >= 1)),
    CONSTRAINT "profiles_age_check" CHECK (("age" >= 18)),
    CONSTRAINT "profiles_distance_km_check" CHECK ((("distance_km" >= 1) AND ("distance_km" <= 4)))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_communities" (
    "user_id" "uuid" NOT NULL,
    "community_id" integer NOT NULL
);


ALTER TABLE "public"."user_communities" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_hobbies" (
    "user_id" "uuid" NOT NULL,
    "hobby_id" integer NOT NULL
);


ALTER TABLE "public"."user_hobbies" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_modes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "mode" "text",
    "looking_for" "public"."looking_enum"[],
    "brings_you" "public"."brings_enum"[],
    "interested_in" "public"."gender_enum"[],
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "user_modes_mode_check" CHECK (("mode" = ANY (ARRAY['dating'::"text", 'friend'::"text"])))
);


ALTER TABLE "public"."user_modes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_photos" (
    "id" integer NOT NULL,
    "user_id" "uuid",
    "photo_url" "text" NOT NULL
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



CREATE TABLE IF NOT EXISTS "public"."user_values" (
    "user_id" "uuid" NOT NULL,
    "value_id" integer NOT NULL
);


ALTER TABLE "public"."user_values" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."values_master" (
    "id" integer NOT NULL,
    "label" "text"
);


ALTER TABLE "public"."values_master" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."values_master_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."values_master_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."values_master_id_seq" OWNED BY "public"."values_master"."id";



ALTER TABLE ONLY "public"."communities_master" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."communities_master_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."hobbies_master" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."hobbies_master_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."user_photos" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."user_photos_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."values_master" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."values_master_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."communities_master"
    ADD CONSTRAINT "communities_master_label_key" UNIQUE ("label");



ALTER TABLE ONLY "public"."communities_master"
    ADD CONSTRAINT "communities_master_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."hobbies_master"
    ADD CONSTRAINT "hobbies_master_label_key" UNIQUE ("label");



ALTER TABLE ONLY "public"."hobbies_master"
    ADD CONSTRAINT "hobbies_master_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lifestyle"
    ADD CONSTRAINT "lifestyle_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_communities"
    ADD CONSTRAINT "user_communities_pkey" PRIMARY KEY ("user_id", "community_id");



ALTER TABLE ONLY "public"."user_hobbies"
    ADD CONSTRAINT "user_hobbies_pkey" PRIMARY KEY ("user_id", "hobby_id");



ALTER TABLE ONLY "public"."user_modes"
    ADD CONSTRAINT "user_modes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_modes"
    ADD CONSTRAINT "user_modes_user_mode_unique" UNIQUE ("user_id", "mode");



ALTER TABLE ONLY "public"."user_photos"
    ADD CONSTRAINT "user_photos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_values"
    ADD CONSTRAINT "user_values_pkey" PRIMARY KEY ("user_id", "value_id");



ALTER TABLE ONLY "public"."values_master"
    ADD CONSTRAINT "values_master_label_key" UNIQUE ("label");



ALTER TABLE ONLY "public"."values_master"
    ADD CONSTRAINT "values_master_pkey" PRIMARY KEY ("id");



CREATE OR REPLACE TRIGGER "trg_enforce_hobby_count" AFTER INSERT OR DELETE ON "public"."user_hobbies" FOR EACH ROW EXECUTE FUNCTION "public"."enforce_hobby_count"();



CREATE OR REPLACE TRIGGER "trg_enforce_photo_count" AFTER INSERT OR DELETE ON "public"."user_photos" FOR EACH ROW EXECUTE FUNCTION "public"."enforce_photo_count"();



ALTER TABLE ONLY "public"."lifestyle"
    ADD CONSTRAINT "lifestyle_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_communities"
    ADD CONSTRAINT "user_communities_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "public"."communities_master"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_communities"
    ADD CONSTRAINT "user_communities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_hobbies"
    ADD CONSTRAINT "user_hobbies_hobby_id_fkey" FOREIGN KEY ("hobby_id") REFERENCES "public"."hobbies_master"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_hobbies"
    ADD CONSTRAINT "user_hobbies_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_modes"
    ADD CONSTRAINT "user_modes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_photos"
    ADD CONSTRAINT "user_photos_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_values"
    ADD CONSTRAINT "user_values_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_values"
    ADD CONSTRAINT "user_values_value_id_fkey" FOREIGN KEY ("value_id") REFERENCES "public"."values_master"("id") ON DELETE CASCADE;



ALTER TABLE "public"."lifestyle" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "lifestyle: self-manage" ON "public"."lifestyle" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "profiles: self-manage" ON "public"."profiles" USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));



ALTER TABLE "public"."user_communities" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_communities: self-manage" ON "public"."user_communities" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."user_hobbies" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_hobbies: self-manage" ON "public"."user_hobbies" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."user_photos" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_photos: self-manage" ON "public"."user_photos" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."user_values" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_values: self-manage" ON "public"."user_values" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."check_user_exists"("user_email" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."check_user_exists"("user_email" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_user_exists"("user_email" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."enforce_hobby_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_hobby_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_hobby_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."enforce_photo_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_photo_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_photo_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";


















GRANT ALL ON TABLE "public"."communities_master" TO "anon";
GRANT ALL ON TABLE "public"."communities_master" TO "authenticated";
GRANT ALL ON TABLE "public"."communities_master" TO "service_role";



GRANT ALL ON SEQUENCE "public"."communities_master_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."communities_master_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."communities_master_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."hobbies_master" TO "anon";
GRANT ALL ON TABLE "public"."hobbies_master" TO "authenticated";
GRANT ALL ON TABLE "public"."hobbies_master" TO "service_role";



GRANT ALL ON SEQUENCE "public"."hobbies_master_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."hobbies_master_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."hobbies_master_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."lifestyle" TO "anon";
GRANT ALL ON TABLE "public"."lifestyle" TO "authenticated";
GRANT ALL ON TABLE "public"."lifestyle" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."user_communities" TO "anon";
GRANT ALL ON TABLE "public"."user_communities" TO "authenticated";
GRANT ALL ON TABLE "public"."user_communities" TO "service_role";



GRANT ALL ON TABLE "public"."user_hobbies" TO "anon";
GRANT ALL ON TABLE "public"."user_hobbies" TO "authenticated";
GRANT ALL ON TABLE "public"."user_hobbies" TO "service_role";



GRANT ALL ON TABLE "public"."user_modes" TO "anon";
GRANT ALL ON TABLE "public"."user_modes" TO "authenticated";
GRANT ALL ON TABLE "public"."user_modes" TO "service_role";



GRANT ALL ON TABLE "public"."user_photos" TO "anon";
GRANT ALL ON TABLE "public"."user_photos" TO "authenticated";
GRANT ALL ON TABLE "public"."user_photos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."user_photos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."user_photos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."user_photos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."user_values" TO "anon";
GRANT ALL ON TABLE "public"."user_values" TO "authenticated";
GRANT ALL ON TABLE "public"."user_values" TO "service_role";



GRANT ALL ON TABLE "public"."values_master" TO "anon";
GRANT ALL ON TABLE "public"."values_master" TO "authenticated";
GRANT ALL ON TABLE "public"."values_master" TO "service_role";



GRANT ALL ON SEQUENCE "public"."values_master_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."values_master_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."values_master_id_seq" TO "service_role";









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
