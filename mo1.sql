-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/VQlL4B
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


DROP TABLE IF EXISTS patent_claims_stats cascade;
DROP TABLE IF EXISTS all_inventors cascade;
DROP TABLE IF EXISTS uspc_class_all cascade;
DROP TABLE IF EXISTS application_cleaned_patented cascade;
DROP TABLE IF EXISTS application_cleaned_all cascade;
DROP TABLE IF EXISTS uspc_class_daysandrate cascade;
DROP TABLE IF EXISTS attorney_success_withnames cascade;
DROP TABLE IF EXISTS uspc_attorney_success_withnames cascade;

CREATE TABLE "patent_claims_stats" (
    "patent_number" varchar   NOT NULL,
    "claim_no" int   NOT NULL,
    "total_word_ct" int   NOT NULL,
    "total_char_ct" int   NOT NULL,
    "average_word_ct_eachclaim" int   NOT NULL,
    "average_char_ct_eachclaim" int   NOT NULL,
    CONSTRAINT "pk_patent_claims_stats" PRIMARY KEY (
        "patent_number"
     )
);

CREATE TABLE "all_inventors" (
    "application_number" varchar   NOT NULL,
    "inventor_name_first" varchar,
    "inventor_name_middle" varchar,
    "inventor_name_last" varchar,
    "inventor_rank" int,
    "inventor_city_name" varchar,
    "inventor_region_code" varchar,
    "inventor_country_code" varchar
--    CONSTRAINT "pk_all_inventors" PRIMARY KEY (
--        "application_number","inventor_name_first","inventor_name_middle","inventor_name_last", "inventor_rank", "inventor_city_name", "inventor_region_code", "inventor_country_code"
--     )
);

CREATE TABLE "uspc_class_all" (
    "uspc_class" varchar   UNIQUE,
    CONSTRAINT "pk_uspc_class_all" PRIMARY KEY (
        "uspc_class"
     )
);

CREATE TABLE "application_cleaned_patented" (
    "application_number" varchar   NOT NULL UNIQUE,
    "filing_date" varchar,
    "application_invention_type" varchar,
    "examiner_full_name" varchar,
    "examiner_art_unit" varchar,
    "uspc_class" varchar,
    "uspc_subclass" varchar,
    "atty_docket_number" varchar,
    "appl_status_desc" varchar,
    "appl_status_date" varchar,
	"file_location" varchar,
    "file_location_date" varchar,
    "earliest_pgpub_number" varchar,
    "earliest_pgpub_date" varchar,
    "patent_number" varchar,
    "patent_issue_date" varchar,
    "invention_title" varchar,
    "small_entity_indicator" varchar,
    "patent_issue_and_file_date_delta" int,
    CONSTRAINT "pk_application_cleaned_patented" PRIMARY KEY (
        "application_number"
     )
);

CREATE TABLE "application_cleaned_all" (
    "application_number" varchar   NOT NULL UNIQUE,
    "filing_date" varchar,
    "application_invention_type" varchar,
    "examiner_full_name" varchar,
    "examiner_art_unit" varchar,
    "uspc_class" varchar,
    "uspc_subclass" varchar,
    "atty_docket_number" varchar,
    "appl_status_desc" varchar,
    "appl_status_date" varchar,
    "file_location" varchar,
    "file_location_date" varchar,
    "earliest_pgpub_number" varchar,
    "earliest_pgpub_date" varchar,
    "patent_number" varchar,
    "patent_issue_date" varchar,
    "invention_title" varchar,
    "small_entity_indicator" varchar,
    CONSTRAINT "pk_application_cleaned_all" PRIMARY KEY (
        "application_number"
     )
);

CREATE TABLE "uspc_class_daysandrate" (
    "uspc_class" varchar   NOT NULL,
    "application_number_all" int   NOT NULL,
    "application_number_patented" int   NOT NULL,
    "patented_rate" float   NOT NULL,
    "patented_cases_per_class" int   NOT NULL,
    "average_years" float   NOT NULL,
    CONSTRAINT "pk_uspc_class_daysandrate" PRIMARY KEY (
        "uspc_class"
     )
);

CREATE TABLE "attorney_success_withnames" (
    "atty_registration_number" varchar   NOT NULL,
    "application_number_patented" int,
    "application_number_all" int,
    "success_rate" float,
    "atty_name_last" varchar,
    "atty_name_first" varchar,
    "atty_practice_category" varchar,
    CONSTRAINT "pk_attorney_success_withnames" PRIMARY KEY (
        "atty_registration_number"
     )
);

