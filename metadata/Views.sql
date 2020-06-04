create view yenepoya_diabetes_enrolment_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Program Name", "Enl.Id", "Enl.uuid", "Enl.is_voided", "Ind.Contact Number",
             "Enl.Adherence to medications", "Enl.Do you check your foot daily",
             "Enl.What about your physical activity", "Enl.Alcohol use in last 1 year",
             "Enl.What about the use of tobacco", "Enl.Eating of fast foods like fried and bakery items weekly",
             "Enl.Habit of vegetable intake atleast 3 servings daily",
             "Enl.Habit of fruit intake atleast 3 servings daily", "Enl.Height in CM", "Enl.Weight",
             "Enl.Mid arm circumference", "Enl.Waist circumference", "Enl.Abnormal waist circumference",
             "Enl.Waist circumference is normal", "Enl.Blood Pressure (systolic)", "Enl.Blood Pressure (Diastolic)",
             "Enl.Fasting blood sugar level reports in last one month",
             "Enl.Post prandial blood sugar level reports in last one month", "Enl.Random blood sugar levels report",
             "Enl.Whether your blood sugar level is under control")
as
SELECT individual.id                                                                                                 AS "Ind.Id",
       individual.address_id                                                                                         AS "Ind.address_id",
       individual.uuid                                                                                               AS "Ind.uuid",
       individual.first_name                                                                                         AS "Ind.first_name",
       individual.last_name                                                                                          AS "Ind.last_name",
       g.name                                                                                                        AS "Ind.Gender",
       individual.date_of_birth                                                                                      AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                             AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                                  AS "Ind.registration_date",
       individual.facility_id                                                                                        AS "Ind.facility_id",
       a.title                                                                                                       AS "Ind.Area",
       individual.is_voided                                                                                          AS "Ind.is_voided",
       op.name                                                                                                       AS "Enl.Program Name",
       programenrolment.id                                                                                           AS "Enl.Id",
       programenrolment.uuid                                                                                         AS "Enl.uuid",
       programenrolment.is_voided                                                                                    AS "Enl.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                                AS "Ind.Contact Number",
       (single_select_coded((programenrolment.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text                                   AS "Enl.Adherence to medications",
       (single_select_coded((programenrolment.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text                                   AS "Enl.Do you check your foot daily",
       (single_select_coded((programenrolment.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text                                   AS "Enl.What about your physical activity",
       (single_select_coded((programenrolment.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text                                   AS "Enl.Alcohol use in last 1 year",
       (single_select_coded((programenrolment.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text                                   AS "Enl.What about the use of tobacco",
       (single_select_coded((programenrolment.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text                                   AS "Enl.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programenrolment.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text                                   AS "Enl.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programenrolment.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text                                   AS "Enl.Habit of fruit intake atleast 3 servings daily",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                                                AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                                                AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                                                AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                                                AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text                                   AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text                                   AS "Enl.Waist circumference is normal",
       (programenrolment.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                                                AS "Enl.Blood Pressure (systolic)",
       (programenrolment.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                                                AS "Enl.Blood Pressure (Diastolic)",
       (programenrolment.observations ->>
        '3e30648a-5829-45bb-b2ef-f797462c397e'::text)                                                                AS "Enl.Fasting blood sugar level reports in last one month",
       (programenrolment.observations ->>
        '22868608-488a-4be8-9dd3-d2c50fe1f6aa'::text)                                                                AS "Enl.Post prandial blood sugar level reports in last one month",
       (programenrolment.observations ->>
        '18d36389-e42d-4366-a316-053407c3a0ab'::text)                                                                AS "Enl.Random blood sugar levels report",
       (single_select_coded((programenrolment.observations ->>
                             '319c1184-2afb-4e10-9523-840645b6a130'::text)))::text                                   AS "Enl.Whether your blood sugar level is under control"
FROM ((((program_enrolment programenrolment
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '2106f644-da4e-46cd-9940-a495be09d857'::text) AND
       (programenrolment.enrolment_date_time IS NOT NULL));

alter table yenepoya_diabetes_enrolment_view
    owner to yenepoya;



create view yenepoya_diabetes_followup_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Id", "Enc.Type", "Enc.Id", "Enc.earliest_visit_date_time", "Enc.encounter_date_time",
             "Enc.program_enrolment_id", "Enc.uuid", "Enc.name", "Enc.max_visit_date_time", "Enc.is_voided",
             "Ind.Contact Number", "Enc.Adherence to medications", "Enc.Do you check your foot daily",
             "Enc.What about your physical activity", "Enc.Alcohol use in last 1 year",
             "Enc.What about the use of tobacco", "Enc.Eating of fast foods like fried and bakery items weekly",
             "Enc.Habit of vegetable intake atleast 3 servings daily",
             "Enc.Habit of fruit intake atleast 3 servings daily", "Enc.Height in CM", "Enc.weight",
             "Enc.mid arm circumference", "Enc.waist circumference", "Enc.blood Pressure (systolic)",
             "Enc.blood Pressure (Diastolic)", "Enc.random blood sugar levels report",
             "Enc.fasting blood sugar level reports in last one month",
             "Enc.post prandial blood sugar level reports in last one month",
             "Enc.diabetes followup,have you developed any complication", "Enc.Any complications,specify",
             "Enc.whether your blood sugar level is under control", "Rank")
as
SELECT individual.id                                                                                                 AS "Ind.Id",
       individual.address_id                                                                                         AS "Ind.address_id",
       individual.uuid                                                                                               AS "Ind.uuid",
       individual.first_name                                                                                         AS "Ind.first_name",
       individual.last_name                                                                                          AS "Ind.last_name",
       g.name                                                                                                        AS "Ind.Gender",
       individual.date_of_birth                                                                                      AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                             AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                                  AS "Ind.registration_date",
       individual.facility_id                                                                                        AS "Ind.facility_id",
       a.title                                                                                                       AS "Ind.Area",
       individual.is_voided                                                                                          AS "Ind.is_voided",
       programenrolment.id                                                                                           AS "Enl.Id",
       oet.name                                                                                                      AS "Enc.Type",
       programencounter.id                                                                                           AS "Enc.Id",
       programencounter.earliest_visit_date_time                                                                     AS "Enc.earliest_visit_date_time",
       programencounter.encounter_date_time                                                                          AS "Enc.encounter_date_time",
       programencounter.program_enrolment_id                                                                         AS "Enc.program_enrolment_id",
       programencounter.uuid                                                                                         AS "Enc.uuid",
       programencounter.name                                                                                         AS "Enc.name",
       programencounter.max_visit_date_time                                                                          AS "Enc.max_visit_date_time",
       programencounter.is_voided                                                                                    AS "Enc.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                                AS "Ind.Contact Number",
       (single_select_coded((programencounter.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text                                   AS "Enc.Adherence to medications",
       (single_select_coded((programencounter.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text                                   AS "Enc.Do you check your foot daily",
       (single_select_coded((programencounter.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text                                   AS "Enc.What about your physical activity",
       (single_select_coded((programencounter.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text                                   AS "Enc.Alcohol use in last 1 year",
       (single_select_coded((programencounter.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text                                   AS "Enc.What about the use of tobacco",
       (single_select_coded((programencounter.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text                                   AS "Enc.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programencounter.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text                                   AS "Enc.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programencounter.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text                                   AS "Enc.Habit of fruit intake atleast 3 servings daily",
       (programencounter.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                                                AS "Enc.Height in CM",
       (programencounter.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                                                AS "Enc.weight",
       (programencounter.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                                                AS "Enc.mid arm circumference",
       (programencounter.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                                                AS "Enc.waist circumference",
       (programencounter.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                                                AS "Enc.blood Pressure (systolic)",
       (programencounter.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                                                AS "Enc.blood Pressure (Diastolic)",
       (programencounter.observations ->>
        '18d36389-e42d-4366-a316-053407c3a0ab'::text)                                                                AS "Enc.random blood sugar levels report",
       (programencounter.observations ->>
        '3e30648a-5829-45bb-b2ef-f797462c397e'::text)                                                                AS "Enc.fasting blood sugar level reports in last one month",
       (programencounter.observations ->>
        '22868608-488a-4be8-9dd3-d2c50fe1f6aa'::text)                                                                AS "Enc.post prandial blood sugar level reports in last one month",
       (single_select_coded((programencounter.observations ->>
                             '60ad9a6a-cb8d-4145-9f8a-295d8fcc1759'::text)))::text                                   AS "Enc.diabetes followup,have you developed any complication",
       (programencounter.observations ->>
        '4144ec30-c97a-41c0-9049-76258ca7973c'::text)                                                                AS "Enc.Any complications,specify",
       (single_select_coded((programencounter.observations ->>
                             '319c1184-2afb-4e10-9523-840645b6a130'::text)))::text                                   AS "Enc.whether your blood sugar level is under control",
       row_number()
       OVER (PARTITION BY individual.id ORDER BY programencounter.encounter_date_time DESC)                          AS "Rank"
FROM ((((((program_encounter programencounter
    LEFT JOIN operational_encounter_type oet ON ((programencounter.encounter_type_id = oet.encounter_type_id)))
    LEFT JOIN program_enrolment programenrolment ON ((programencounter.program_enrolment_id = programenrolment.id)))
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '2106f644-da4e-46cd-9940-a495be09d857'::text) AND
       ((oet.uuid)::text = '52814e7b-28a6-4acb-a9bd-eb01d6ee4698'::text) AND
       (programencounter.encounter_date_time IS NOT NULL) AND (programenrolment.enrolment_date_time IS NOT NULL));

alter table yenepoya_diabetes_followup_view
    owner to yenepoya;




create view yenepoya_history_of_fever_form_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enc.Type", "Enc.Id", "Enc.earliest_visit_date_time", "Enc.encounter_date_time",
             "Enc.uuid", "Enc.name", "Enc.max_visit_date_time", "Enc.is_voided", "Ind.Contact Number",
             "Enc.History of fever in last 15 days", "Enc.Have you consulted the doctor",
             "Enc.Was malaria/dengue test done", "Enc.Specify the test result", "Enc.Treatment taken",
             "Enc.Type of health facility utilized for diagnosis", "Enc.Type of health facility utilized for treatment",
             "Enc.Have you taken the full course of treatment", "Enc.Are you practising any mosquito prevention method",
             "Enc.Mention the method", "Enc.Any collection of water in surrounding", "Enc.Surce of water collection",
             "Enc.Have you been provided LLIN by Govt. health workers", "Enc.Are you utilizing the LLIN?",
             "Enc.Any Govt. health worker/MPW visited house in past 3 months",
             "Enc.Are you aware of mosquito control other than LLIN?",
             "Enc.What mosquito control measures are you aware of? mention.", "Enc.Type of health care utilization", "Enc.If government,
              then", "Enc.If private,
              then", "Enc.Are you aware of 24*7 hour Mobile Malaria Detection Unit?",
             "Enc.Have you utilized 24*7 hour Mobile Malaria Detection Unit?", "EncCancel.cancel_date_time",
             "EncCancel.Reason Of Cancellation", "EncCancel.Other Reason of Cancellation")
as
SELECT individual.id                                                                                          AS "Ind.Id",
       individual.address_id                                                                                  AS "Ind.address_id",
       individual.uuid                                                                                        AS "Ind.uuid",
       individual.first_name                                                                                  AS "Ind.first_name",
       individual.last_name                                                                                   AS "Ind.last_name",
       g.name                                                                                                 AS "Ind.Gender",
       individual.date_of_birth                                                                               AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                      AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                           AS "Ind.registration_date",
       individual.facility_id                                                                                 AS "Ind.facility_id",
       a.title                                                                                                AS "Ind.Area",
       individual.is_voided                                                                                   AS "Ind.is_voided",
       oet.name                                                                                               AS "Enc.Type",
       encounter.id                                                                                           AS "Enc.Id",
       encounter.earliest_visit_date_time                                                                     AS "Enc.earliest_visit_date_time",
       encounter.encounter_date_time                                                                          AS "Enc.encounter_date_time",
       encounter.uuid                                                                                         AS "Enc.uuid",
       encounter.name                                                                                         AS "Enc.name",
       encounter.max_visit_date_time                                                                          AS "Enc.max_visit_date_time",
       encounter.is_voided                                                                                    AS "Enc.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                         AS "Ind.Contact Number",
       (single_select_coded(
               (encounter.observations ->> '59d2e12f-1d6d-4fac-9d9a-cae3ca021269'::text)))::text              AS "Enc.History of fever in last 15 days",
       (single_select_coded(
               (encounter.observations ->> '900b7304-3936-4ad7-bd59-3bf42a4cde64'::text)))::text              AS "Enc.Have you consulted the doctor",
       (single_select_coded(
               (encounter.observations ->> '38f12c1d-2536-4932-84f5-cf977a4a0e25'::text)))::text              AS "Enc.Was malaria/dengue test done",
       (single_select_coded(
               (encounter.observations ->> '08110960-7364-43ed-8990-afdcb47e975b'::text)))::text              AS "Enc.Specify the test result",
       (single_select_coded(
               (encounter.observations ->> '87fa4bfa-c929-4c12-a328-bc2620b7db79'::text)))::text              AS "Enc.Treatment taken",
       (single_select_coded(
               (encounter.observations ->> 'b0a3576e-3379-4105-afec-c37dddde80db'::text)))::text              AS "Enc.Type of health facility utilized for diagnosis",
       (single_select_coded(
               (encounter.observations ->> '0b267bfd-6c1a-43dd-a953-0b31e300ba6d'::text)))::text              AS "Enc.Type of health facility utilized for treatment",
       (single_select_coded(
               (encounter.observations ->> '162edcfb-6c3f-49a6-9024-608ff7f74c35'::text)))::text              AS "Enc.Have you taken the full course of treatment",
       (single_select_coded(
               (encounter.observations ->> 'a75978ab-b246-4500-b212-dc25e327c09a'::text)))::text              AS "Enc.Are you practising any mosquito prevention method",
       (multi_select_coded(
               (encounter.observations -> '9baaadc0-479b-44b3-87d3-4abc0fdb67a4'::text)))::text               AS "Enc.Mention the method",
       (single_select_coded(
               (encounter.observations ->> 'b82ec179-0c04-4c9c-a2e9-ed94834084a4'::text)))::text              AS "Enc.Any collection of water in surrounding",
       (multi_select_coded(
               (encounter.observations -> '0afc590f-5a27-44f2-94a6-28c2f8bc92a7'::text)))::text               AS "Enc.Surce of water collection",
       (single_select_coded(
               (encounter.observations ->> '12eb504d-f7c2-4e27-a690-3030511f135a'::text)))::text              AS "Enc.Have you been provided LLIN by Govt. health workers",
       (single_select_coded(
               (encounter.observations ->> '687e6e05-4103-4270-b76c-18521df8cf1f'::text)))::text              AS "Enc.Are you utilizing the LLIN?",
       (single_select_coded(
               (encounter.observations ->> 'cc9fcdfe-8465-4ff8-b28d-f3ad246b499b'::text)))::text              AS "Enc.Any Govt. health worker/MPW visited house in past 3 months",
       (single_select_coded(
               (encounter.observations ->> '2a19b6ac-896e-42e5-b3d6-c45896a7df35'::text)))::text              AS "Enc.Are you aware of mosquito control other than LLIN?",
       (multi_select_coded(
               (encounter.observations -> '3eeacd19-1d67-4a1a-9d39-0c919968cbf8'::text)))::text               AS "Enc.What mosquito control measures are you aware of? mention.",
       (multi_select_coded(
               (encounter.observations -> '9b031289-dcfa-4ccd-a868-cee9d2d33cba'::text)))::text               AS "Enc.Type of health care utilization",
       (multi_select_coded((encounter.observations -> '92ca8513-897b-4d73-8b55-fbed59f19b56'::text)))::text   AS "Enc.If government,
              then",
       (multi_select_coded((encounter.observations -> '8290ba03-6b33-4f5e-a8af-a22a376099ad'::text)))::text   AS "Enc.If private,
              then",
       (single_select_coded(
               (encounter.observations ->> '44154176-fc48-4ae6-9fe6-d534ad7f7c93'::text)))::text              AS "Enc.Are you aware of 24*7 hour Mobile Malaria Detection Unit?",
       (single_select_coded(
               (encounter.observations ->> 'e224f89f-f9a1-4731-9c05-3ce61d46eef5'::text)))::text              AS "Enc.Have you utilized 24*7 hour Mobile Malaria Detection Unit?",
       encounter.cancel_date_time                                                                             AS "EncCancel.cancel_date_time",
       (single_select_coded(
               (encounter.observations ->> '5592def2-fe5e-4234-9253-ca5fd0322e26'::text)))::text              AS "EncCancel.Reason Of Cancellation",
       (encounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862'::text)                              AS "EncCancel.Other Reason of Cancellation"
FROM ((((encounter encounter
    LEFT JOIN operational_encounter_type oet ON ((encounter.encounter_type_id = oet.encounter_type_id)))
    LEFT JOIN individual individual ON ((encounter.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((oet.uuid)::text = '0e511773-157a-400c-837c-33e46a30b71e'::text) AND
       (encounter.encounter_date_time IS NOT NULL));

alter table yenepoya_history_of_fever_form_view
    owner to yenepoya;



create view yenepoya_household_registration
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Ind.Name of the surveillance Unit", "Ind.Name of the panchayat/Ward", "Ind.landmark",
             "Ind.Name of the PHC/UPHC", "Ind.Specify Other", "Ind.Name of the sub centre", "Ind.Household number",
             "Ind.Name of the head of the family", "Ind.Gender of HoF", "Ind.Type of family", "Ind.Total Income",
             "Ind.Contact Number", "Ind.Mother Tongue", "Ind.Other mother tongue",
             "Ind.Which religion do you practice?", "Ind.You belong to which social class?", "Ind.Other social class",
             "Ind.Are you resident of this area for more than 1 year", "Ind.Type of Ration card")
as
SELECT individual.id                                                                                           AS "Ind.Id",
       individual.address_id                                                                                   AS "Ind.address_id",
       individual.uuid                                                                                         AS "Ind.uuid",
       individual.first_name                                                                                   AS "Ind.first_name",
       individual.last_name                                                                                    AS "Ind.last_name",
       g.name                                                                                                  AS "Ind.Gender",
       individual.date_of_birth                                                                                AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                       AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                            AS "Ind.registration_date",
       individual.facility_id                                                                                  AS "Ind.facility_id",
       a.title                                                                                                 AS "Ind.Area",
       individual.is_voided                                                                                    AS "Ind.is_voided",
       (single_select_coded((individual.observations ->>
                             '1de1bfa2-030a-4ccb-8381-ee5105048fa2'::text)))::text                             AS "Ind.Name of the surveillance Unit",
       (single_select_coded((individual.observations ->>
                             '673a87ab-78cd-42a3-a6cf-47761c8beffe'::text)))::text                             AS "Ind.Name of the panchayat/Ward",
       (individual.observations ->>
        'ef182a85-8f38-418e-bf0e-fcf2c3c655f0'::text)                                                          AS "Ind.landmark",
       (single_select_coded((individual.observations ->>
                             '1948be58-d42e-4313-8ec5-ac9ca87eb399'::text)))::text                             AS "Ind.Name of the PHC/UPHC",
       (individual.observations ->>
        '7868f697-abc9-4f49-8a0d-3deab5679502'::text)                                                          AS "Ind.Specify Other",
       (individual.observations ->>
        'e9ce5187-db1e-40cf-ad42-4b1c27d553f8'::text)                                                          AS "Ind.Name of the sub centre",
       (individual.observations ->>
        '558469e8-d993-45ec-9d9b-f019c3642bab'::text)                                                          AS "Ind.Household number",
       (individual.observations ->>
        '6633afc7-d0e4-4427-87d4-277d8942ff48'::text)                                                          AS "Ind.Name of the head of the family",
       (single_select_coded((individual.observations ->>
                             '83fbfa4c-164e-4eb2-b207-d9263c1b3b4d'::text)))::text                             AS "Ind.Gender of HoF",
       (single_select_coded((individual.observations ->>
                             '52a8b9a2-499b-4362-a95f-4df018cd644a'::text)))::text                             AS "Ind.Type of family",
       (individual.observations ->>
        '752cf346-243e-447a-a973-53891cb110b0'::text)                                                          AS "Ind.Total Income",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                          AS "Ind.Contact Number",
       (single_select_coded((individual.observations ->>
                             '57251d49-3cfb-4e49-a053-7364a663bf1d'::text)))::text                             AS "Ind.Mother Tongue",
       (individual.observations ->>
        'f2058089-18f8-4442-84cf-94cf1cea28a6'::text)                                                          AS "Ind.Other mother tongue",
       (single_select_coded((individual.observations ->>
                             '60320b20-433d-4167-84e2-5cea3351739f'::text)))::text                             AS "Ind.Which religion do you practice?",
       (single_select_coded((individual.observations ->>
                             '26024a7b-b664-4eef-90e4-1fe23283378f'::text)))::text                             AS "Ind.You belong to which social class?",
       (individual.observations ->>
        '81323643-274c-4831-9d1a-a17e2dfcd225'::text)                                                          AS "Ind.Other social class",
       (single_select_coded((individual.observations ->>
                             '2253872c-c629-4f6f-96bc-72ba23892290'::text)))::text                             AS "Ind.Are you resident of this area for more than 1 year",
       (single_select_coded((individual.observations ->>
                             '49344ffb-d10c-4e30-a284-356396970bcf'::text)))::text                             AS "Ind.Type of Ration card"
FROM ((individual individual
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (individual.subject_type_id = (SELECT subject_type.id
                                     FROM subject_type
                                     WHERE ((subject_type.name)::text = 'Household'::text)));

alter table yenepoya_household_registration
    owner to yenepoya;



create view yenepoya_household_survey_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enc.Type", "Enc.Id", "Enc.earliest_visit_date_time", "Enc.encounter_date_time",
             "Enc.uuid", "Enc.name", "Enc.max_visit_date_time", "Enc.is_voided", "Ind.Name of the surveillance Unit",
             "Ind.Name of the panchayat/Ward", "Ind.landmark", "Ind.Name of the PHC/UPHC", "Ind.Specify Other",
             "Ind.Name of the sub centre", "Ind.Household number", "Ind.Name of the head of the family",
             "Ind.Gender of HoF", "Ind.Type of family", "Ind.Total Income", "Ind.Contact Number", "Ind.Mother Tongue",
             "Ind.Other mother tongue", "Ind.Which religion do you practice?", "Ind.You belong to which social class?",
             "Ind.Other social class", "Ind.Are you resident of this area for more than 1 year",
             "Ind.Type of Ration card", "Enc.Age of HoF", "Enc.Marrital status of hoF",
             "Enc.Number of individuals in the household", "Enc.Are there members with known case of chronic illness?",
             "Enc.Specify  known case of chronic illness", "Enc.Are there members with any illness in last two weeks?",
             "Enc.Specify illness in last two weeks", "Enc.Any member in your family with some disability",
             "Enc.If Yes give details about disability", "Enc.Household Total Expenditure per month",
             "Enc.Out-of-pocket payments exceeding 10% of household total",
             "Enc.How many rooms in this household is used for sleeping?", "Enc.Separate Kitchen", "Enc.Type of fuel",
             "Enc.Specify fuel", "Enc.Any nuisance  reported by family member",
             "Enc.Type of potential breeding sites present", "Enc.Specify breeding sites present",
             "Enc.Are you using any insecticide treated bed nets?",
             "Enc.Segregation of waste at source (wet and dry waste)",
             "Enc.Most common household waste disposal method", "Enc.Is there a latrine in your house?",
             "Enc.Who has constructed the latrine?", "Enc.Is open air defecation practiced by family member",
             "Enc.what type of drainage facility does your household have?", "Enc.Source of water (Domestic use)",
             "Enc.Specify source of water", "Enc.Source of drinking water?", "Enc.Specify source of drinking water",
             "Enc.Whether panchayt/corporation provide chlorinated water?", "Enc.Domestic purification methods used",
             "Enc.Regularity of water supply", "Enc.Health facility preferred for chronic illness",
             "Enc.Name the health facility preferred for chronic illness",
             "Enc.Specify the health facility preferred for chronic illness",
             "Enc.Health facility preferred for acute illness",
             "Enc.Name the Health facility preferred for acute illness", "Enc.Specify other acute illness",
             "Enc.Reason of visiting preferred health care facility",
             "Enc.Specify Reason of visiting preferred health care facility",
             "Enc.If member having mental illness,is availing health services",
             "Enc.Are you availing any social security schemes", "Enc.Name the  social security scheme",
             "Enc.Specify social security scheme", "Enc.Transport facility", "Enc.Electronic gadgets",
             "Enc.Do you have any of these facilities", "Enc.Any vital events",
             "Enc.Any member of your family working abroad?", "Enc.Provide name and place of work",
             "EncCancel.cancel_date_time", "EncCancel.Date of Cancel", "EncCancel.Reason Of Cancellation survey",
             "EncCancel.Other Reason of Cancellation")
as
SELECT individual.id                                                                                           AS "Ind.Id",
       individual.address_id                                                                                   AS "Ind.address_id",
       individual.uuid                                                                                         AS "Ind.uuid",
       individual.first_name                                                                                   AS "Ind.first_name",
       individual.last_name                                                                                    AS "Ind.last_name",
       g.name                                                                                                  AS "Ind.Gender",
       individual.date_of_birth                                                                                AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                       AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                            AS "Ind.registration_date",
       individual.facility_id                                                                                  AS "Ind.facility_id",
       a.title                                                                                                 AS "Ind.Area",
       individual.is_voided                                                                                    AS "Ind.is_voided",
       oet.name                                                                                                AS "Enc.Type",
       encounter.id                                                                                            AS "Enc.Id",
       encounter.earliest_visit_date_time                                                                      AS "Enc.earliest_visit_date_time",
       encounter.encounter_date_time                                                                           AS "Enc.encounter_date_time",
       encounter.uuid                                                                                          AS "Enc.uuid",
       encounter.name                                                                                          AS "Enc.name",
       encounter.max_visit_date_time                                                                           AS "Enc.max_visit_date_time",
       encounter.is_voided                                                                                     AS "Enc.is_voided",
       (single_select_coded((individual.observations ->>
                             '1de1bfa2-030a-4ccb-8381-ee5105048fa2'::text)))::text                             AS "Ind.Name of the surveillance Unit",
       (single_select_coded((individual.observations ->>
                             '673a87ab-78cd-42a3-a6cf-47761c8beffe'::text)))::text                             AS "Ind.Name of the panchayat/Ward",
       (individual.observations ->>
        'ef182a85-8f38-418e-bf0e-fcf2c3c655f0'::text)                                                          AS "Ind.landmark",
       (single_select_coded((individual.observations ->>
                             '1948be58-d42e-4313-8ec5-ac9ca87eb399'::text)))::text                             AS "Ind.Name of the PHC/UPHC",
       (individual.observations ->>
        '7868f697-abc9-4f49-8a0d-3deab5679502'::text)                                                          AS "Ind.Specify Other",
       (individual.observations ->>
        'e9ce5187-db1e-40cf-ad42-4b1c27d553f8'::text)                                                          AS "Ind.Name of the sub centre",
       (individual.observations ->>
        '558469e8-d993-45ec-9d9b-f019c3642bab'::text)                                                          AS "Ind.Household number",
       (individual.observations ->>
        '6633afc7-d0e4-4427-87d4-277d8942ff48'::text)                                                          AS "Ind.Name of the head of the family",
       (single_select_coded((individual.observations ->>
                             '83fbfa4c-164e-4eb2-b207-d9263c1b3b4d'::text)))::text                             AS "Ind.Gender of HoF",
       (single_select_coded((individual.observations ->>
                             '52a8b9a2-499b-4362-a95f-4df018cd644a'::text)))::text                             AS "Ind.Type of family",
       (individual.observations ->>
        '752cf346-243e-447a-a973-53891cb110b0'::text)                                                          AS "Ind.Total Income",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                          AS "Ind.Contact Number",
       (single_select_coded((individual.observations ->>
                             '57251d49-3cfb-4e49-a053-7364a663bf1d'::text)))::text                             AS "Ind.Mother Tongue",
       (individual.observations ->>
        'f2058089-18f8-4442-84cf-94cf1cea28a6'::text)                                                          AS "Ind.Other mother tongue",
       (single_select_coded((individual.observations ->>
                             '60320b20-433d-4167-84e2-5cea3351739f'::text)))::text                             AS "Ind.Which religion do you practice?",
       (single_select_coded((individual.observations ->>
                             '26024a7b-b664-4eef-90e4-1fe23283378f'::text)))::text                             AS "Ind.You belong to which social class?",
       (individual.observations ->>
        '81323643-274c-4831-9d1a-a17e2dfcd225'::text)                                                          AS "Ind.Other social class",
       (single_select_coded((individual.observations ->>
                             '2253872c-c629-4f6f-96bc-72ba23892290'::text)))::text                             AS "Ind.Are you resident of this area for more than 1 year",
       (single_select_coded((individual.observations ->>
                             '49344ffb-d10c-4e30-a284-356396970bcf'::text)))::text                             AS "Ind.Type of Ration card",
       (encounter.observations ->> '25723471-1596-4786-a390-79a687e9c61b'::text)                               AS "Enc.Age of HoF",
       (single_select_coded(
               (encounter.observations ->> 'be84eb6c-fe84-457b-b2f7-f512b6961125'::text)))::text               AS "Enc.Marrital status of hoF",
       (encounter.observations ->> '0bd4084c-11cb-4a30-84aa-c4cf5b2926d1'::text)                               AS "Enc.Number of individuals in the household",
       (multi_select_coded(
               (encounter.observations -> 'c5c9d1b4-54f8-4676-ba39-18d9a5f3c7a3'::text)))::text                AS "Enc.Are there members with known case of chronic illness?",
       (encounter.observations ->> 'caa23e49-901e-43ac-a246-33a16e83493a'::text)                               AS "Enc.Specify  known case of chronic illness",
       (multi_select_coded(
               (encounter.observations -> '0b5215d5-f721-4993-8f30-b85f5b397988'::text)))::text                AS "Enc.Are there members with any illness in last two weeks?",
       (encounter.observations ->> '9b12024d-08e0-486b-b4b9-ddc21b6f199d'::text)                               AS "Enc.Specify illness in last two weeks",
       (single_select_coded(
               (encounter.observations ->> '2a1c24fd-912a-485d-bf8e-5a722d8ab5a1'::text)))::text               AS "Enc.Any member in your family with some disability",
       (encounter.observations ->> '71124244-b1e2-42a7-82b3-15b79524352e'::text)                               AS "Enc.If Yes give details about disability",
       (encounter.observations ->> '00edb1c7-acda-4982-a414-0ea121f616bf'::text)                               AS "Enc.Household Total Expenditure per month",
       (single_select_coded(
               (encounter.observations ->> '0cff16cb-8018-4908-aecc-9d6410b797d1'::text)))::text               AS "Enc.Out-of-pocket payments exceeding 10% of household total",
       (encounter.observations ->> 'd3031e04-7ad0-4075-b465-1f75678177aa'::text)                               AS "Enc.How many rooms in this household is used for sleeping?",
       (single_select_coded(
               (encounter.observations ->> 'a69677d2-d3e8-4458-8d21-0936bc9a510d'::text)))::text               AS "Enc.Separate Kitchen",
       (single_select_coded(
               (encounter.observations ->> '4c9e7144-8e05-4b64-8d00-b769f5e23cf3'::text)))::text               AS "Enc.Type of fuel",
       (encounter.observations ->> '14c847cd-ba22-49cd-8d2e-8e4e99ec9dbd'::text)                               AS "Enc.Specify fuel",
       (single_select_coded(
               (encounter.observations ->> '9d6ca8db-4d5b-42ee-8ba3-a153a91bf0e8'::text)))::text               AS "Enc.Any nuisance  reported by family member",
       (multi_select_coded(
               (encounter.observations -> '225531c0-df1c-4ac2-8a24-c20d38b2b124'::text)))::text                AS "Enc.Type of potential breeding sites present",
       (encounter.observations ->> '52f3f9b2-dab9-46fc-8b66-776f34a9fd58'::text)                               AS "Enc.Specify breeding sites present",
       (single_select_coded(
               (encounter.observations ->> '8f4baf0b-02f8-4bfc-adb7-996355c46cf4'::text)))::text               AS "Enc.Are you using any insecticide treated bed nets?",
       (single_select_coded(
               (encounter.observations ->> '65552252-53a2-4846-ac6f-60e06dd7dacf'::text)))::text               AS "Enc.Segregation of waste at source (wet and dry waste)",
       (single_select_coded(
               (encounter.observations ->> 'eaf15d71-4654-4efc-ba1f-28d5e365bb1a'::text)))::text               AS "Enc.Most common household waste disposal method",
       (single_select_coded(
               (encounter.observations ->> 'cfa00c40-3c1a-4f98-9c34-f2f5e13f229b'::text)))::text               AS "Enc.Is there a latrine in your house?",
       (single_select_coded(
               (encounter.observations ->> 'd21f3a62-2cd9-4f34-9797-978a1ce6fbf0'::text)))::text               AS "Enc.Who has constructed the latrine?",
       (single_select_coded(
               (encounter.observations ->> '09acf590-7148-4ec1-b5a0-3ab34309d153'::text)))::text               AS "Enc.Is open air defecation practiced by family member",
       (single_select_coded(
               (encounter.observations ->> '2c11d1e4-072c-40a2-8a68-24855f7d4027'::text)))::text               AS "Enc.what type of drainage facility does your household have?",
       (multi_select_coded(
               (encounter.observations -> '36ab6284-c3ca-4de8-8593-eba915a03791'::text)))::text                AS "Enc.Source of water (Domestic use)",
       (encounter.observations ->> '78c763af-bced-49aa-813a-66a19dde3ebb'::text)                               AS "Enc.Specify source of water",
       (multi_select_coded(
               (encounter.observations -> 'f3250681-0a1e-4e7a-9654-d15b24b0d78c'::text)))::text                AS "Enc.Source of drinking water?",
       (encounter.observations ->> '5f3931f3-fd5e-4666-b1e2-01db24684fb6'::text)                               AS "Enc.Specify source of drinking water",
       (single_select_coded(
               (encounter.observations ->> '2ee24106-43f2-4b2f-9ff7-75080851bed3'::text)))::text               AS "Enc.Whether panchayt/corporation provide chlorinated water?",
       (single_select_coded(
               (encounter.observations ->> '7ba3b46e-d9f7-4f91-b38d-a587a4686951'::text)))::text               AS "Enc.Domestic purification methods used",
       (single_select_coded(
               (encounter.observations ->> 'b40f407f-b68e-44fe-b641-86ab8b7ab51d'::text)))::text               AS "Enc.Regularity of water supply",
       (single_select_coded(
               (encounter.observations ->> 'db05dadf-5955-4d5d-a62d-b7f7a1ecf6ce'::text)))::text               AS "Enc.Health facility preferred for chronic illness",
       (multi_select_coded(
               (encounter.observations -> '84b9db51-33ce-4da0-a5cc-5ea2058f95ad'::text)))::text                AS "Enc.Name the health facility preferred for chronic illness",
       (encounter.observations ->> '54a36cb8-a7a0-415d-84c7-2ca4b88e8f87'::text)                               AS "Enc.Specify the health facility preferred for chronic illness",
       (single_select_coded(
               (encounter.observations ->> 'da29256e-720c-4071-a8f4-9e563749aef1'::text)))::text               AS "Enc.Health facility preferred for acute illness",
       (multi_select_coded(
               (encounter.observations -> '84a7b976-1730-479f-926a-dcdaac00b876'::text)))::text                AS "Enc.Name the Health facility preferred for acute illness",
       (encounter.observations ->> '1a436a53-b279-49b1-87b4-efad33a34a4d'::text)                               AS "Enc.Specify other acute illness",
       (multi_select_coded(
               (encounter.observations -> '5987c751-0e34-4e76-aa1a-95b31d7af765'::text)))::text                AS "Enc.Reason of visiting preferred health care facility",
       (encounter.observations ->> '4239ddc6-60cc-4ac0-ad7d-3d35bf2caace'::text)                               AS "Enc.Specify Reason of visiting preferred health care facility",
       (single_select_coded(
               (encounter.observations ->> '67c33f11-2358-4360-8b86-65633232c773'::text)))::text               AS "Enc.If member having mental illness,is availing health services",
       (single_select_coded(
               (encounter.observations ->> '5b99afca-55eb-4793-824b-361d94d5c3d7'::text)))::text               AS "Enc.Are you availing any social security schemes",
       (multi_select_coded(
               (encounter.observations -> 'a7815743-9b97-4631-9df7-a5a982ca3b2a'::text)))::text                AS "Enc.Name the  social security scheme",
       (encounter.observations ->> '003d18b4-2f1f-4fa8-97fd-5049c83eb1f0'::text)                               AS "Enc.Specify social security scheme",
       (multi_select_coded(
               (encounter.observations -> '19df1265-d795-4f29-94a9-422f1bef645b'::text)))::text                AS "Enc.Transport facility",
       (multi_select_coded(
               (encounter.observations -> 'ed7fa0bb-ba46-4a2f-bf3e-4005ea4c046c'::text)))::text                AS "Enc.Electronic gadgets",
       (multi_select_coded(
               (encounter.observations -> '00177962-6242-48e0-8bf7-9bc879bdb976'::text)))::text                AS "Enc.Do you have any of these facilities",
       (multi_select_coded(
               (encounter.observations -> 'eb52fe79-3b96-4b3f-8bc6-ddda16746eed'::text)))::text                AS "Enc.Any vital events",
       (single_select_coded(
               (encounter.observations ->> '2457b432-21ab-4636-8551-b4682c51bb40'::text)))::text               AS "Enc.Any member of your family working abroad?",
       (encounter.observations ->> 'f0a15451-6e52-4d2d-b893-0f74ec662560'::text)                               AS "Enc.Provide name and place of work",
       encounter.cancel_date_time                                                                              AS "EncCancel.cancel_date_time",
       ((encounter.observations ->> '20460001-db72-4052-9168-9861a40df088'::text))::date                       AS "EncCancel.Date of Cancel",
       (single_select_coded(
               (encounter.observations ->> '46182e50-6b63-4588-a8c8-8d0288ce2477'::text)))::text               AS "EncCancel.Reason Of Cancellation survey",
       (encounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862'::text)                               AS "EncCancel.Other Reason of Cancellation"
FROM ((((encounter encounter
    JOIN operational_encounter_type oet ON ((encounter.encounter_type_id = oet.encounter_type_id)))
    JOIN individual individual ON ((encounter.individual_id = individual.id)))
    JOIN gender g ON ((g.id = individual.gender_id)))
         JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((oet.uuid)::text = '767e7ef2-4a45-4c17-9939-773f97c0baf0'::text) AND
       (encounter.encounter_date_time IS NOT NULL));

alter table yenepoya_household_survey_view
    owner to yenepoya;




create view yenepoya_hypertension_enrolment_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Program Name", "Enl.Id", "Enl.uuid", "Enl.is_voided", "Ind.Contact Number",
             "Enl.Adherence to medications", "Enl.Do you check your foot daily",
             "Enl.What about your physical activity", "Enl.Alcohol use in last 1 year",
             "Enl.What about the use of tobacco", "Enl.Eating of fast foods like fried and bakery items weekly",
             "Enl.preference for food with excess salt", "Enl.Habit of vegetable intake atleast 3 servings daily",
             "Enl.Habit of fruit intake atleast 3 servings daily", "Enl.Height in CM", "Enl.Weight",
             "Enl.Mid arm circumference", "Enl.Waist circumference", "Enl.Abnormal waist circumference",
             "Enl.Waist circumference is normal", "Enl.Blood Pressure (systolic)", "Enl.Blood Pressure (Diastolic)",
             "Enl.Whether your blood sugar level is under control")
as
SELECT individual.id                                                                                                 AS "Ind.Id",
       individual.address_id                                                                                         AS "Ind.address_id",
       individual.uuid                                                                                               AS "Ind.uuid",
       individual.first_name                                                                                         AS "Ind.first_name",
       individual.last_name                                                                                          AS "Ind.last_name",
       g.name                                                                                                        AS "Ind.Gender",
       individual.date_of_birth                                                                                      AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                             AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                                  AS "Ind.registration_date",
       individual.facility_id                                                                                        AS "Ind.facility_id",
       a.title                                                                                                       AS "Ind.Area",
       individual.is_voided                                                                                          AS "Ind.is_voided",
       op.name                                                                                                       AS "Enl.Program Name",
       programenrolment.id                                                                                           AS "Enl.Id",
       programenrolment.uuid                                                                                         AS "Enl.uuid",
       programenrolment.is_voided                                                                                    AS "Enl.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                                AS "Ind.Contact Number",
       (single_select_coded((programenrolment.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text                                   AS "Enl.Adherence to medications",
       (single_select_coded((programenrolment.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text                                   AS "Enl.Do you check your foot daily",
       (single_select_coded((programenrolment.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text                                   AS "Enl.What about your physical activity",
       (single_select_coded((programenrolment.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text                                   AS "Enl.Alcohol use in last 1 year",
       (single_select_coded((programenrolment.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text                                   AS "Enl.What about the use of tobacco",
       (single_select_coded((programenrolment.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text                                   AS "Enl.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programenrolment.observations ->>
                             'fc5fb2db-c47c-43c3-9872-c64fd0ec23e4'::text)))::text                                   AS "Enl.preference for food with excess salt",
       (single_select_coded((programenrolment.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text                                   AS "Enl.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programenrolment.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text                                   AS "Enl.Habit of fruit intake atleast 3 servings daily",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                                                AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                                                AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                                                AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                                                AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text                                   AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text                                   AS "Enl.Waist circumference is normal",
       (programenrolment.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                                                AS "Enl.Blood Pressure (systolic)",
       (programenrolment.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                                                AS "Enl.Blood Pressure (Diastolic)",
       (single_select_coded((programenrolment.observations ->>
                             '8bc6db2a-388d-4028-a995-865ff018c8f6'::text)))::text                                   AS "Enl.Whether your blood sugar level is under control"
FROM ((((program_enrolment programenrolment
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '4e3dc382-f14a-4a56-8ab8-e4cc4faca774'::text) AND
       (programenrolment.enrolment_date_time IS NOT NULL));

alter table yenepoya_hypertension_enrolment_view
    owner to yenepoya;



create view yenepoya_hypertension_followup_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Id", "Enc.Type", "Enc.Id", "Enc.earliest_visit_date_time", "Enc.encounter_date_time",
             "Enc.program_enrolment_id", "Enc.uuid", "Enc.name", "Enc.max_visit_date_time", "Enc.is_voided",
             "Ind.Contact Number", "Enc.Adherence to medications", "Enc.Do you check your foot daily",
             "Enc.What about your physical activity", "Enc.Alcohol use in last 1 year",
             "Enc.What about the use of tobacco", "Enc.Eating of fast foods like fried and bakery items weekly",
             "Enc.preference for food with excess salt", "Enc.Habit of vegetable intake atleast 3 servings daily",
             "Enc.Habit of fruit intake atleast 3 servings daily", "Enc.Height in CM", "Enc.weight",
             "Enc.mid arm circumference", "Enc.waist circumference", "Enc.blood Pressure (systolic)",
             "Enc.blood Pressure (Diastolic)", "Enc.whether your blood sugar level is under control",
             "EncCancel.cancel_date_time", "EncCancel.Reason Of Cancellation", "EncCancel.Other Reason of Cancellation",
             rank)
as
SELECT individual.id                                                                                                 AS "Ind.Id",
       individual.address_id                                                                                         AS "Ind.address_id",
       individual.uuid                                                                                               AS "Ind.uuid",
       individual.first_name                                                                                         AS "Ind.first_name",
       individual.last_name                                                                                          AS "Ind.last_name",
       g.name                                                                                                        AS "Ind.Gender",
       individual.date_of_birth                                                                                      AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                             AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                                  AS "Ind.registration_date",
       individual.facility_id                                                                                        AS "Ind.facility_id",
       a.title                                                                                                       AS "Ind.Area",
       individual.is_voided                                                                                          AS "Ind.is_voided",
       programenrolment.id                                                                                           AS "Enl.Id",
       oet.name                                                                                                      AS "Enc.Type",
       programencounter.id                                                                                           AS "Enc.Id",
       programencounter.earliest_visit_date_time                                                                     AS "Enc.earliest_visit_date_time",
       programencounter.encounter_date_time                                                                          AS "Enc.encounter_date_time",
       programencounter.program_enrolment_id                                                                         AS "Enc.program_enrolment_id",
       programencounter.uuid                                                                                         AS "Enc.uuid",
       programencounter.name                                                                                         AS "Enc.name",
       programencounter.max_visit_date_time                                                                          AS "Enc.max_visit_date_time",
       programencounter.is_voided                                                                                    AS "Enc.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                                AS "Ind.Contact Number",
       (single_select_coded((programencounter.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text                                   AS "Enc.Adherence to medications",
       (single_select_coded((programencounter.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text                                   AS "Enc.Do you check your foot daily",
       (single_select_coded((programencounter.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text                                   AS "Enc.What about your physical activity",
       (single_select_coded((programencounter.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text                                   AS "Enc.Alcohol use in last 1 year",
       (single_select_coded((programencounter.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text                                   AS "Enc.What about the use of tobacco",
       (single_select_coded((programencounter.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text                                   AS "Enc.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programencounter.observations ->>
                             'fc5fb2db-c47c-43c3-9872-c64fd0ec23e4'::text)))::text                                   AS "Enc.preference for food with excess salt",
       (single_select_coded((programencounter.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text                                   AS "Enc.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programencounter.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text                                   AS "Enc.Habit of fruit intake atleast 3 servings daily",
       (programencounter.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                                                AS "Enc.Height in CM",
       (programencounter.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                                                AS "Enc.weight",
       (programencounter.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                                                AS "Enc.mid arm circumference",
       (programencounter.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                                                AS "Enc.waist circumference",
       (programencounter.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                                                AS "Enc.blood Pressure (systolic)",
       (programencounter.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                                                AS "Enc.blood Pressure (Diastolic)",
       (single_select_coded((programencounter.observations ->>
                             '8bc6db2a-388d-4028-a995-865ff018c8f6'::text)))::text                                   AS "Enc.whether your blood sugar level is under control",
       programencounter.cancel_date_time                                                                             AS "EncCancel.cancel_date_time",
       (single_select_coded((programencounter.observations ->>
                             '5592def2-fe5e-4234-9253-ca5fd0322e26'::text)))::text                                   AS "EncCancel.Reason Of Cancellation",
       (programencounter.observations ->>
        '8263f129-5851-4f9d-a909-818dacacd862'::text)                                                                AS "EncCancel.Other Reason of Cancellation",
       row_number()
       OVER (PARTITION BY individual.id ORDER BY programencounter.encounter_date_time DESC)                          AS rank
FROM ((((((program_encounter programencounter
    LEFT JOIN operational_encounter_type oet ON ((programencounter.encounter_type_id = oet.encounter_type_id)))
    LEFT JOIN program_enrolment programenrolment ON ((programencounter.program_enrolment_id = programenrolment.id)))
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '4e3dc382-f14a-4a56-8ab8-e4cc4faca774'::text) AND
       ((oet.uuid)::text = '5defe5af-b031-4783-80d6-52d49aa66884'::text) AND
       (programencounter.encounter_date_time IS NOT NULL) AND (programenrolment.enrolment_date_time IS NOT NULL));

alter table yenepoya_hypertension_followup_view
    owner to yenepoya;




create view yenepoya_ncd_enrolment_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Program Name", "Enl.Id", "Enl.uuid", "Enl.is_voided", "Ind.Contact Number",
             "Enl.Smoking or consume smokeless products", "Enl.Alcohol consumption", "Enl.Height in CM", "Enl.Weight",
             "Enl.Mid arm circumference", "Enl.Waist circumference", "Enl.Abnormal waist circumference",
             "Enl.Waist circumference is normal", "Enl.Physical activity for >150 min/week",
             "Enl.Are you practicing any Yoga", "Enl.Family histroy of high BP, DM or heart disease",
             "Enl.Difficulty in opening mouth", "Enl.Ulcer/ patch/ growth in mouth that has not healed for 2 wee",
             "Enl.Whether change in the tone of voice", "Enl.Lump in the breast",
             "Enl.Blood stained discharge from nipple", "Enl.Change in shape and size of breast",
             "Enl.Bleeding between periods", "Enl.Bleeding after menopause", "Enl.Bleeding after intercourse",
             "Enl.Foul smelling vaginal discharge")
as
SELECT individual.id                                                                                                 AS "Ind.Id",
       individual.address_id                                                                                         AS "Ind.address_id",
       individual.uuid                                                                                               AS "Ind.uuid",
       individual.first_name                                                                                         AS "Ind.first_name",
       individual.last_name                                                                                          AS "Ind.last_name",
       g.name                                                                                                        AS "Ind.Gender",
       individual.date_of_birth                                                                                      AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                             AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                                  AS "Ind.registration_date",
       individual.facility_id                                                                                        AS "Ind.facility_id",
       a.title                                                                                                       AS "Ind.Area",
       individual.is_voided                                                                                          AS "Ind.is_voided",
       op.name                                                                                                       AS "Enl.Program Name",
       programenrolment.id                                                                                           AS "Enl.Id",
       programenrolment.uuid                                                                                         AS "Enl.uuid",
       programenrolment.is_voided                                                                                    AS "Enl.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                                AS "Ind.Contact Number",
       (single_select_coded((programenrolment.observations ->>
                             '0fc3b733-0ee0-4554-b316-e5e29c1978d2'::text)))::text                                   AS "Enl.Smoking or consume smokeless products",
       (single_select_coded((programenrolment.observations ->>
                             'ac4d5664-0b5f-467f-a3c9-c0e4c8c221b7'::text)))::text                                   AS "Enl.Alcohol consumption",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                                                AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                                                AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                                                AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                                                AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text                                   AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text                                   AS "Enl.Waist circumference is normal",
       (single_select_coded((programenrolment.observations ->>
                             'dfdc75c1-5a47-4aae-887c-3ee9f050d75e'::text)))::text                                   AS "Enl.Physical activity for >150 min/week",
       (single_select_coded((programenrolment.observations ->>
                             '3e092c91-8e32-42b1-ac26-045b846e3893'::text)))::text                                   AS "Enl.Are you practicing any Yoga",
       (single_select_coded((programenrolment.observations ->>
                             '8f67d53a-07bf-4652-b7ad-f2f6ef6bdfa2'::text)))::text                                   AS "Enl.Family histroy of high BP, DM or heart disease",
       (single_select_coded((programenrolment.observations ->>
                             '83f01615-04b1-4115-84a5-48e89c9aff54'::text)))::text                                   AS "Enl.Difficulty in opening mouth",
       (single_select_coded((programenrolment.observations ->>
                             '5e4d8a9d-28a5-49ec-a4c9-cd9cfd4dd134'::text)))::text                                   AS "Enl.Ulcer/ patch/ growth in mouth that has not healed for 2 wee",
       (single_select_coded((programenrolment.observations ->>
                             '89bf3601-d8ab-4353-85a3-8070a959394e'::text)))::text                                   AS "Enl.Whether change in the tone of voice",
       (single_select_coded((programenrolment.observations ->>
                             'd9f8ee0c-960f-43d7-9b02-aa2557a9aa10'::text)))::text                                   AS "Enl.Lump in the breast",
       (single_select_coded((programenrolment.observations ->>
                             '74745370-ee9e-4f58-b25e-57ebac69d75d'::text)))::text                                   AS "Enl.Blood stained discharge from nipple",
       (single_select_coded((programenrolment.observations ->>
                             '2da75202-7f70-4a76-a8eb-cd9b289cdf8a'::text)))::text                                   AS "Enl.Change in shape and size of breast",
       (single_select_coded((programenrolment.observations ->>
                             '45f02196-217b-4772-8085-3d17c41244da'::text)))::text                                   AS "Enl.Bleeding between periods",
       (single_select_coded((programenrolment.observations ->>
                             'd1774f83-ee28-41b8-9cb8-309098ee0f16'::text)))::text                                   AS "Enl.Bleeding after menopause",
       (single_select_coded((programenrolment.observations ->>
                             '82efa85a-46a9-4c75-8c53-c488b8c48c54'::text)))::text                                   AS "Enl.Bleeding after intercourse",
       (single_select_coded((programenrolment.observations ->>
                             '84a99b8c-f9bb-4436-9d83-d79a60a0b450'::text)))::text                                   AS "Enl.Foul smelling vaginal discharge"
FROM ((((program_enrolment programenrolment
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '85a36148-26a2-4a30-921c-5c1fc64e8acc'::text) AND
       (programenrolment.enrolment_date_time IS NOT NULL));

alter table yenepoya_ncd_enrolment_view
    owner to yenepoya;



create view yenepoya_ncd_followup_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Id", "Enc.Type", "Enc.Id", "Enc.earliest_visit_date_time", "Enc.encounter_date_time",
             "Enc.program_enrolment_id", "Enc.uuid", "Enc.name", "Enc.max_visit_date_time", "Enc.is_voided",
             "Enc.Smoking or consume smokeless products", "Enc.Alcohol consumption", "Enc.Height in CM", "Enc.Weight",
             "Enc.Mid arm circumference", "Enc.Waist circumference", "Enc.Physical activity for >150 min/week",
             "Enc.Are you practicing any Yoga", "Enc.Family histroy of high BP, DM or heart disease",
             "Enc.Difficulty in opening mouth", "Enc.Ulcer/ patch/ growth in mouth that has not healed for 2 wee",
             "Enc.Whether change in the tone of voice", "Enc.Lump in the breast",
             "Enc.Blood stained discharge from nipple", "Enc.Change in shape and size of breast",
             "Enc.Bleeding between periods", "Enc.Bleeding after menopause", "Enc.Bleeding after intercourse",
             "Enc.Foul smelling vaginal discharge", "EncCancel.cancel_date_time", "EncCancel.Reason Of Cancellation",
             "EncCancel.Other Reason of Cancellation", rank)
as
SELECT individual.id                                                                                                 AS "Ind.Id",
       individual.address_id                                                                                         AS "Ind.address_id",
       individual.uuid                                                                                               AS "Ind.uuid",
       individual.first_name                                                                                         AS "Ind.first_name",
       individual.last_name                                                                                          AS "Ind.last_name",
       g.name                                                                                                        AS "Ind.Gender",
       individual.date_of_birth                                                                                      AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                             AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                                  AS "Ind.registration_date",
       individual.facility_id                                                                                        AS "Ind.facility_id",
       a.title                                                                                                       AS "Ind.Area",
       individual.is_voided                                                                                          AS "Ind.is_voided",
       programenrolment.id                                                                                           AS "Enl.Id",
       oet.name                                                                                                      AS "Enc.Type",
       programencounter.id                                                                                           AS "Enc.Id",
       programencounter.earliest_visit_date_time                                                                     AS "Enc.earliest_visit_date_time",
       programencounter.encounter_date_time                                                                          AS "Enc.encounter_date_time",
       programencounter.program_enrolment_id                                                                         AS "Enc.program_enrolment_id",
       programencounter.uuid                                                                                         AS "Enc.uuid",
       programencounter.name                                                                                         AS "Enc.name",
       programencounter.max_visit_date_time                                                                          AS "Enc.max_visit_date_time",
       programencounter.is_voided                                                                                    AS "Enc.is_voided",
       (single_select_coded((programencounter.observations ->>
                             '0fc3b733-0ee0-4554-b316-e5e29c1978d2'::text)))::text                                   AS "Enc.Smoking or consume smokeless products",
       (single_select_coded((programencounter.observations ->>
                             'ac4d5664-0b5f-467f-a3c9-c0e4c8c221b7'::text)))::text                                   AS "Enc.Alcohol consumption",
       (programencounter.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                                                AS "Enc.Height in CM",
       (programencounter.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                                                AS "Enc.Weight",
       (programencounter.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                                                AS "Enc.Mid arm circumference",
       (programencounter.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                                                AS "Enc.Waist circumference",
       (single_select_coded((programencounter.observations ->>
                             'dfdc75c1-5a47-4aae-887c-3ee9f050d75e'::text)))::text                                   AS "Enc.Physical activity for >150 min/week",
       (single_select_coded((programencounter.observations ->>
                             '3e092c91-8e32-42b1-ac26-045b846e3893'::text)))::text                                   AS "Enc.Are you practicing any Yoga",
       (single_select_coded((programencounter.observations ->>
                             '8f67d53a-07bf-4652-b7ad-f2f6ef6bdfa2'::text)))::text                                   AS "Enc.Family histroy of high BP, DM or heart disease",
       (single_select_coded((programencounter.observations ->>
                             '83f01615-04b1-4115-84a5-48e89c9aff54'::text)))::text                                   AS "Enc.Difficulty in opening mouth",
       (single_select_coded((programencounter.observations ->>
                             '5e4d8a9d-28a5-49ec-a4c9-cd9cfd4dd134'::text)))::text                                   AS "Enc.Ulcer/ patch/ growth in mouth that has not healed for 2 wee",
       (single_select_coded((programencounter.observations ->>
                             '89bf3601-d8ab-4353-85a3-8070a959394e'::text)))::text                                   AS "Enc.Whether change in the tone of voice",
       (single_select_coded((programencounter.observations ->>
                             'd9f8ee0c-960f-43d7-9b02-aa2557a9aa10'::text)))::text                                   AS "Enc.Lump in the breast",
       (single_select_coded((programencounter.observations ->>
                             '74745370-ee9e-4f58-b25e-57ebac69d75d'::text)))::text                                   AS "Enc.Blood stained discharge from nipple",
       (single_select_coded((programencounter.observations ->>
                             '2da75202-7f70-4a76-a8eb-cd9b289cdf8a'::text)))::text                                   AS "Enc.Change in shape and size of breast",
       (single_select_coded((programencounter.observations ->>
                             '45f02196-217b-4772-8085-3d17c41244da'::text)))::text                                   AS "Enc.Bleeding between periods",
       (single_select_coded((programencounter.observations ->>
                             'd1774f83-ee28-41b8-9cb8-309098ee0f16'::text)))::text                                   AS "Enc.Bleeding after menopause",
       (single_select_coded((programencounter.observations ->>
                             '82efa85a-46a9-4c75-8c53-c488b8c48c54'::text)))::text                                   AS "Enc.Bleeding after intercourse",
       (single_select_coded((programencounter.observations ->>
                             '84a99b8c-f9bb-4436-9d83-d79a60a0b450'::text)))::text                                   AS "Enc.Foul smelling vaginal discharge",
       programencounter.cancel_date_time                                                                             AS "EncCancel.cancel_date_time",
       (single_select_coded((programencounter.observations ->>
                             '5592def2-fe5e-4234-9253-ca5fd0322e26'::text)))::text                                   AS "EncCancel.Reason Of Cancellation",
       (programencounter.observations ->>
        '8263f129-5851-4f9d-a909-818dacacd862'::text)                                                                AS "EncCancel.Other Reason of Cancellation",
       row_number()
       OVER (PARTITION BY individual.id ORDER BY programencounter.encounter_date_time DESC)                          AS rank
FROM ((((((program_encounter programencounter
    LEFT JOIN operational_encounter_type oet ON ((programencounter.encounter_type_id = oet.encounter_type_id)))
    LEFT JOIN program_enrolment programenrolment ON ((programencounter.program_enrolment_id = programenrolment.id)))
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '85a36148-26a2-4a30-921c-5c1fc64e8acc'::text) AND
       ((oet.uuid)::text = 'b0d16b85-218c-4392-999c-4fa19476cf42'::text) AND
       (programencounter.encounter_date_time IS NOT NULL) AND (programenrolment.enrolment_date_time IS NOT NULL));

alter table yenepoya_ncd_followup_view
    owner to yenepoya;

