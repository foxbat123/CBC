CREATE TABLE "weeds" (
  "id" int,
  "common_name" varchar,
  "scientific_name" varchar,
  PRIMARY KEY ("id")
);

CREATE TABLE "other_weeds_present" (
  "id" int,
  "site_surveys_id" int,
  "weeds_id" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_other_weeds_present.weeds_id"
    FOREIGN KEY ("weeds_id")
      REFERENCES "weeds"("id")
);

CREATE TABLE "agents" (
  "id" int,
  "common_name" varchar,
  "scientific_name" varchar ,
  PRIMARY KEY ("id")
);

CREATE TABLE "parrots_feather_surveys" (
  "id" int,
  "weed_surveys_id" int,
  "percent_damaged" int,
  "percent_cover" int,
  "lysathia_present" bool,
  PRIMARY KEY ("id")
);

CREATE TABLE "pf_quadrat_surveys" (
  "id" int,
  "parrots_feather_surveys_id" int,
  "stems_in_quadrat" int,
  "damaged_stems" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_pf_quadrat_surveys.parrots_feather_surveys_id"
    FOREIGN KEY ("parrots_feather_surveys_id")
      REFERENCES "parrots_feather_surveys"("id")
);

CREATE TABLE "water_lettuce_surveys" (
  "id" int,
  "weed_surveys_id" int,
  "percent_damaged" int,
  "percent_cover" int,
  "neo_present" bool,
  "notes" text,
  PRIMARY KEY ("id")
);

CREATE TABLE "wh_surveys" (
  "id" int,
  "weed_surveys_id" char,
  "site_cover" int,
  "time_buttons_replaced" timestamp,
  "mat_sample_size" int,
  PRIMARY KEY ("id")
);

CREATE TABLE "azolla_surveys" (
  "id" int,
  "weed_surveys_id" int,
  "percent_damaged" int,
  "percent_cover" int,
  "steno_present" bool,
  PRIMARY KEY ("id")
);

CREATE TABLE "salvinia_surveys" (
  "id" int,
  "weed_surveys_id" int,
  "percent_damaged" int,
  "percent_cover" int,
  "cyrto_present" bool,
  "notes" text,
  PRIMARY KEY ("id")
);

CREATE TABLE "surveyors" (
  "id" int,
  "name" varchar,
  "email" varChar,
  "title" varChar,
  PRIMARY KEY ("id")
);

CREATE TABLE "coverage_estimates" (
  "id" int,
  "site_surveys_id" int,
  "weeds_id" int,
  "percentage_cover" int,
  PRIMARY KEY ("id")
);

CREATE TABLE "sites" (
  "id" int,
  "coordinates" point,
  "name" text,
  "nickname" text,
  PRIMARY KEY ("id")
);

CREATE TABLE "site_surveys" (
  "id" int,
  "date" date,
  "notes" varchar,
  "surveyors_id" int,
  "sites_id" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_site_surveys.surveyors_id"
    FOREIGN KEY ("surveyors_id")
      REFERENCES "surveyors"("id"),
  CONSTRAINT "FK_site_surveys.id"
    FOREIGN KEY ("id")
      REFERENCES "coverage_estimates"("site_surveys_id"),
  CONSTRAINT "FK_site_surveys.sites_id"
    FOREIGN KEY ("sites_id")
      REFERENCES "sites"("id")
);

CREATE TABLE "weed_surveys" (
  "id" int,
  "site_surveys_id" Type,
  "weeds_id" date,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_weed_surveys.id"
    FOREIGN KEY ("id")
      REFERENCES "water_lettuce_surveys"("weed_surveys_id"),
  CONSTRAINT "FK_weed_surveys.id"
    FOREIGN KEY ("id")
      REFERENCES "wh_surveys"("weed_surveys_id"),
  CONSTRAINT "FK_weed_surveys.weeds_id"
    FOREIGN KEY ("weeds_id")
      REFERENCES "weeds"("id"),
  CONSTRAINT "FK_weed_surveys.id"
    FOREIGN KEY ("id")
      REFERENCES "azolla_surveys"("weed_surveys_id"),
  CONSTRAINT "FK_weed_surveys.id"
    FOREIGN KEY ("id")
      REFERENCES "parrots_feather_surveys"("weed_surveys_id"),
  CONSTRAINT "FK_weed_surveys.id"
    FOREIGN KEY ("id")
      REFERENCES "salvinia_surveys"("weed_surveys_id"),
  CONSTRAINT "FK_weed_surveys.site_surveys_id"
    FOREIGN KEY ("site_surveys_id")
      REFERENCES "site_surveys"("id")
);

CREATE TABLE "wh_agents_survey" (
  "id" int,
  "wh_surveys_id" int,
  "adult_mirids" bool,
  "approx_mirids" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_wh_agents_survey.wh_surveys_id"
    FOREIGN KEY ("wh_surveys_id")
      REFERENCES "wh_surveys"("id")
);

