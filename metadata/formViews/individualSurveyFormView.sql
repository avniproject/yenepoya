
create view yenepoya_individual_survey_form
            ("Ind.Id",
             "Ind.address_id",
             "Ind.uuid",
             "Ind.first_name",
             "Ind.last_name",
             "Ind.Gender",
             "Ind.date_of_birth",
             "Ind.date_of_birth_verified",
             "Ind.registration_date",
             "Ind.facility_id",
             "Ind.Area",
             "Ind.is_voided",
             "Ind.Contact Number",
             "Ind.Household number",
             "Enc.uuid",
             "Enc.name",
             "Enc.Encounter_ID",
             "Enc.earliest_visit_date_time",
             "Enc.encounter_date_time",
             "Enc.max_visit_date_time",
             "Enc.Encounter_type_Id",
             "Enc.is_voided",
             "Enc.Individual_id",
             "Enc.Cancel_date_time",
             "Enc.Educational status",
             "Enc.Specify Other educational status",
             "Enc.Occupational status",
             "Enc.Relationship with HoF",
             "Enc.Marital status",
             "Enc.Are you a known case of any chronic illness?",
             "Enc.Specify  known case of chronic illness",
             "Enc.whether you had any illness in last two weeks?",
             "Enc.Specify illness in last two weeks",
             "Enc.Do you have any disability?",
             "Enc.Specify Other disabilities",
             "Enc.Are you a eligible couple?",
             "Enc.Family planning methods practices",
             "Enc.Are you pregnant?",
             "Enc.Weeks of pregnancy",
             "Enc.Are you postnatal mother?",
             "Enc.How many days/weeks?",
             "Enc.Current Status of the individual",
             "Enc.History of fever in last 15 days",
             "Enc.Anyone in the family currently suffering from TB?",
             "Enc.Are you currently taking anti TB treatment?",
             "Enc.Have you suffered from TB in the last 5 years?",
             "Enc.Cough for > 2 weeks duration",
             "Enc.Fever for > 2 weeks duration",
             "Enc.Blood in sputum",
             "Enc.Significant weight loss (>5 kgs in last 3 months)",
             "Enc.Night sweats",
             "Enc.Shortness of breath",
             "Enc.History of fits",
             "Enc.History of flu like symptoms in last 6 weeks",
             "Enc.If you have flu like illness then have you consulted any doctor?",
             "rank")
as


