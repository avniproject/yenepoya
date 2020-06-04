set role yenepoya;

create view yenepoya_household_survey_view as (
    SELECT individual.id                                                                        "Ind.Id",
           individual.address_id                                                                "Ind.address_id",
           individual.uuid                                                                      "Ind.uuid",
           individual.first_name                                                                "Ind.first_name",
           individual.last_name                                                                 "Ind.last_name",
           g.name                                                                               "Ind.Gender",
           individual.date_of_birth                                                             "Ind.date_of_birth",
           individual.date_of_birth_verified                                                    "Ind.date_of_birth_verified",
           individual.registration_date                                                         "Ind.registration_date",
           individual.facility_id                                                               "Ind.facility_id",
           a.title                                                                              "Ind.Area",
           individual.is_voided                                                                 "Ind.is_voided",
           oet.name                                                                             "Enc.Type",
           encounter.id                                                                         "Enc.Id",
           encounter.earliest_visit_date_time                                                   "Enc.earliest_visit_date_time",
           encounter.encounter_date_time                                                        "Enc.encounter_date_time",
           encounter.uuid                                                                       "Enc.uuid",
           encounter.name                                                                       "Enc.name",
           encounter.max_visit_date_time                                                        "Enc.max_visit_date_time",
           encounter.is_voided                                                                  "Enc.is_voided",
           single_select_coded(
                   individual.observations ->> '1de1bfa2-030a-4ccb-8381-ee5105048fa2')::TEXT as "Ind.Name of the surveillance Unit",
           single_select_coded(
                   individual.observations ->> '673a87ab-78cd-42a3-a6cf-47761c8beffe')::TEXT as "Ind.Name of the panchayat/Ward",
           (individual.observations ->> 'ef182a85-8f38-418e-bf0e-fcf2c3c655f0')::TEXT        as "Ind.landmark",
           single_select_coded(
                   individual.observations ->> '1948be58-d42e-4313-8ec5-ac9ca87eb399')::TEXT as "Ind.Name of the PHC/UPHC",
           (individual.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT        as "Ind.Specify Other",
           (individual.observations ->> 'e9ce5187-db1e-40cf-ad42-4b1c27d553f8')::TEXT        as "Ind.Name of the sub centre",
           (individual.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab')::TEXT        as "Ind.Household number",
           (individual.observations ->> '6633afc7-d0e4-4427-87d4-277d8942ff48')::TEXT        as "Ind.Name of the head of the family",
           single_select_coded(
                   individual.observations ->> '83fbfa4c-164e-4eb2-b207-d9263c1b3b4d')::TEXT as "Ind.Gender of HoF",
           single_select_coded(
                   individual.observations ->> '52a8b9a2-499b-4362-a95f-4df018cd644a')::TEXT as "Ind.Type of family",
           (individual.observations ->> '752cf346-243e-447a-a973-53891cb110b0')::TEXT        as "Ind.Total Income",
           (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT        as "Ind.Contact Number",
           single_select_coded(
                   individual.observations ->> '57251d49-3cfb-4e49-a053-7364a663bf1d')::TEXT as "Ind.Mother Tongue",
           (individual.observations ->> 'f2058089-18f8-4442-84cf-94cf1cea28a6')::TEXT        as "Ind.Other mother tongue",
           single_select_coded(
                   individual.observations ->> '60320b20-433d-4167-84e2-5cea3351739f')::TEXT as "Ind.Which religion do you practice?",
           single_select_coded(
                   individual.observations ->> '26024a7b-b664-4eef-90e4-1fe23283378f')::TEXT as "Ind.You belong to which social class?",
           (individual.observations ->> '81323643-274c-4831-9d1a-a17e2dfcd225')::TEXT        as "Ind.Other social class",
           single_select_coded(
                   individual.observations ->> '2253872c-c629-4f6f-96bc-72ba23892290')::TEXT as "Ind.Are you resident of this area for more than 1 year",
           single_select_coded(
                   individual.observations ->> '49344ffb-d10c-4e30-a284-356396970bcf')::TEXT as "Ind.Type of Ration card",
           (encounter.observations ->> '25723471-1596-4786-a390-79a687e9c61b')::TEXT         as "Enc.Age of HoF",
           single_select_coded(
                   encounter.observations ->> 'be84eb6c-fe84-457b-b2f7-f512b6961125')::TEXT  as "Enc.Marrital status of hoF",
           (encounter.observations ->> '0bd4084c-11cb-4a30-84aa-c4cf5b2926d1')::TEXT         as "Enc.Number of individuals in the household",
           multi_select_coded(
                   encounter.observations -> 'c5c9d1b4-54f8-4676-ba39-18d9a5f3c7a3')::TEXT   as "Enc.Are there members with known case of chronic illness?",
           (encounter.observations ->> 'caa23e49-901e-43ac-a246-33a16e83493a')::TEXT         as "Enc.Specify  known case of chronic illness",
           multi_select_coded(
                   encounter.observations -> '0b5215d5-f721-4993-8f30-b85f5b397988')::TEXT   as "Enc.Are there members with any illness in last two weeks?",
           (encounter.observations ->> '9b12024d-08e0-486b-b4b9-ddc21b6f199d')::TEXT         as "Enc.Specify illness in last two weeks",
           single_select_coded(
                   encounter.observations ->> '2a1c24fd-912a-485d-bf8e-5a722d8ab5a1')::TEXT  as "Enc.Any member in your family with some disability",
           (encounter.observations ->> '71124244-b1e2-42a7-82b3-15b79524352e')::TEXT         as "Enc.If Yes give details about disability",
           (encounter.observations ->> '00edb1c7-acda-4982-a414-0ea121f616bf')::TEXT         as "Enc.Household Total Expenditure per month",
           single_select_coded(
                   encounter.observations ->> '0cff16cb-8018-4908-aecc-9d6410b797d1')::TEXT  as "Enc.Out-of-pocket payments exceeding 10% of household total",
           (encounter.observations ->> 'd3031e04-7ad0-4075-b465-1f75678177aa')::TEXT         as "Enc.How many rooms in this household is used for sleeping?",
           single_select_coded(
                   encounter.observations ->> 'a69677d2-d3e8-4458-8d21-0936bc9a510d')::TEXT  as "Enc.Separate Kitchen",
           single_select_coded(
                   encounter.observations ->> '4c9e7144-8e05-4b64-8d00-b769f5e23cf3')::TEXT  as "Enc.Type of fuel",
           (encounter.observations ->> '14c847cd-ba22-49cd-8d2e-8e4e99ec9dbd')::TEXT         as "Enc.Specify fuel",
           single_select_coded(
                   encounter.observations ->> '9d6ca8db-4d5b-42ee-8ba3-a153a91bf0e8')::TEXT  as "Enc.Any nuisance  reported by family member",
           multi_select_coded(
                   encounter.observations -> '225531c0-df1c-4ac2-8a24-c20d38b2b124')::TEXT   as "Enc.Type of potential breeding sites present",
           (encounter.observations ->> '52f3f9b2-dab9-46fc-8b66-776f34a9fd58')::TEXT         as "Enc.Specify breeding sites present",
           single_select_coded(
                   encounter.observations ->> '8f4baf0b-02f8-4bfc-adb7-996355c46cf4')::TEXT  as "Enc.Are you using any insecticide treated bed nets?",
           single_select_coded(
                   encounter.observations ->> '65552252-53a2-4846-ac6f-60e06dd7dacf')::TEXT  as "Enc.Segregation of waste at source (wet and dry waste)",
           single_select_coded(
                   encounter.observations ->> 'eaf15d71-4654-4efc-ba1f-28d5e365bb1a')::TEXT  as "Enc.Most common household waste disposal method",
           single_select_coded(
                   encounter.observations ->> 'cfa00c40-3c1a-4f98-9c34-f2f5e13f229b')::TEXT  as "Enc.Is there a latrine in your house?",
           single_select_coded(
                   encounter.observations ->> 'd21f3a62-2cd9-4f34-9797-978a1ce6fbf0')::TEXT  as "Enc.Who has constructed the latrine?",
           single_select_coded(
                   encounter.observations ->> '09acf590-7148-4ec1-b5a0-3ab34309d153')::TEXT  as "Enc.Is open air defecation practiced by family member",
           single_select_coded(
                   encounter.observations ->> '2c11d1e4-072c-40a2-8a68-24855f7d4027')::TEXT  as "Enc.what type of drainage facility does your household have?",
           multi_select_coded(
                   encounter.observations -> '36ab6284-c3ca-4de8-8593-eba915a03791')::TEXT   as "Enc.Source of water (Domestic use)",
           (encounter.observations ->> '78c763af-bced-49aa-813a-66a19dde3ebb')::TEXT         as "Enc.Specify source of water",
           multi_select_coded(
                   encounter.observations -> 'f3250681-0a1e-4e7a-9654-d15b24b0d78c')::TEXT   as "Enc.Source of drinking water?",
           (encounter.observations ->> '5f3931f3-fd5e-4666-b1e2-01db24684fb6')::TEXT         as "Enc.Specify source of drinking water",
           single_select_coded(
                   encounter.observations ->> '2ee24106-43f2-4b2f-9ff7-75080851bed3')::TEXT  as "Enc.Whether panchayt/corporation provide chlorinated water?",
           single_select_coded(
                   encounter.observations ->> '7ba3b46e-d9f7-4f91-b38d-a587a4686951')::TEXT  as "Enc.Domestic purification methods used",
           single_select_coded(
                   encounter.observations ->> 'b40f407f-b68e-44fe-b641-86ab8b7ab51d')::TEXT  as "Enc.Regularity of water supply",
           single_select_coded(
                   encounter.observations ->> 'db05dadf-5955-4d5d-a62d-b7f7a1ecf6ce')::TEXT  as "Enc.Health facility preferred for chronic illness",
           multi_select_coded(
                   encounter.observations -> '84b9db51-33ce-4da0-a5cc-5ea2058f95ad')::TEXT   as "Enc.Name the health facility preferred for chronic illness",
           (encounter.observations ->> '54a36cb8-a7a0-415d-84c7-2ca4b88e8f87')::TEXT         as "Enc.Specify the health facility preferred for chronic illness",
           single_select_coded(
                   encounter.observations ->> 'da29256e-720c-4071-a8f4-9e563749aef1')::TEXT  as "Enc.Health facility preferred for acute illness",
           multi_select_coded(
                   encounter.observations -> '84a7b976-1730-479f-926a-dcdaac00b876')::TEXT   as "Enc.Name the Health facility preferred for acute illness",
           (encounter.observations ->> '1a436a53-b279-49b1-87b4-efad33a34a4d')::TEXT         as "Enc.Specify other acute illness",
           multi_select_coded(
                   encounter.observations -> '5987c751-0e34-4e76-aa1a-95b31d7af765')::TEXT   as "Enc.Reason of visiting preferred health care facility",
           (encounter.observations ->> '4239ddc6-60cc-4ac0-ad7d-3d35bf2caace')::TEXT         as "Enc.Specify Reason of visiting preferred health care facility",
           single_select_coded(
                   encounter.observations ->> '67c33f11-2358-4360-8b86-65633232c773')::TEXT  as "Enc.If member having mental illness,is availing health services",
           single_select_coded(
                   encounter.observations ->> '5b99afca-55eb-4793-824b-361d94d5c3d7')::TEXT  as "Enc.Are you availing any social security schemes",
           multi_select_coded(
                   encounter.observations -> 'a7815743-9b97-4631-9df7-a5a982ca3b2a')::TEXT   as "Enc.Name the  social security scheme",
           (encounter.observations ->> '003d18b4-2f1f-4fa8-97fd-5049c83eb1f0')::TEXT         as "Enc.Specify social security scheme",
           multi_select_coded(
                   encounter.observations -> '19df1265-d795-4f29-94a9-422f1bef645b')::TEXT   as "Enc.Transport facility",
           multi_select_coded(
                   encounter.observations -> 'ed7fa0bb-ba46-4a2f-bf3e-4005ea4c046c')::TEXT   as "Enc.Electronic gadgets",
           multi_select_coded(
                   encounter.observations -> '00177962-6242-48e0-8bf7-9bc879bdb976')::TEXT   as "Enc.Do you have any of these facilities",
           multi_select_coded(
                   encounter.observations -> 'eb52fe79-3b96-4b3f-8bc6-ddda16746eed')::TEXT   as "Enc.Any vital events",
           single_select_coded(
                   encounter.observations ->> '2457b432-21ab-4636-8551-b4682c51bb40')::TEXT  as "Enc.Any member of your family working abroad?",
           (encounter.observations ->> 'f0a15451-6e52-4d2d-b893-0f74ec662560')::TEXT         as "Enc.Provide name and place of work",
           encounter.cancel_date_time                                                           "EncCancel.cancel_date_time",
           (encounter.observations ->> '20460001-db72-4052-9168-9861a40df088')::DATE         as "EncCancel.Date of Cancel",
           single_select_coded(
                   encounter.observations ->> '46182e50-6b63-4588-a8c8-8d0288ce2477')::TEXT  as "EncCancel.Reason Of Cancellation survey",
           (encounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862')::TEXT         as "EncCancel.Other Reason of Cancellation"
    FROM encounter encounter
             JOIN operational_encounter_type oet on encounter.encounter_type_id = oet.encounter_type_id
             JOIN individual individual ON encounter.individual_id = individual.id
             JOIN gender g ON g.id = individual.gender_id
             JOIN address_level a ON individual.address_id = a.id
    WHERE oet.uuid = '767e7ef2-4a45-4c17-9939-773f97c0baf0'
      AND encounter.encounter_date_time IS NOT NULL
);


drop view if exists yenepoya_individual_survey_view;
create view yenepoya_individual_survey_view as
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
       village.title                                                                          as "Ind.village",
       panchayat.title                                                                        as "Ind.panchayat",
       surveillance_unit.title                                                                as "Ind.surveillance_unit",
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
               enc.observations ->> '814af782-b235-4c50-a7c6-6a40398f1a0e')::text             as "Enc.If you have flu like illness then have you consulted any doctor?"
FROM individual individual
         JOIN gender g ON g.id = individual.gender_id
         JOIN encounter enc on individual.id = enc.individual_id
         join address_level village on individual.address_id = village.id
         join address_level panchayat on village.parent_id = panchayat.id
         join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
where subject_type_id = (select id from subject_type where name = 'Individual')
  and enc.name = 'Individual Survey'
  and enc.encounter_date_time notnull;


drop view if exists yenepoya_individual_registration_view;
create view yenepoya_individual_registration_view as
SELECT individual.id                                                              AS "Ind.Id",
       individual.address_id                                                      AS "Ind.address_id",
       individual.uuid                                                            AS "Ind.uuid",
       individual.first_name                                                      AS "Ind.first_name",
       individual.last_name                                                       AS "Ind.last_name",
       g.name                                                                     AS "Ind.Gender",
       village.title                                                              as "Ind.village",
       panchayat.title                                                            as "Ind.panchayat",
       surveillance_unit.title                                                    as "Ind.surveillance_unit",
       individual.date_of_birth                                                   AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                          AS "Ind.date_of_birth_verified",
       individual.registration_date                                               AS "Ind.registration_date",
       individual.facility_id                                                     AS "Ind.facility_id",
       a.title                                                                    AS "Ind.Area",
       individual.is_voided                                                       AS "Ind.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text) AS "Ind.Contact Number",
       (individual.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab'::text) AS "Ind.Household number"
FROM individual individual
         join gender g ON g.id = individual.gender_id
         join address_level a ON individual.address_id = a.id
         join address_level village on individual.address_id = village.id
         join address_level panchayat on village.parent_id = panchayat.id
         join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
WHERE (individual.subject_type_id = (SELECT subject_type.id
                                     FROM subject_type
                                     WHERE ((subject_type.name)::text = 'Individual'::text)));


set role none;
