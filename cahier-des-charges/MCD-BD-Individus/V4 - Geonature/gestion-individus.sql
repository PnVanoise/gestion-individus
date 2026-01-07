CREATE SCHEMA "pr_occtax";

CREATE SCHEMA "gn_monitoring";

CREATE TABLE "pr_occtax"."cor_counting_occtax" (
  "id_counting_occtax" bigint NOT NULL,
  "unique_id_sinp_occtax" uuid NOT NULL,
  "id_occurrence_occtax" bigint NOT NULL,
  "id_individual" bigint,
  "id_nomenclature_life_stage" integer NOT NULL,
  "id_nomenclature_sex" integer NOT NULL,
  "id_nomenclature_obj_count" integer NOT NULL,
  "id_nomenclature_type_count" integer NOT NULL,
  "count_min" integer,
  "count_max" integer,
  "additional_fields" jsonb
);

CREATE TABLE "pr_occtax"."t_releves_occtax" (
  "id_releve_occtax" bigint NOT NULL,
  "unique_id_sinp_grp" uuid NOT NULL,
  "id_dataset" integer NOT NULL,
  "id_nomenclature_digitiser_type" integer NOT NULL,
  "id_digitiser" integer,
  "observers_txt" text
);

CREATE TABLE "pr_occtax"."cor_role_releves_occtax" (
  "unique_id_cor_role_releve" uuid NOT NULL,
  "id_releve_occtax" bigint NOT NULL,
  "id_role" integer NOT NULL
);

CREATE TABLE "pr_occtax"."cor_device_releves_occtax" (
  "unique_id_cor_device_releve" uuid NOT NULL,
  "id_releve_occtax" bigint NOT NULL,
  "id_device" integer NOT NULL
);

CREATE TABLE "gn_monitoring"."t_individual" (
  "id_individual" bigint PRIMARY KEY NOT NULL,
  "uuid_individual" uuid,
  "individual_name" text,
  "cd_nom" bigint NOT NULL,
  "id_nomenclature_sex" json NOT NULL,
  "active" bool,
  "comment" text,
  "id_digitizer" bigint,
  "meta_create_date" date,
  "meta_update_date" date
);

ALTER TABLE "pr_occtax"."cor_counting_occtax" ADD CONSTRAINT "fk_cor_counting_occtax_t_individual" FOREIGN KEY ("id_individual") REFERENCES "gn_monitoring"."t_individual" ("id_individual");

ALTER TABLE "pr_occtax"."cor_role_releves_occtax" ADD CONSTRAINT "fk_cor_role_releves_occtax_t_releves_occtax" FOREIGN KEY ("id_releve_occtax") REFERENCES "pr_occtax"."t_releves_occtax" ("id_releve_occtax");

ALTER TABLE "pr_occtax"."cor_device_releves_occtax" ADD CONSTRAINT "fk_cor_device_releves_occtax_t_releves_occtax" FOREIGN KEY ("id_releve_occtax") REFERENCES "pr_occtax"."t_releves_occtax" ("id_releve_occtax");
