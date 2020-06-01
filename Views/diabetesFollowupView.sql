set role yenepoya;
drop view yenepoya_diabetes_followup_view;
create view yenepoya_diabetes_followup_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name",
             "Ind.Gender", "Ind.date_of_birth", "Ind.date_of_birth_verified",
             "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Id", "Enc.Type",
             "Enc.Id",
             "Enc.earliest_visit_date_time",
             "Enc.encounter_date_time",
             "Enc.program_enrolment_id",
             "Enc.uuid",
             "Enc.name",
             "Enc.max_visit_date_time",
             "Enc.is_voided", "Ind.Contact Number", "Enc.Adherence to medications",
             "Enc.Do you check your foot daily",
             "Enc.What about your physical activity",
             "Enc.Alcohol use in last 1 year",
             "Enc.What about the use of tobacco",
             "Enc.Eating of fast foods like fried and bakery items weekly",
             "Enc.Habit of vegetable intake atleast 3 servings daily",
             "Enc.Habit of fruit intake atleast 3 servings daily", "Enc.Height in CM",
             "Enc.weight",
             "Enc.mid arm circumference",
             "Enc.waist circumference",
             "Enc.blood Pressure (systolic)",
             "Enc.blood Pressure (Diastolic)",
             "Enc.random blood sugar levels report",
             "Enc.fasting blood sugar level reports in last one month",
             "Enc.post prandial blood sugar level reports in last one month",
             "Enc.diabetes followup,have you developed any complication",
             "Enc.Any complications,specify", "Enc.whether your blood sugar level is under control", "Rank")

as

SELECT individual.id                                                                                        "Ind.Id",
       individual.address_id                                                                                "Ind.address_id",
       individual.uuid                                                                                      "Ind.uuid",
       individual.first_name                                                                                "Ind.first_name",
       individual.last_name                                                                                 "Ind.last_name",
       g.name                                                                                               "Ind.Gender",
       individual.date_of_birth                                                                             "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                    "Ind.date_of_birth_verified",
       individual.registration_date                                                                         "Ind.registration_date",
       individual.facility_id                                                                               "Ind.facility_id",
       a.title                                                                                              "Ind.Area",
       individual.is_voided                                                                                 "Ind.is_voided",
       programEnrolment.id                                                                                  "Enl.Id",
       oet.name                                                                                             "Enc.Type",
       programEncounter.id                                                                                  "Enc.Id",
       programEncounter.earliest_visit_date_time                                                            "Enc.earliest_visit_date_time",
       programEncounter.encounter_date_time                                                                 "Enc.encounter_date_time",
       programEncounter.program_enrolment_id                                                                "Enc.program_enrolment_id",
       programEncounter.uuid                                                                                "Enc.uuid",
       programEncounter.name                                                                                "Enc.name",
       programEncounter.max_visit_date_time                                                                 "Enc.max_visit_date_time",
       programEncounter.is_voided                                                                           "Enc.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT                        as "Ind.Contact Number",

       single_select_coded(
               programEncounter.observations ->> '1341e326-d2b5-4cbc-b09a-108e10a84808')::TEXT           as "Enc.Adherence to medications",
       single_select_coded(
               programEncounter.observations ->> '644a912d-beb9-4140-a629-c6639b304e67')::TEXT           as "Enc.Do you check your foot daily",
       single_select_coded(
               programEncounter.observations ->> 'd7e707f2-4c4e-47e8-8907-7dab7770fc89')::TEXT           as "Enc.What about your physical activity",
       single_select_coded(
               programEncounter.observations ->> '29e472b6-0478-4de5-89f9-d7a4a373ff42')::TEXT           as "Enc.Alcohol use in last 1 year",
       single_select_coded(
               programEncounter.observations ->> 'ec3e201d-f4de-4705-b954-02c750ca5063')::TEXT           as "Enc.What about the use of tobacco",
       single_select_coded(
               programEncounter.observations ->> '182d8aef-512d-4d50-8fd8-95cb01f3ccbe')::TEXT           as "Enc.Eating of fast foods like fried and bakery items weekly",

       single_select_coded(
               programEncounter.observations ->> 'd31251b0-616a-47d5-84d6-7b5fad85baad')::TEXT           as "Enc.Habit of vegetable intake atleast 3 servings daily",
       single_select_coded(
               programEncounter.observations ->> '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d')::TEXT           as "Enc.Habit of fruit intake atleast 3 servings daily",
       (programEncounter.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                  as "Enc.Height in CM",
       (programEncounter.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                  as "Enc.Weight",
       (programEncounter.observations ->> '44a608f8-54d3-4a8b-96b8-7175c65e1d01')::TEXT                  as "Enc.Mid arm circumference",
       (programEncounter.observations ->> 'a9f45a38-99a7-4fd8-8e28-1291434eace0')::TEXT                  as "Enc.Waist circumference",

       (programEncounter.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                  as "Enc.Blood Pressure (systolic)",
       (programEncounter.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                  as "Enc.Blood Pressure (Diastolic)",
       (programEncounter.observations ->> '18d36389-e42d-4366-a316-053407c3a0ab')::TEXT                  as "Enc.Random blood sugar levels report",
       (programEncounter.observations ->> '3e30648a-5829-45bb-b2ef-f797462c397e')::TEXT                  as "Enc.Fasting blood sugar level reports in last one month",
       (programEncounter.observations ->> '22868608-488a-4be8-9dd3-d2c50fe1f6aa')::TEXT                  as "Enc.Post prandial blood sugar level reports in last one month",
       single_select_coded(
               programEncounter.observations ->> '60ad9a6a-cb8d-4145-9f8a-295d8fcc1759')::TEXT           as "Enc.Diabetes followup,have you developed any complication",
       (programEncounter.observations ->> '4144ec30-c97a-41c0-9049-76258ca7973c')::TEXT                  as "Enc.any complications,specify"
        ,
       single_select_coded(
               programEncounter.observations ->> '319c1184-2afb-4e10-9523-840645b6a130')::TEXT           as "Enc.Whether your blood sugar level is under control",
       row_number() OVER (PARTITION BY individual.id ORDER BY programEncounter.encounter_date_time DESC) AS Rank

FROM program_encounter programEncounter
         LEFT OUTER JOIN operational_encounter_type oet on programEncounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN program_enrolment programEnrolment
                         ON programEncounter.program_enrolment_id = programEnrolment.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
WHERE op.uuid = '2106f644-da4e-46cd-9940-a495be09d857'
  AND oet.uuid = '52814e7b-28a6-4acb-a9bd-eb01d6ee4698'
  AND programEncounter.encounter_date_time IS NOT NULL
  AND programEnrolment.enrolment_date_time IS NOT NULL;