CREATE TABLE "uspc_attorney_success_withnames" (
    "uspc_class" varchar   NOT NULL,
    "atty_registration_number" varchar   NOT NULL,
    "application_number_patented" int,
    "application_number_all" int,
    "success_rate" float,
    "atty_name_last" varchar,
    "atty_name_first" varchar,
    "atty_practice_category" varchar,
    CONSTRAINT "pk_uspc_attorney_success_withnames" PRIMARY KEY (
        "uspc_class","atty_registration_number"
     )
);

--ALTER TABLE "application_cleaned_all" ADD CONSTRAINT "fk_application_cleaned_all_patent_number" FOREIGN KEY("patent_number")
--REFERENCES "patent_claims_stats" ("patent_number");


-- ALTER TABLE "patent_claims_stats" ADD CONSTRAINT "fk_patent_claims_stats_patent_number" FOREIGN KEY("patent_number")
-- REFERENCES "application_cleaned_all" ("patent_number");

ALTER TABLE "all_inventors" ADD CONSTRAINT "fk_all_inventors_application_number" FOREIGN KEY("application_number")
REFERENCES "application_cleaned_all" ("application_number");



-- ALTER TABLE "application_cleaned_patented" ADD CONSTRAINT "fk_application_cleaned_patented_application_number" FOREIGN KEY("application_number")
-- REFERENCES "application_cleaned_all" ("application_number");

-- ALTER TABLE "application_cleaned_patented" ADD CONSTRAINT "fk_application_cleaned_patented_patent_number" FOREIGN KEY("patent_number")
-- REFERENCES "application_cleaned_all" ("patent_number");

ALTER TABLE "application_cleaned_patented" ADD CONSTRAINT "fk_application_cleaned_patented_application_number" FOREIGN KEY( "application_number")
REFERENCES "application_cleaned_all" ( "application_number");



ALTER TABLE "application_cleaned_all" ADD CONSTRAINT "fk_application_cleaned_all_uspc_class" FOREIGN KEY("uspc_class")
REFERENCES "uspc_class_all" ("uspc_class");

ALTER TABLE "uspc_class_daysandrate" ADD CONSTRAINT "fk_uspc_class_daysandrate_uspc_class" FOREIGN KEY("uspc_class")
REFERENCES "uspc_class_all" ("uspc_class");

ALTER TABLE "uspc_attorney_success_withnames" ADD CONSTRAINT "fk_uspc_attorney_success_withnames_uspc_class" FOREIGN KEY("uspc_class")
REFERENCES "uspc_class_all" ("uspc_class");

ALTER TABLE "uspc_attorney_success_withnames" ADD CONSTRAINT "fk_uspc_attorney_success_withnames_atty_registration_number" FOREIGN KEY("atty_registration_number")
REFERENCES "attorney_success_withnames" ("atty_registration_number");

--
--SELECT * FROM patent_claims_stats;
SELECT * FROM all_inventors;
--SELECT * FROM uspc_class_all where uspc_class = '060';
SELECT * FROM uspc_class_all;
SELECT * FROM application_cleaned_patented;
SELECT * FROM application_cleaned_all;
SELECT * FROM uspc_class_daysandrate;
SELECT * FROM attorney_success_withnames;
SELECT * FROM uspc_attorney_success_withnames;
SELECT * from patent_claims_stats;

--MAKE AN APP: I am interested in finding the uspc_class X. 074 is Machine element or mechanism
--my_interest = "074"

select * from uspc_attorney_success_withnames 
where uspc_class = '074'
order by "application_number_all" desc;

select * from uspc_class_daysandrate 
where uspc_class = '074';

select *
from uspc_attorney_success_withnames
join uspc_class_daysandrate
on uspc_attorney_success_withnames.uspc_class = uspc_class_daysandrate.uspc_class
where uspc_attorney_success_withnames.uspc_class = '074'
order by uspc_attorney_success_withnames.application_number_all desc;


select *
from patent_claims_stats
join application_cleaned_patented
on patent_claims_stats.patent_number = application_cleaned_patented.patent_number
join all_inventors
on application_cleaned_patented.application_number = all_inventors.application_number
where patent_claims_stats.patent_number = 'RE45254';