SELECT individual.id                                                                          as "Ind.Id",
       individual.address_id                                                                  as "Ind.address_id",
       individual.uuid                                                                        as "Ind.uuid",
       individual.first_name                                                                  as "Ind.first_name",
       individual.last_name                                                                   as "Ind.last_name",
       g.name                                                                                 as "Ind.Gender",
       individual.date_of_birth                                                               as "Ind.date_of_birth",
       individual.date_of_birth_verified                                                      as "Ind.date_of_birth_verified",
       individual.registration_date                                                           as "Ind.registration_date",
       individual.facility_id                                                                 as "Ind.facility_id",
       a.title                                                                                as "Ind.Area",
       individual.is_voided                                                                   as "Ind.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT             as "Ind.Contact Number",
       (individual.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab')::TEXT             as "Ind.Household number",
       enc.uuid                                                                               as "Enc.uuid",
       enc.name                                                                               as "Enc.name",
       enc.id                                                                                 as "Enc.Encounter_ID",
       enc.earliest_visit_date_time                                                           as "Enc.earliest_visit_date_time",
       enc.encounter_date_time                                                                as "Enc.encounter_date_time",
       enc.max_visit_date_time                                                                as "Enc.max_visit_date_time",
       enc.encounter_type_id                                                                  as "Enc.Encounter_type_Id",
       enc.is_voided                                                                          as "Enc.is_voided",
       enc.individual_id                                                                      as "Enc.Individual_id",
       enc.cancel_date_time                                                                   as "Enc.Cancel_date_time",
       single_select_coded(
                   enc.observations ->> 'a6a6d4c0-4339-4ef0-b152-6d1c23eaf7c2')::text             as "Enc.Educational status",
       (enc.observations ->> 'a44678fd-ee6d-4dc5-b103-f5534eb0f338')::text                    as "Enc.Specify Other educational status",
       single_select_coded(
                   enc.observations ->> 'ab095140-b090-4f59-98ac-89b6479df471')::text             as "Enc.Occupational status",
       single_select_coded(
                   enc.observations ->> '6515f6f3-6174-4977-a3b1-29d8f0d0f080')::text             as "Enc.Relationship with HoF",
       single_select_coded(enc.observations ->> 'ca9eab9a-da29-4775-b08b-029998c817d0')::text as "Enc.Marital status",
       multi_select_coded(
                   enc.observations -> '1f51e7f7-6db0-41ea-a372-e7b553ccb857')::text              as "Enc.Are you a known case of any chronic illness?",
       (enc.observations ->> 'caa23e49-901e-43ac-a246-33a16e83493a')::text                    as "Enc.Specify  known case of chronic illness",
       multi_select_coded(
                   enc.observations -> '11713bd0-3ce6-4e0a-b65d-4f86f03a16db')::text              as "Enc.whether you had any illness in last two weeks?",
       (enc.observations ->> '9b12024d-08e0-486b-b4b9-ddc21b6f199d')::text                    as "Enc.Specify illness in last two weeks",
       single_select_coded(
                   enc.observations ->> '6c4b205c-c1d8-4c15-abbf-dc983765ed00')::text             as "Enc.Do you have any disability?",
       (enc.observations ->> '92d215ef-06a6-4991-9f9b-f989c1488919')::text                    as "Enc.Specify Other disabilities",
       single_select_coded(
                   enc.observations ->> 'ac7f30a6-066b-4b15-b18f-9ccd4646fb7a')::text             as "Enc.Are you a eligible couple?",
       single_select_coded(
                   enc.observations ->> '59dcf8c7-c11a-4cf7-acb0-d91ebca4bda2')::text             as "Enc.Family planning methods practices",
       single_select_coded(
                   enc.observations ->> '4986aa3a-1afd-43ae-9080-a74521433e22')::text             as "Enc.Are you pregnant?",
       (enc.observations ->> 'dccc664e-aa4d-421b-854a-84de70a528c4')::text                    as "Enc.Weeks of pregnancy",
       single_select_coded(
                   enc.observations ->> 'df999329-6353-42ad-a5d5-a5ee42d58023')::text             as "Enc.Are you postnatal mother?",
       (enc.observations ->> '16008929-a77d-450f-a8f9-b052228bde65')::text                    as "Enc.How many days/weeks?",
       single_select_coded(
                   enc.observations ->> '0c1b1cdc-93f5-40ae-a609-e5e5fb6c70e9')::text             as "Enc.Current Status of the individual",
       single_select_coded(
                   enc.observations ->> '59d2e12f-1d6d-4fac-9d9a-cae3ca021269')::text             as "Enc.History of fever in last 15 days",
       single_select_coded(
                   enc.observations ->> '49b0721f-74a7-49f9-9ad7-224d1b177888')::text             as "Enc.Anyone in the family currently suffering from TB?",
       single_select_coded(
                   enc.observations ->> '86a71b99-0c10-493d-ad97-656ac55c0401')::text             as "Enc.Are you currently taking anti TB treatment?",
       single_select_coded(
                   enc.observations ->> '1df01bab-167a-4d80-b266-0bd13be7755a')::text             as "Enc.Have you suffered from TB in the last 5 years?",
       single_select_coded(
                   enc.observations ->> 'c8c1517c-4bf7-4819-acb6-a134cd4a1f45')::text             as "Enc.Cough for > 2 weeks duration",
       single_select_coded(
                   enc.observations ->> '96aad817-132f-4d60-beb3-c3b51224187a')::text             as "Enc.Fever for > 2 weeks duration",
       single_select_coded(enc.observations ->> '276908b7-c533-4026-93d9-6fa4bfc3c349')::text as "Enc.Blood in sputum",
       single_select_coded(
                   enc.observations ->> '56bd61e4-48e4-4094-8337-4fcfc89d7910')::text             as "Enc.Significant weight loss (>5 kgs in last 3 months)",
       single_select_coded(enc.observations ->> '41e1e731-c438-4fec-aab2-32d9690f8a7b')::text as "Enc.Night sweats",
       single_select_coded(
                   enc.observations ->> '61224d6c-711a-47b8-a757-656b8e55400d')::text             as "Enc.Shortness of breath",
       single_select_coded(enc.observations ->> '68ca9b7e-76e4-4b55-8324-18e28cac8e83')::text as "Enc.History of fits",
       multi_select_coded(
                   enc.observations -> '13a1a45c-c32e-4bcf-804e-dc2915a00a8f')::text              as "Enc.History of flu like symptoms in last 6 weeks",
       single_select_coded(
                   enc.observations ->> '814af782-b235-4c50-a7c6-6a40398f1a0e')::text             as "Enc.If you have flu like illness then have you consulted any doctor?",

       row_number() OVER (PARTITION BY enc.individual_id
           ORDER BY enc.encounter_date_time desc)                                             as "rank"
FROM individual individual
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
         right JOIN encounter enc on individual.id = enc.individual_id and enc.name = 'Individual Survey'
where subject_type_id = (select id from subject_type where name = 'Individual')
  and enc.encounter_date_time notnull
;