CREATE TABLE "t_individual" (
  "id" bigint NOT NULL,
  "cdnom" bigint NOT NULL,
  "name" text,
  "ident_signs" json
);

CREATE TABLE "t_veterinary" (
  "id" SERIAL NOT NULL,
  "id_laboratory" bigint NOT NULL,
  "results" json NOT NULL,
  "type" integer
);

CREATE TABLE "t_observer" (
  "id" bigint NOT NULL,
  "type" bigint,
  "geom" bigint
);

CREATE TABLE "t_event" (
  "id" bigint NOT NULL,
  "id_individual" bigint,
  "date" timestamp NOT NULL,
  "geom" bigint NOT NULL,
  "type" integer,
  "files" text NOT NULL,
  "id_observer" bigint,
  "id_veterinary" SERIAL,
  "id_event_obs" SERIAL
);

CREATE TABLE "t_laboratory" (
  "id" bigint NOT NULL,
  "name" text NOT NULL,
  "address" text NOT NULL
);

CREATE TABLE "t_event_observations" (
  "id" SERIAL NOT NULL,
  "type" integer,
  "value" text,
  "detail" text
);

CREATE TABLE "t_observation_type" (
  "id" integer NOT NULL,
  "name" text,
  "description" text
);

COMMENT ON TABLE "t_individual" IS 'Dans cette table, nous avons la liste des individus identifiés';

COMMENT ON COLUMN "t_veterinary"."type" IS 'coprologie, autopsie, génétique, sérologie, gestation ...';

COMMENT ON COLUMN "t_event"."type" IS 'Observation visuelle distante Piege photo Capture GPS VHF';

COMMENT ON COLUMN "t_event_observations"."type" IS 'Pour préciser le type d''observation soit issue par anlayse d''image via l''IA, soit par analyse visuelle d''un agent : biométrie, état de santé, gestation ...';

ALTER TABLE "t_veterinary" ADD CONSTRAINT "fk_t_veterinary_t_laboratory" FOREIGN KEY ("id_laboratory") REFERENCES "t_laboratory" ("id");

ALTER TABLE "t_event_observations" ADD CONSTRAINT "fk_t_event_t_event_observations" FOREIGN KEY ("id") REFERENCES "t_event" ("id_event_obs");

ALTER TABLE "t_veterinary" ADD CONSTRAINT "fk_t_veterinary_t_event" FOREIGN KEY ("id") REFERENCES "t_event" ("id_veterinary");

ALTER TABLE "t_individual" ADD CONSTRAINT "fk_t_event_t_individual" FOREIGN KEY ("id") REFERENCES "t_event" ("id_individual");

CREATE TABLE "t_event_t_observer" (
  "t_event_id_observer" bigint,
  "t_observer_id" bigint,
  PRIMARY KEY ("t_event_id_observer", "t_observer_id")
);

ALTER TABLE "t_event_t_observer" ADD FOREIGN KEY ("t_event_id_observer") REFERENCES "t_event" ("id_observer");

ALTER TABLE "t_event_t_observer" ADD FOREIGN KEY ("t_observer_id") REFERENCES "t_observer" ("id");


ALTER TABLE "t_event_observations" ADD CONSTRAINT "fk_t_event_observations_t_observation_type" FOREIGN KEY ("type") REFERENCES "t_observation_type" ("id");