CREATE TABLE "moth_observations" (
  "id" int,
  "wh_agents_survey_id" int,
  "agent_id" int,
  "larvae" bool,
  "pupae" bool,
  "petioles_mined" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_moth_observations.wh_agents_survey_id"
    FOREIGN KEY ("wh_agents_survey_id")
      REFERENCES "wh_agents_survey"("id")
);

CREATE TABLE "weevils_observations" (
  "id" int,
  "wh_agents_survey_id" int,
  "agents_id" int,
  "feeding_scars" int,
  "larvae_instar_1" int,
  "larvae_instar_2" int,
  "larvae_instar_3" int,
  "petioles_mined" int,
  "pupae" bool,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_weevils_observations.wh_agents_survey_id"
    FOREIGN KEY ("wh_agents_survey_id")
      REFERENCES "wh_agents_survey"("id")
);

CREATE TABLE "rearing_entities" (
  "id" int,
  "entity_name" text,
  PRIMARY KEY ("id")
);

CREATE TABLE "mite_observations" (
  "id" int,
  "wh_agents_survey_id" int,
  "agents_id" int,
  "leaf_damage_scale_id" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_mite_observations.wh_agents_survey_id"
    FOREIGN KEY ("wh_agents_survey_id")
      REFERENCES "wh_agents_survey"("id")
);

CREATE TABLE "plants_phentostage" (
  "id" int,
  "code" char,
  "classification" varchar,
  "description" varchar,
  PRIMARY KEY ("id")
);

CREATE TABLE "implementers" (
  "id" int,
  "first_name" text,
  "last_name" text,
  "organisation" text,
  "office_phone" text,
  "email" text,
  "address" text,
  PRIMARY KEY ("id")
);

CREATE TABLE "agent_releases" (
  "id" int,
  "sites_id" int,
  "date_released" date,
  "number_released" int,
  "agents_id" int,
  "note" text,
  "rearing_entities_id" int,
  "implementers_id" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_agent_releases.rearing_entities_id"
    FOREIGN KEY ("rearing_entities_id")
      REFERENCES "rearing_entities"("id"),
  CONSTRAINT "FK_agent_releases.implementers_id"
    FOREIGN KEY ("implementers_id")
      REFERENCES "implementers"("id"),
  CONSTRAINT "FK_agent_releases.sites_id"
    FOREIGN KEY ("sites_id")
      REFERENCES "sites"("id"),
  CONSTRAINT "FK_agent_releases.agents_id"
    FOREIGN KEY ("agents_id")
      REFERENCES "agents"("id")
);

CREATE TABLE "mirid_observations" (
  "id" int,
  "wh_agents_survey_id" int,
  "agent_id" int,
  "leaf_damage_scale_id" int,
  "nymphs" bool,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_mirid_observations.wh_agents_survey_id"
    FOREIGN KEY ("wh_agents_survey_id")
      REFERENCES "wh_agents_survey"("id")
);

CREATE TABLE "wh_quadrat_observation" (
  "id" int,
  "wh_surveys_id" int,
  "individual_plants" int,
  "above_living_biomass" float,
  "below_living_biomass" float,
  "dead_biomass" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_wh_quadrat_observation.wh_surveys_id"
    FOREIGN KEY ("wh_surveys_id")
      REFERENCES "wh_surveys"("id")
);

CREATE TABLE "pathogen_observations" (
  "id" int,
  "wh_agents_survey_id" int,
  "agent_id" int,
  "present" bool,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_pathogen_observations.wh_agents_survey_id"
    FOREIGN KEY ("wh_agents_survey_id")
      REFERENCES "wh_agents_survey"("id")
);

CREATE TABLE "plant_observation" (
  "id" int,
  "wh_surveys_id" int,
  "plants_phentostage_id" <type>,
  "longest_petiole" int,
  "leaf2_petiole_length" int,
  "leaf2_area" int,
  "max_root_length" int,
  "num_ramets" int,
  "num_flowers" int,
  "num_leaves" int,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_plant_observation.wh_surveys_id"
    FOREIGN KEY ("wh_surveys_id")
      REFERENCES "wh_surveys"("id")
);

CREATE TABLE "leaf_damage_scale" (
  "id" int,
  "code" char,
  "description" varchar,
  PRIMARY KEY ("id")
);

CREATE TABLE "photos" (
  "id" int,
  "site_surveys_id" int,
  "photo_link" text,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_photos.site_surveys_id"
    FOREIGN KEY ("site_surveys_id")
      REFERENCES "site_surveys"("id")
);

CREATE TABLE "site_contacts" (
  "id" int,
  "sites_id" Type,
  "first_name" text,
  "last_name" text,
  "organisation" text,
  "office_phone" text,
  "email" text,
  "address" text,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_site_contacts.sites_id"
    FOREIGN KEY ("sites_id")
      REFERENCES "sites"("id")
);

