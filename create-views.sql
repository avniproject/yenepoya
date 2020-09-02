set role yenepoya;

drop view if exists yenepoya_household_registration;
create view yenepoya_household_registration as
SELECT individual.id                                                               AS "Ind.Id",
       individual.address_id                                                       AS "Ind.address_id",
       individual.uuid                                                             AS "Ind.uuid",
       individual.first_name                                                       AS "Ind.first_name",
       individual.last_name                                                        AS "Ind.last_name",
       null                                                                        AS "Ind.Gender",
       individual.date_of_birth                                                    AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                           AS "Ind.date_of_birth_verified",
       individual.registration_date                                                AS "Ind.registration_date",
       individual.facility_id                                                      AS "Ind.facility_id",
       village.title                                                               as "Ind.village",
       panchayat.title                                                             as "Ind.panchayat",
       surveillance_unit.title                                                     as "Ind.surveillance_unit",
       individual.is_voided                                                        AS "Ind.is_voided",
       individual.registration_location                                               "Ind.registration_location",
       (single_select_coded((individual.observations ->>
                             '1de1bfa2-030a-4ccb-8381-ee5105048fa2'::text)))::text AS "Ind.Name of the surveillance Unit",
       (single_select_coded((individual.observations ->>
                             '673a87ab-78cd-42a3-a6cf-47761c8beffe'::text)))::text AS "Ind.Name of the panchayat/Ward",
       (individual.observations ->>
        'ef182a85-8f38-418e-bf0e-fcf2c3c655f0'::text)                              AS "Ind.landmark",
       (single_select_coded((individual.observations ->>
                             '1948be58-d42e-4313-8ec5-ac9ca87eb399'::text)))::text AS "Ind.Name of the PHC/UPHC",
       (individual.observations ->>
        '7868f697-abc9-4f49-8a0d-3deab5679502'::text)                              AS "Ind.Specify Other",
       (individual.observations ->>
        'e9ce5187-db1e-40cf-ad42-4b1c27d553f8'::text)                              AS "Ind.Name of the sub centre",
       (individual.observations ->>
        '558469e8-d993-45ec-9d9b-f019c3642bab'::text)                              AS "Ind.Household number",
       (individual.observations ->>
        '6633afc7-d0e4-4427-87d4-277d8942ff48'::text)                              AS "Ind.Name of the head of the family",
       (single_select_coded((individual.observations ->>
                             '83fbfa4c-164e-4eb2-b207-d9263c1b3b4d'::text)))::text AS "Ind.Gender of HoF",
       (single_select_coded((individual.observations ->>
                             '52a8b9a2-499b-4362-a95f-4df018cd644a'::text)))::text AS "Ind.Type of family",
       (individual.observations ->>
        '752cf346-243e-447a-a973-53891cb110b0'::text)                              AS "Ind.Total Income",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                              AS "Ind.Contact Number",
       (single_select_coded((individual.observations ->>
                             '57251d49-3cfb-4e49-a053-7364a663bf1d'::text)))::text AS "Ind.Mother Tongue",
       (individual.observations ->>
        'f2058089-18f8-4442-84cf-94cf1cea28a6'::text)                              AS "Ind.Other mother tongue",
       (single_select_coded((individual.observations ->>
                             '60320b20-433d-4167-84e2-5cea3351739f'::text)))::text AS "Ind.Which religion do you practice?",
       (single_select_coded((individual.observations ->>
                             '26024a7b-b664-4eef-90e4-1fe23283378f'::text)))::text AS "Ind.You belong to which social class?",
       (individual.observations ->>
        '81323643-274c-4831-9d1a-a17e2dfcd225'::text)                              AS "Ind.Other social class",
       (single_select_coded((individual.observations ->>
                             '2253872c-c629-4f6f-96bc-72ba23892290'::text)))::text AS "Ind.Are you resident of this area for more than 1 year",
       (single_select_coded((individual.observations ->>
                             '49344ffb-d10c-4e30-a284-356396970bcf'::text)))::text AS "Ind.Type of Ration card"
FROM individual individual
         left join address_level village on individual.address_id = village.id
         left join address_level panchayat on village.parent_id = panchayat.id
         left join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
WHERE (individual.subject_type_id = (SELECT subject_type.id
                                     FROM subject_type
                                     WHERE ((subject_type.name)::text = 'Household'::text)));

drop view if exists yenepoya_household_survey_view;
create view yenepoya_household_survey_view as (
    SELECT individual.id                                                                        "Ind.Id",
           individual.address_id                                                                "Ind.address_id",
           individual.uuid                                                                      "Ind.uuid",
           individual.first_name                                                                "Ind.first_name",
           individual.last_name                                                                 "Ind.last_name",
           individual.date_of_birth                                                             "Ind.date_of_birth",
           individual.date_of_birth_verified                                                    "Ind.date_of_birth_verified",
           individual.registration_date                                                         "Ind.registration_date",
           individual.facility_id                                                               "Ind.facility_id",
           village.title                                                                        "Ind.village",
           panchayat.title                                                                      "Ind.panchayat",
           surveillance_unit.title                                                              "Ind.surveillance_unit",
           individual.is_voided                                                                 "Ind.is_voided",
           individual.registration_location                                                     "Ind.registration_location",
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
           multi_select_coded(encounter.observations->'84b9db51-33ce-4da0-a5cc-5ea2058f95ad')::TEXT as "Enc.Name the governemnt health facility preferred for chronic illness",
           (encounter.observations ->> '54a36cb8-a7a0-415d-84c7-2ca4b88e8f87')::TEXT         as "Enc.Specify the health facility preferred for chronic illness",
           single_select_coded(
                   encounter.observations ->> 'da29256e-720c-4071-a8f4-9e563749aef1')::TEXT  as "Enc.Health facility preferred for acute illness",
           multi_select_coded(
                   encounter.observations -> '84a7b976-1730-479f-926a-dcdaac00b876')::TEXT   as "Enc.Name the Health facility preferred for acute illness",
           multi_select_coded(encounter.observations->'84a7b976-1730-479f-926a-dcdaac00b876')::TEXT as "Enc.Name the Private Health facility preferred for acute illness",
           multi_select_coded(encounter.observations->'3f04d17c-5652-452b-914f-77558049a306')::TEXT as "Enc.Name the Private health facility preferred for chronic illness",
           multi_select_coded(encounter.observations->'1d086e41-f08c-45a0-939c-6990f937370f')::TEXT as "Enc.Name the government Health facility preferred for acute illness",
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
             LEFT JOIN address_level village on individual.address_id = village.id
             LEFT JOIN address_level panchayat on village.parent_id = panchayat.id
             LEFT JOIN address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
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
       individual.registration_location                                                          "Ind.registration_location",
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
       row_number()
       OVER (PARTITION BY individual.id ORDER BY enc.encounter_date_time desc)                as survey_visit_number
FROM individual individual
         JOIN gender g ON g.id = individual.gender_id
         JOIN encounter enc on individual.id = enc.individual_id
         LEFT join address_level village on individual.address_id = village.id
         LEFT join address_level panchayat on village.parent_id = panchayat.id
         LEFT join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
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
       individual.is_voided                                                       AS "Ind.is_voided",
       individual.registration_location                                              "Ind.registration_location",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text) AS "Ind.Contact Number",
       (individual.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab'::text) AS "Ind.Household number"
FROM individual individual
         join gender g ON g.id = individual.gender_id
         left join address_level village on individual.address_id = village.id
         left join address_level panchayat on village.parent_id = panchayat.id
         left join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
WHERE (individual.subject_type_id = (SELECT subject_type.id
                                     FROM subject_type
                                     WHERE ((subject_type.name)::text = 'Individual'::text)));

drop view if exists yenepoya_diabetes_enrolment_view;
create view yenepoya_diabetes_enrolment_view
as
SELECT individual.id                                                               AS "Ind.Id",
       individual.address_id                                                       AS "Ind.address_id",
       individual.uuid                                                             AS "Ind.uuid",
       individual.first_name                                                       AS "Ind.first_name",
       individual.last_name                                                        AS "Ind.last_name",
       g.name                                                                      AS "Ind.Gender",
       individual.date_of_birth                                                    AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                           AS "Ind.date_of_birth_verified",
       individual.registration_date                                                AS "Ind.registration_date",
       individual.facility_id                                                      AS "Ind.facility_id",
       a.title                                                                     AS "Ind.Area",
       individual.is_voided                                                        AS "Ind.is_voided",
       individual.registration_location                                               "Ind.registration_location",
       op.name                                                                     AS "Enl.Program Name",
       programenrolment.id                                                         AS "Enl.Id",
       programenrolment.uuid                                                       AS "Enl.uuid",
       programenrolment.is_voided                                                  AS "Enl.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                              AS "Ind.Contact Number",
       (single_select_coded((programenrolment.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text AS "Enl.Adherence to medications",
       (single_select_coded((programenrolment.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text AS "Enl.Do you check your foot daily",
       (single_select_coded((programenrolment.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text AS "Enl.What about your physical activity",
       (single_select_coded((programenrolment.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text AS "Enl.Alcohol use in last 1 year",
       (single_select_coded((programenrolment.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text AS "Enl.What about the use of tobacco",
       (single_select_coded((programenrolment.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text AS "Enl.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programenrolment.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text AS "Enl.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programenrolment.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text AS "Enl.Habit of fruit intake atleast 3 servings daily",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                              AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                              AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                              AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                              AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text AS "Enl.Waist circumference is normal",
       (programenrolment.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                              AS "Enl.Blood Pressure (systolic)",
       (programenrolment.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                              AS "Enl.Blood Pressure (Diastolic)",
       (programenrolment.observations ->>
        '3e30648a-5829-45bb-b2ef-f797462c397e'::text)                              AS "Enl.Fasting blood sugar level reports in last one month",
       (programenrolment.observations ->>
        '22868608-488a-4be8-9dd3-d2c50fe1f6aa'::text)                              AS "Enl.Post prandial blood sugar level reports in last one month",
       (programenrolment.observations ->>
        '18d36389-e42d-4366-a316-053407c3a0ab'::text)                              AS "Enl.Random blood sugar levels report",
       (single_select_coded((programenrolment.observations ->>
                             '319c1184-2afb-4e10-9523-840645b6a130'::text)))::text AS "Enl.Whether your blood sugar level is under control"
FROM program_enrolment programenrolment
         LEFT JOIN individual individual ON programenrolment.individual_id = individual.id
         LEFT JOIN operational_program op ON op.program_id = programenrolment.program_id
         LEFT JOIN gender g ON g.id = individual.gender_id
         LEFT JOIN address_level a ON individual.address_id = a.id
WHERE (((op.uuid)::text = '2106f644-da4e-46cd-9940-a495be09d857'::text) AND
       (programenrolment.enrolment_date_time IS NOT NULL));

drop view if exists yenepoya_diabetes_followup_view;
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
     "Enc.whether your blood sugar level is under control", "Enl.Adherence to medications",
     "Enl.Do you check your foot daily", "Enl.What about your physical activity",
     "Enl.Alcohol use in last 1 year", "Enl.What about the use of tobacco",
     "Enl.Eating of fast foods like fried and bakery items weekly",
     "Enl.Habit of vegetable intake atleast 3 servings daily",
     "Enl.Habit of fruit intake atleast 3 servings daily", "Enl.Height in CM", "Enl.Weight",
     "Enl.Mid arm circumference", "Enl.Waist circumference", "Enl.Abnormal waist circumference",
     "Enl.Waist circumference is normal", "Enl.Blood Pressure (systolic)", "Enl.Blood Pressure (Diastolic)",
     "Enl.Fasting blood sugar level reports in last one month",
     "Enl.Post prandial blood sugar level reports in last one month", "Enl.Random blood sugar levels report",
     "Enl.Whether your blood sugar level is under control", "Enl.enrolment_date_time", "Ind.village",
     "Ind.panchayat", "Ind.surveillance_unit", "Rank")
as
SELECT individual.id                                                                        AS "Ind.Id",
       individual.address_id                                                                AS "Ind.address_id",
       individual.uuid                                                                      AS "Ind.uuid",
       individual.first_name                                                                AS "Ind.first_name",
       individual.last_name                                                                 AS "Ind.last_name",
       g.name                                                                               AS "Ind.Gender",
       individual.date_of_birth                                                             AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                    AS "Ind.date_of_birth_verified",
       individual.registration_date                                                         AS "Ind.registration_date",
       individual.facility_id                                                               AS "Ind.facility_id",
       village.title                                                                        AS "Ind.Area",
       individual.is_voided                                                                 AS "Ind.is_voided",
       programenrolment.id                                                                  AS "Enl.Id",
       oet.name                                                                             AS "Enc.Type",
       programencounter.id                                                                  AS "Enc.Id",
       programencounter.earliest_visit_date_time                                            AS "Enc.earliest_visit_date_time",
       programencounter.encounter_date_time                                                 AS "Enc.encounter_date_time",
       programencounter.program_enrolment_id                                                AS "Enc.program_enrolment_id",
       programencounter.uuid                                                                AS "Enc.uuid",
       programencounter.name                                                                AS "Enc.name",
       programencounter.max_visit_date_time                                                 AS "Enc.max_visit_date_time",
       programencounter.is_voided                                                           AS "Enc.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                       AS "Ind.Contact Number",
       (single_select_coded((programencounter.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text          AS "Enc.Adherence to medications",
       (single_select_coded((programencounter.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text          AS "Enc.Do you check your foot daily",
       (single_select_coded((programencounter.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text          AS "Enc.What about your physical activity",
       (single_select_coded((programencounter.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text          AS "Enc.Alcohol use in last 1 year",
       (single_select_coded((programencounter.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text          AS "Enc.What about the use of tobacco",
       (single_select_coded((programencounter.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text          AS "Enc.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programencounter.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text          AS "Enc.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programencounter.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text          AS "Enc.Habit of fruit intake atleast 3 servings daily",
       (programencounter.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                       AS "Enc.Height in CM",
       (programencounter.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                       AS "Enc.weight",
       (programencounter.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                       AS "Enc.mid arm circumference",
       (programencounter.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                       AS "Enc.waist circumference",
       (programencounter.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                       AS "Enc.blood Pressure (systolic)",
       (programencounter.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                       AS "Enc.blood Pressure (Diastolic)",
       (programencounter.observations ->>
        '18d36389-e42d-4366-a316-053407c3a0ab'::text)                                       AS "Enc.random blood sugar levels report",
       (programencounter.observations ->>
        '3e30648a-5829-45bb-b2ef-f797462c397e'::text)                                       AS "Enc.fasting blood sugar level reports in last one month",
       (programencounter.observations ->>
        '22868608-488a-4be8-9dd3-d2c50fe1f6aa'::text)                                       AS "Enc.post prandial blood sugar level reports in last one month",
       (single_select_coded((programencounter.observations ->>
                             '60ad9a6a-cb8d-4145-9f8a-295d8fcc1759'::text)))::text          AS "Enc.diabetes followup,have you developed any complication",
       (programencounter.observations ->>
        '4144ec30-c97a-41c0-9049-76258ca7973c'::text)                                       AS "Enc.Any complications,specify",
       (single_select_coded((programencounter.observations ->>
                             '319c1184-2afb-4e10-9523-840645b6a130'::text)))::text          AS "Enc.whether your blood sugar level is under control",
       (single_select_coded((programenrolment.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text          AS "Enl.Adherence to medications",
       (single_select_coded((programenrolment.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text          AS "Enl.Do you check your foot daily",
       (single_select_coded((programenrolment.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text          AS "Enl.What about your physical activity",
       (single_select_coded((programenrolment.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text          AS "Enl.Alcohol use in last 1 year",
       (single_select_coded((programenrolment.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text          AS "Enl.What about the use of tobacco",
       (single_select_coded((programenrolment.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text          AS "Enl.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programenrolment.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text          AS "Enl.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programenrolment.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text          AS "Enl.Habit of fruit intake atleast 3 servings daily",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                       AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                       AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                       AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                       AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text          AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text          AS "Enl.Waist circumference is normal",
       (programenrolment.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                       AS "Enl.Blood Pressure (systolic)",
       (programenrolment.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                       AS "Enl.Blood Pressure (Diastolic)",
       (programenrolment.observations ->>
        '3e30648a-5829-45bb-b2ef-f797462c397e'::text)                                       AS "Enl.Fasting blood sugar level reports in last one month",
       (programenrolment.observations ->>
        '22868608-488a-4be8-9dd3-d2c50fe1f6aa'::text)                                       AS "Enl.Post prandial blood sugar level reports in last one month",
       (programenrolment.observations ->>
        '18d36389-e42d-4366-a316-053407c3a0ab'::text)                                       AS "Enl.Random blood sugar levels report",
       (single_select_coded((programenrolment.observations ->>
                             '319c1184-2afb-4e10-9523-840645b6a130'::text)))::text          AS "Enl.Whether your blood sugar level is under control",
       programenrolment.enrolment_date_time                                                 AS "Enl.enrolment_date_time",
       village.title                                                                        AS "Ind.village",
       panchayat.title                                                                      AS "Ind.panchayat",
       surveillance_unit.title                                                              AS "Ind.surveillance_unit",
       row_number()
       OVER (PARTITION BY individual.id ORDER BY programencounter.encounter_date_time DESC) AS "Rank"
FROM program_enrolment programenrolment
         LEFT JOIN program_encounter programencounter ON programencounter.program_enrolment_id = programenrolment.id AND
                                                         programencounter.encounter_date_time IS NOT NULL
         LEFT JOIN operational_encounter_type oet ON programencounter.encounter_type_id = oet.encounter_type_id AND
                                                     oet.uuid::text = '52814e7b-28a6-4acb-a9bd-eb01d6ee4698'::text
         LEFT JOIN operational_program op ON op.program_id = programenrolment.program_id
         LEFT JOIN individual individual ON programenrolment.individual_id = individual.id
         LEFT JOIN gender g ON g.id = individual.gender_id
         LEFT JOIN address_level village ON individual.address_id = village.id
         left join address_level panchayat on village.parent_id = panchayat.id
         left join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
WHERE op.uuid::text = '2106f644-da4e-46cd-9940-a495be09d857'::text
  AND programenrolment.enrolment_date_time IS NOT NULL;


drop view if exists yenepoya_history_of_fever_form_view;
create view yenepoya_history_of_fever_form_view
as
SELECT individual.id                                                                                        AS "Ind.Id",
       individual.address_id                                                                                AS "Ind.address_id",
       individual.uuid                                                                                      AS "Ind.uuid",
       individual.first_name                                                                                AS "Ind.first_name",
       individual.last_name                                                                                 AS "Ind.last_name",
       g.name                                                                                               AS "Ind.Gender",
       individual.date_of_birth                                                                             AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                    AS "Ind.date_of_birth_verified",
       individual.registration_date                                                                         AS "Ind.registration_date",
       individual.facility_id                                                                               AS "Ind.facility_id",
       a.title                                                                                              AS "Ind.Area",
       individual.is_voided                                                                                 AS "Ind.is_voided",
       individual.registration_location                                                                        "Ind.registration_location",
       oet.name                                                                                             AS "Enc.Type",
       encounter.id                                                                                         AS "Enc.Id",
       encounter.earliest_visit_date_time                                                                   AS "Enc.earliest_visit_date_time",
       encounter.encounter_date_time                                                                        AS "Enc.encounter_date_time",
       encounter.uuid                                                                                       AS "Enc.uuid",
       encounter.name                                                                                       AS "Enc.name",
       encounter.max_visit_date_time                                                                        AS "Enc.max_visit_date_time",
       encounter.is_voided                                                                                  AS "Enc.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                       AS "Ind.Contact Number",
       (single_select_coded(
               (encounter.observations ->> '59d2e12f-1d6d-4fac-9d9a-cae3ca021269'::text)))::text            AS "Enc.History of fever in last 15 days",
       (single_select_coded(
               (encounter.observations ->> '900b7304-3936-4ad7-bd59-3bf42a4cde64'::text)))::text            AS "Enc.Have you consulted the doctor",
       (single_select_coded(
               (encounter.observations ->> '38f12c1d-2536-4932-84f5-cf977a4a0e25'::text)))::text            AS "Enc.Was malaria/dengue test done",
       (single_select_coded(
               (encounter.observations ->> '08110960-7364-43ed-8990-afdcb47e975b'::text)))::text            AS "Enc.Specify the test result",
       (single_select_coded(
               (encounter.observations ->> '87fa4bfa-c929-4c12-a328-bc2620b7db79'::text)))::text            AS "Enc.Treatment taken",
       (single_select_coded(
               (encounter.observations ->> 'b0a3576e-3379-4105-afec-c37dddde80db'::text)))::text            AS "Enc.Type of health facility utilized for diagnosis",
       (single_select_coded(
               (encounter.observations ->> '0b267bfd-6c1a-43dd-a953-0b31e300ba6d'::text)))::text            AS "Enc.Type of health facility utilized for treatment",
       (single_select_coded(
               (encounter.observations ->> '162edcfb-6c3f-49a6-9024-608ff7f74c35'::text)))::text            AS "Enc.Have you taken the full course of treatment",
       (single_select_coded(
               (encounter.observations ->> 'a75978ab-b246-4500-b212-dc25e327c09a'::text)))::text            AS "Enc.Are you practising any mosquito prevention method",
       (multi_select_coded(
               (encounter.observations -> '9baaadc0-479b-44b3-87d3-4abc0fdb67a4'::text)))::text             AS "Enc.Mention the method",
       (single_select_coded(
               (encounter.observations ->> 'b82ec179-0c04-4c9c-a2e9-ed94834084a4'::text)))::text            AS "Enc.Any collection of water in surrounding",
       (multi_select_coded(
               (encounter.observations -> '0afc590f-5a27-44f2-94a6-28c2f8bc92a7'::text)))::text             AS "Enc.Surce of water collection",
       (single_select_coded(
               (encounter.observations ->> '12eb504d-f7c2-4e27-a690-3030511f135a'::text)))::text            AS "Enc.Have you been provided LLIN by Govt. health workers",
       (single_select_coded(
               (encounter.observations ->> '687e6e05-4103-4270-b76c-18521df8cf1f'::text)))::text            AS "Enc.Are you utilizing the LLIN?",
       (single_select_coded(
               (encounter.observations ->> 'cc9fcdfe-8465-4ff8-b28d-f3ad246b499b'::text)))::text            AS "Enc.Any Govt. health worker/MPW visited house in past 3 months",
       (single_select_coded(
               (encounter.observations ->> '2a19b6ac-896e-42e5-b3d6-c45896a7df35'::text)))::text            AS "Enc.Are you aware of mosquito control other than LLIN?",
       (multi_select_coded(
               (encounter.observations -> '3eeacd19-1d67-4a1a-9d39-0c919968cbf8'::text)))::text             AS "Enc.What mosquito control measures are you aware of? mention.",
       (multi_select_coded(
               (encounter.observations -> '9b031289-dcfa-4ccd-a868-cee9d2d33cba'::text)))::text             AS "Enc.Type of health care utilization",
       (multi_select_coded((encounter.observations -> '92ca8513-897b-4d73-8b55-fbed59f19b56'::text)))::text AS "Enc.If government,
              then",
       (multi_select_coded((encounter.observations -> '8290ba03-6b33-4f5e-a8af-a22a376099ad'::text)))::text AS "Enc.If private,
              then",
       (single_select_coded(
               (encounter.observations ->> '44154176-fc48-4ae6-9fe6-d534ad7f7c93'::text)))::text            AS "Enc.Are you aware of 24*7 hour Mobile Malaria Detection Unit?",
       (single_select_coded(
               (encounter.observations ->> 'e224f89f-f9a1-4731-9c05-3ce61d46eef5'::text)))::text            AS "Enc.Have you utilized 24*7 hour Mobile Malaria Detection Unit?",
       encounter.cancel_date_time                                                                           AS "EncCancel.cancel_date_time",
       (single_select_coded(
               (encounter.observations ->> '5592def2-fe5e-4234-9253-ca5fd0322e26'::text)))::text            AS "EncCancel.Reason Of Cancellation",
       (encounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862'::text)                            AS "EncCancel.Other Reason of Cancellation"
FROM ((((encounter encounter
    LEFT JOIN operational_encounter_type oet ON ((encounter.encounter_type_id = oet.encounter_type_id)))
    LEFT JOIN individual individual ON ((encounter.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((oet.uuid)::text = '0e511773-157a-400c-837c-33e46a30b71e'::text) AND
       (encounter.encounter_date_time IS NOT NULL));

drop view if exists yenepoya_hypertension_enrolment_view;
create view yenepoya_hypertension_enrolment_view
as
SELECT individual.id                                                               AS "Ind.Id",
       individual.address_id                                                       AS "Ind.address_id",
       individual.uuid                                                             AS "Ind.uuid",
       individual.first_name                                                       AS "Ind.first_name",
       individual.last_name                                                        AS "Ind.last_name",
       g.name                                                                      AS "Ind.Gender",
       individual.date_of_birth                                                    AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                           AS "Ind.date_of_birth_verified",
       individual.registration_date                                                AS "Ind.registration_date",
       individual.facility_id                                                      AS "Ind.facility_id",
       a.title                                                                     AS "Ind.Area",
       individual.is_voided                                                        AS "Ind.is_voided",
       individual.registration_location                                               "Ind.registration_location",
       op.name                                                                     AS "Enl.Program Name",
       programenrolment.id                                                         AS "Enl.Id",
       programenrolment.uuid                                                       AS "Enl.uuid",
       programenrolment.is_voided                                                  AS "Enl.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                              AS "Ind.Contact Number",
       (single_select_coded((programenrolment.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text AS "Enl.Adherence to medications",
       (single_select_coded((programenrolment.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text AS "Enl.Do you check your foot daily",
       (single_select_coded((programenrolment.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text AS "Enl.What about your physical activity",
       (single_select_coded((programenrolment.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text AS "Enl.Alcohol use in last 1 year",
       (single_select_coded((programenrolment.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text AS "Enl.What about the use of tobacco",
       (single_select_coded((programenrolment.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text AS "Enl.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programenrolment.observations ->>
                             'fc5fb2db-c47c-43c3-9872-c64fd0ec23e4'::text)))::text AS "Enl.preference for food with excess salt",
       (single_select_coded((programenrolment.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text AS "Enl.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programenrolment.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text AS "Enl.Habit of fruit intake atleast 3 servings daily",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                              AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                              AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                              AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                              AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text AS "Enl.Waist circumference is normal",
       (programenrolment.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                              AS "Enl.Blood Pressure (systolic)",
       (programenrolment.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                              AS "Enl.Blood Pressure (Diastolic)",
       (single_select_coded((programenrolment.observations ->>
                             '8bc6db2a-388d-4028-a995-865ff018c8f6'::text)))::text AS "Enl.Whether your blood sugar level is under control"
FROM ((((program_enrolment programenrolment
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '4e3dc382-f14a-4a56-8ab8-e4cc4faca774'::text) AND
       (programenrolment.enrolment_date_time IS NOT NULL));

drop view if exists yenepoya_hypertension_followup_view;
create view yenepoya_hypertension_followup_view
as
SELECT individual.id                                                                        AS "Ind.Id",
       individual.address_id                                                                AS "Ind.address_id",
       individual.uuid                                                                      AS "Ind.uuid",
       individual.first_name                                                                AS "Ind.first_name",
       individual.last_name                                                                 AS "Ind.last_name",
       g.name                                                                               AS "Ind.Gender",
       individual.date_of_birth                                                             AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                                    AS "Ind.date_of_birth_verified",
       individual.registration_date                                                         AS "Ind.registration_date",
       individual.facility_id                                                               AS "Ind.facility_id",
       individual.is_voided                                                                 AS "Ind.is_voided",
       programenrolment.id                                                                  AS "Enl.Id",
       oet.name                                                                             AS "Enc.Type",
       programencounter.id                                                                  AS "Enc.Id",
       programencounter.earliest_visit_date_time                                            AS "Enc.earliest_visit_date_time",
       programencounter.encounter_date_time                                                 AS "Enc.encounter_date_time",
       programencounter.program_enrolment_id                                                AS "Enc.program_enrolment_id",
       programencounter.uuid                                                                AS "Enc.uuid",
       programencounter.name                                                                AS "Enc.name",
       programencounter.max_visit_date_time                                                 AS "Enc.max_visit_date_time",
       programencounter.is_voided                                                           AS "Enc.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                       AS "Ind.Contact Number",
       (single_select_coded((programencounter.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text          AS "Enc.Adherence to medications",
       (single_select_coded((programencounter.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text          AS "Enc.Do you check your foot daily",
       (single_select_coded((programencounter.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text          AS "Enc.What about your physical activity",
       (single_select_coded((programencounter.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text          AS "Enc.Alcohol use in last 1 year",
       (single_select_coded((programencounter.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text          AS "Enc.What about the use of tobacco",
       (single_select_coded((programencounter.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text          AS "Enc.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programencounter.observations ->>
                             'fc5fb2db-c47c-43c3-9872-c64fd0ec23e4'::text)))::text          AS "Enc.preference for food with excess salt",
       (single_select_coded((programencounter.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text          AS "Enc.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programencounter.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text          AS "Enc.Habit of fruit intake atleast 3 servings daily",
       (programencounter.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                       AS "Enc.Height in CM",
       (programencounter.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                       AS "Enc.weight",
       (programencounter.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                       AS "Enc.mid arm circumference",
       (programencounter.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                       AS "Enc.waist circumference",
       (programencounter.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                       AS "Enc.blood Pressure (systolic)",
       (programencounter.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                       AS "Enc.blood Pressure (Diastolic)",
       (single_select_coded((programencounter.observations ->>
                             '8bc6db2a-388d-4028-a995-865ff018c8f6'::text)))::text          AS "Enc.Whether your blood pressure is under control",
       programencounter.cancel_date_time                                                    AS "EncCancel.cancel_date_time",
       (single_select_coded((programencounter.observations ->>
                             '5592def2-fe5e-4234-9253-ca5fd0322e26'::text)))::text          AS "EncCancel.Reason Of Cancellation",
       (programencounter.observations ->>
        '8263f129-5851-4f9d-a909-818dacacd862'::text)                                       AS "EncCancel.Other Reason of Cancellation",
       (single_select_coded((programenrolment.observations ->>
                             '1341e326-d2b5-4cbc-b09a-108e10a84808'::text)))::text          AS "Enl.Adherence to medications",
       (single_select_coded((programenrolment.observations ->>
                             '644a912d-beb9-4140-a629-c6639b304e67'::text)))::text          AS "Enl.Do you check your foot daily",
       (single_select_coded((programenrolment.observations ->>
                             'd7e707f2-4c4e-47e8-8907-7dab7770fc89'::text)))::text          AS "Enl.What about your physical activity",
       (single_select_coded((programenrolment.observations ->>
                             '29e472b6-0478-4de5-89f9-d7a4a373ff42'::text)))::text          AS "Enl.Alcohol use in last 1 year",
       (single_select_coded((programenrolment.observations ->>
                             'ec3e201d-f4de-4705-b954-02c750ca5063'::text)))::text          AS "Enl.What about the use of tobacco",
       (single_select_coded((programenrolment.observations ->>
                             '182d8aef-512d-4d50-8fd8-95cb01f3ccbe'::text)))::text          AS "Enl.Eating of fast foods like fried and bakery items weekly",
       (single_select_coded((programenrolment.observations ->>
                             'fc5fb2db-c47c-43c3-9872-c64fd0ec23e4'::text)))::text          AS "Enl.preference for food with excess salt",
       (single_select_coded((programenrolment.observations ->>
                             'd31251b0-616a-47d5-84d6-7b5fad85baad'::text)))::text          AS "Enl.Habit of vegetable intake atleast 3 servings daily",
       (single_select_coded((programenrolment.observations ->>
                             '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d'::text)))::text          AS "Enl.Habit of fruit intake atleast 3 servings daily",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                                       AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                                       AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                                       AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                                       AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text          AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text          AS "Enl.Waist circumference is normal",
       (programenrolment.observations ->>
        '7a320ebc-366d-4301-8e8b-71edcbaad78d'::text)                                       AS "Enl.Blood Pressure (systolic)",
       (programenrolment.observations ->>
        'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51'::text)                                       AS "Enl.Blood Pressure (Diastolic)",
       (single_select_coded((programenrolment.observations ->>
                             '8bc6db2a-388d-4028-a995-865ff018c8f6'::text)))::text          AS "Enl.Whether your blood pressure is under control",
       programenrolment.enrolment_date_time                                                 AS "Enl.enrolment_date_time",
       a.title                                                                              AS "Ind.village",
       panchayat.title                                                                      AS "Ind.panchayat",
       surveillance_unit.title                                                              AS "Ind.surveillance_unit",
       row_number()
       OVER (PARTITION BY individual.id ORDER BY programencounter.encounter_date_time DESC) AS rank
FROM program_enrolment programenrolment
         LEFT JOIN program_encounter programencounter ON programencounter.program_enrolment_id = programenrolment.id AND
                                                         programencounter.encounter_date_time IS NOT NULL
         LEFT JOIN operational_encounter_type oet ON programencounter.encounter_type_id = oet.encounter_type_id AND
                                                     oet.uuid::text = '5defe5af-b031-4783-80d6-52d49aa66884'::text
         LEFT JOIN operational_program op ON op.program_id = programenrolment.program_id
         LEFT JOIN individual individual ON programenrolment.individual_id = individual.id
         LEFT JOIN gender g ON g.id = individual.gender_id
         LEFT JOIN address_level a ON individual.address_id = a.id
         left join address_level panchayat on a.parent_id = panchayat.id
         left join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
WHERE op.uuid::text = '4e3dc382-f14a-4a56-8ab8-e4cc4faca774'::text
  AND programenrolment.enrolment_date_time IS NOT NULL;

drop view if exists yenepoya_ncd_enrolment_view;
create view yenepoya_ncd_enrolment_view
as
SELECT individual.id                                                               AS "Ind.Id",
       individual.address_id                                                       AS "Ind.address_id",
       individual.uuid                                                             AS "Ind.uuid",
       individual.first_name                                                       AS "Ind.first_name",
       individual.last_name                                                        AS "Ind.last_name",
       g.name                                                                      AS "Ind.Gender",
       individual.date_of_birth                                                    AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                           AS "Ind.date_of_birth_verified",
       individual.registration_date                                                AS "Ind.registration_date",
       individual.facility_id                                                      AS "Ind.facility_id",
       a.title                                                                     AS "Ind.Area",
       individual.is_voided                                                        AS "Ind.is_voided",
       op.name                                                                     AS "Enl.Program Name",
       programenrolment.id                                                         AS "Enl.Id",
       programenrolment.uuid                                                       AS "Enl.uuid",
       programenrolment.is_voided                                                  AS "Enl.is_voided",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                              AS "Ind.Contact Number",
       (single_select_coded((programenrolment.observations ->>
                             '0fc3b733-0ee0-4554-b316-e5e29c1978d2'::text)))::text AS "Enl.Smoking or consume smokeless products",
       (single_select_coded((programenrolment.observations ->>
                             'ac4d5664-0b5f-467f-a3c9-c0e4c8c221b7'::text)))::text AS "Enl.Alcohol consumption",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                              AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                              AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                              AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                              AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text AS "Enl.Waist circumference is normal",
       (single_select_coded((programenrolment.observations ->>
                             'dfdc75c1-5a47-4aae-887c-3ee9f050d75e'::text)))::text AS "Enl.Physical activity for >150 min/week",
       (single_select_coded((programenrolment.observations ->>
                             '3e092c91-8e32-42b1-ac26-045b846e3893'::text)))::text AS "Enl.Are you practicing any Yoga",
       (single_select_coded((programenrolment.observations ->>
                             '8f67d53a-07bf-4652-b7ad-f2f6ef6bdfa2'::text)))::text AS "Enl.Family histroy of high BP, DM or heart disease",
       (single_select_coded((programenrolment.observations ->>
                             '83f01615-04b1-4115-84a5-48e89c9aff54'::text)))::text AS "Enl.Difficulty in opening mouth",
       (single_select_coded((programenrolment.observations ->>
                             '5e4d8a9d-28a5-49ec-a4c9-cd9cfd4dd134'::text)))::text AS "Enl.Ulcer/ patch/ growth in mouth that has not healed for 2 wee",
       (single_select_coded((programenrolment.observations ->>
                             '89bf3601-d8ab-4353-85a3-8070a959394e'::text)))::text AS "Enl.Whether change in the tone of voice",
       (single_select_coded((programenrolment.observations ->>
                             'd9f8ee0c-960f-43d7-9b02-aa2557a9aa10'::text)))::text AS "Enl.Lump in the breast",
       (single_select_coded((programenrolment.observations ->>
                             '74745370-ee9e-4f58-b25e-57ebac69d75d'::text)))::text AS "Enl.Blood stained discharge from nipple",
       (single_select_coded((programenrolment.observations ->>
                             '2da75202-7f70-4a76-a8eb-cd9b289cdf8a'::text)))::text AS "Enl.Change in shape and size of breast",
       (single_select_coded((programenrolment.observations ->>
                             '45f02196-217b-4772-8085-3d17c41244da'::text)))::text AS "Enl.Bleeding between periods",
       (single_select_coded((programenrolment.observations ->>
                             'd1774f83-ee28-41b8-9cb8-309098ee0f16'::text)))::text AS "Enl.Bleeding after menopause",
       (single_select_coded((programenrolment.observations ->>
                             '82efa85a-46a9-4c75-8c53-c488b8c48c54'::text)))::text AS "Enl.Bleeding after intercourse",
       (single_select_coded((programenrolment.observations ->>
                             '84a99b8c-f9bb-4436-9d83-d79a60a0b450'::text)))::text AS "Enl.Foul smelling vaginal discharge"
FROM ((((program_enrolment programenrolment
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (((op.uuid)::text = '85a36148-26a2-4a30-921c-5c1fc64e8acc'::text) AND
       (programenrolment.enrolment_date_time IS NOT NULL));


drop view if exists yenepoya_ncd_followup_view;
create view yenepoya_ncd_followup_view
as
SELECT individual.id                                                               AS "Ind.Id",
       individual.address_id                                                       AS "Ind.address_id",
       individual.uuid                                                             AS "Ind.uuid",
       individual.first_name                                                       AS "Ind.first_name",
       individual.last_name                                                        AS "Ind.last_name",
       g.name                                                                      AS "Ind.Gender",
       individual.date_of_birth                                                    AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                           AS "Ind.date_of_birth_verified",
       individual.registration_date                                                AS "Ind.registration_date",
       individual.facility_id                                                      AS "Ind.facility_id",
       village.title                                                               as "Ind.village",
       panchayat.title                                                             as "Ind.panchayat",
       surveillance_unit.title                                                     as "Ind.surveillance_unit",
       individual.is_voided                                                        AS "Ind.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)  AS "Ind.Contact Number",
       programenrolment.id                                                         AS "Enl.Id",
       programenrolment.enrolment_date_time                                        AS "Enl.enrolment_date_time",
       programenrolment.program_exit_date_time                                     AS "Enl.program_exit_date_time",
       programenrolment.is_voided                                                  AS "Enl.is_voided",
       oet.name                                                                    AS "Enc.Type",
       programencounter.id                                                         AS "Enc.Id",
       programencounter.earliest_visit_date_time                                   AS "Enc.earliest_visit_date_time",
       programencounter.encounter_date_time                                        AS "Enc.encounter_date_time",
       programencounter.program_enrolment_id                                       AS "Enc.program_enrolment_id",
       programencounter.uuid                                                       AS "Enc.uuid",
       programencounter.name                                                       AS "Enc.name",
       programencounter.max_visit_date_time                                        AS "Enc.max_visit_date_time",
       programencounter.is_voided                                                  AS "Enc.is_voided",
       (single_select_coded((programenrolment.observations ->>
                             '0fc3b733-0ee0-4554-b316-e5e29c1978d2'::text)))::text AS "Enl.Smoking or consume smokeless products",
       (multi_select_coded((programenrolment.observations ->
                            'd41af1b4-8f7e-4643-a3ff-b17d442c1fae'::text)))        AS "Enl.Risk Score",
       (single_select_coded((programenrolment.observations ->>
                             'ac4d5664-0b5f-467f-a3c9-c0e4c8c221b7'::text)))::text AS "Enl.Alcohol consumption",
       (programenrolment.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                              AS "Enl.Height in CM",
       (programenrolment.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                              AS "Enl.Weight",
       (programenrolment.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                              AS "Enl.Mid arm circumference",
       (programenrolment.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                              AS "Enl.Waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text AS "Enl.Abnormal waist circumference",
       (single_select_coded((programenrolment.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text AS "Enl.Waist circumference is normal",
       (single_select_coded((programenrolment.observations ->>
                             'dfdc75c1-5a47-4aae-887c-3ee9f050d75e'::text)))::text AS "Enl.Physical activity for >150 min/week",
       (single_select_coded((programenrolment.observations ->>
                             '3e092c91-8e32-42b1-ac26-045b846e3893'::text)))::text AS "Enl.Are you practicing any Yoga",
       (single_select_coded((programenrolment.observations ->>
                             '8f67d53a-07bf-4652-b7ad-f2f6ef6bdfa2'::text)))::text AS "Enl.Family histroy of high BP, DM or heart disease",
       (single_select_coded((programenrolment.observations ->>
                             '83f01615-04b1-4115-84a5-48e89c9aff54'::text)))::text AS "Enl.Difficulty in opening mouth",
       (single_select_coded((programenrolment.observations ->>
                             '5e4d8a9d-28a5-49ec-a4c9-cd9cfd4dd134'::text)))::text AS "Enl.Ulcer/ patch/ growth in mouth that has not healed for 2 wee",
       (single_select_coded((programenrolment.observations ->>
                             '89bf3601-d8ab-4353-85a3-8070a959394e'::text)))::text AS "Enl.Whether change in the tone of voice",
       (single_select_coded((programenrolment.observations ->>
                             'd9f8ee0c-960f-43d7-9b02-aa2557a9aa10'::text)))::text AS "Enl.Lump in the breast",
       (single_select_coded((programenrolment.observations ->>
                             '74745370-ee9e-4f58-b25e-57ebac69d75d'::text)))::text AS "Enl.Blood stained discharge from nipple",
       (single_select_coded((programenrolment.observations ->>
                             '2da75202-7f70-4a76-a8eb-cd9b289cdf8a'::text)))::text AS "Enl.Change in shape and size of breast",
       (single_select_coded((programenrolment.observations ->>
                             '45f02196-217b-4772-8085-3d17c41244da'::text)))::text AS "Enl.Bleeding between periods",
       (single_select_coded((programenrolment.observations ->>
                             'd1774f83-ee28-41b8-9cb8-309098ee0f16'::text)))::text AS "Enl.Bleeding after menopause",
       (single_select_coded((programenrolment.observations ->>
                             '82efa85a-46a9-4c75-8c53-c488b8c48c54'::text)))::text AS "Enl.Bleeding after intercourse",
       (single_select_coded((programenrolment.observations ->>
                             '84a99b8c-f9bb-4436-9d83-d79a60a0b450'::text)))::text AS "Enl.Foul smelling vaginal discharge",
       (multi_select_coded((programencounter.observations ->
                            'd41af1b4-8f7e-4643-a3ff-b17d442c1fae'::text)))        AS "Enc.Risk Score",
       (single_select_coded((programencounter.observations ->>
                             '0fc3b733-0ee0-4554-b316-e5e29c1978d2'::text)))::text AS "Enc.Smoking or consume smokeless products",
       (single_select_coded((programencounter.observations ->>
                             'ac4d5664-0b5f-467f-a3c9-c0e4c8c221b7'::text)))::text AS "Enc.Alcohol consumption",
       (programencounter.observations ->>
        '80d88c23-1e44-423a-96bf-5ddaf105042e'::text)                              AS "Enc.Height in CM",
       (programencounter.observations ->>
        'e9190320-3211-4d9f-a72c-288f42cf830c'::text)                              AS "Enc.Weight",
       (programencounter.observations ->>
        '44a608f8-54d3-4a8b-96b8-7175c65e1d01'::text)                              AS "Enc.Mid arm circumference",
       (programencounter.observations ->>
        'a9f45a38-99a7-4fd8-8e28-1291434eace0'::text)                              AS "Enc.Waist circumference",
       (single_select_coded((programencounter.observations ->>
                             'c78e883a-60de-4629-8d85-8e4512cd13d5'::text)))::text AS "Enc.Abnormal waist circumference",
       (single_select_coded((programencounter.observations ->>
                             '1cae9bd0-0dba-4479-954a-2d569c58d711'::text)))::text AS "Enc.Waist circumference is normal",
       (single_select_coded((programencounter.observations ->>
                             'dfdc75c1-5a47-4aae-887c-3ee9f050d75e'::text)))::text AS "Enc.Physical activity for >150 min/week",
       (single_select_coded((programencounter.observations ->>
                             '3e092c91-8e32-42b1-ac26-045b846e3893'::text)))::text AS "Enc.Are you practicing any Yoga",
       (single_select_coded((programencounter.observations ->>
                             '8f67d53a-07bf-4652-b7ad-f2f6ef6bdfa2'::text)))::text AS "Enc.Family histroy of high BP, DM or heart disease",
       (single_select_coded((programencounter.observations ->>
                             '83f01615-04b1-4115-84a5-48e89c9aff54'::text)))::text AS "Enc.Difficulty in opening mouth",
       (single_select_coded((programencounter.observations ->>
                             '5e4d8a9d-28a5-49ec-a4c9-cd9cfd4dd134'::text)))::text AS "Enc.Ulcer/ patch/ growth in mouth that has not healed for 2 wee",
       (single_select_coded((programencounter.observations ->>
                             '89bf3601-d8ab-4353-85a3-8070a959394e'::text)))::text AS "Enc.Whether change in the tone of voice",
       (single_select_coded((programencounter.observations ->>
                             'd9f8ee0c-960f-43d7-9b02-aa2557a9aa10'::text)))::text AS "Enc.Lump in the breast",
       (single_select_coded((programencounter.observations ->>
                             '74745370-ee9e-4f58-b25e-57ebac69d75d'::text)))::text AS "Enc.Blood stained discharge from nipple",
       (single_select_coded((programencounter.observations ->>
                             '2da75202-7f70-4a76-a8eb-cd9b289cdf8a'::text)))::text AS "Enc.Change in shape and size of breast",
       (single_select_coded((programencounter.observations ->>
                             '45f02196-217b-4772-8085-3d17c41244da'::text)))::text AS "Enc.Bleeding between periods",
       (single_select_coded((programencounter.observations ->>
                             'd1774f83-ee28-41b8-9cb8-309098ee0f16'::text)))::text AS "Enc.Bleeding after menopause",
       (single_select_coded((programencounter.observations ->>
                             '82efa85a-46a9-4c75-8c53-c488b8c48c54'::text)))::text AS "Enc.Bleeding after intercourse",
       (single_select_coded((programencounter.observations ->>
                             '84a99b8c-f9bb-4436-9d83-d79a60a0b450'::text)))::text AS "Enc.Foul smelling vaginal discharge",
       programencounter.cancel_date_time                                           AS "EncCancel.cancel_date_time",
       (single_select_coded((programencounter.observations ->>
                             '5592def2-fe5e-4234-9253-ca5fd0322e26'::text)))::text AS "EncCancel.Reason Of Cancellation",
       (programencounter.observations ->>
        '8263f129-5851-4f9d-a909-818dacacd862'::text)                              AS "EncCancel.Other Reason of Cancellation"
FROM program_enrolment programenrolment
         LEFT JOIN operational_program op ON op.program_id = programenrolment.program_id
         LEFT JOIN program_encounter programencounter ON programencounter.program_enrolment_id = programenrolment.id
    AND programencounter.encounter_date_time IS NOT NULL
         LEFT JOIN operational_encounter_type oet ON programencounter.encounter_type_id = oet.encounter_type_id
    AND oet.uuid::text = 'b0d16b85-218c-4392-999c-4fa19476cf42'::text
         LEFT JOIN individual individual ON programenrolment.individual_id = individual.id
         LEFT JOIN gender g ON g.id = individual.gender_id
         left join address_level village on individual.address_id = village.id
         left join address_level panchayat on village.parent_id = panchayat.id
         left join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
WHERE op.uuid::text = '85a36148-26a2-4a30-921c-5c1fc64e8acc'::text
  AND programenrolment.enrolment_date_time IS NOT NULL;


create or replace view yenepoya_member_household_view as (
    select concat(member.first_name, ' ', member.last_name)                                         member_name,
           member.id                                                                                member_id,
           house.first_name                                                                         house_name,
           house.id                                                                                 house_id,
           (select concat(head.first_name, ' ', head.last_name)
            from individual head
            where head.id = gs2.member_subject_id)                                                  head_of_family_name,
           gs2.member_subject_id                                                                    head_of_family_id,
           (house.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab')::text                    household_number,
           single_select_coded(house.observations ->> '1948be58-d42e-4313-8ec5-ac9ca87eb399')::text name_of_phc_uphc
    from individual member
             join subject_type on member.subject_type_id = subject_type.id and subject_type.type = 'Person'
             left join group_subject gs on gs.member_subject_id = member.id and not gs.is_voided
             left join individual house on house.id = gs.group_subject_id
             left join group_subject gs2 on gs2.group_subject_id = house.id
             left join group_role gr on gs2.group_role_id = gr.id
    where not gs2.is_voided
        and gr.role = 'Head of household'
       or gr.role isnull
);

drop view if exists yenepoya_pregnancy_enrolemt_view;
create view yenepoya_pregnancy_enrolemt_view
as
SELECT individual.id                                                                                          "Ind.Id",
       individual.address_id                                                                                  "Ind.address_id",
       individual.uuid                                                                                        "Ind.uuid",
       individual.first_name                                                                                  "Ind.first_name",
       individual.last_name                                                                                   "Ind.last_name",
       g.name                                                                                                 "Ind.Gender",
       individual.date_of_birth                                                                               "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                      "Ind.date_of_birth_verified",
       individual.registration_date                                                                           "Ind.registration_date",
       individual.facility_id                                                                                 "Ind.facility_id",
       a.title                                                                                             as "Ind.village",
       panchayat.title                                                                                     as "Ind.panchayat",
       surveillance_unit.title                                                                             as "Ind.surveillance_unit",
       individual.is_voided                                                                                   "Ind.is_voided",
       op.name                                                                                                "Enl.Program Name",
       individual.registration_date                                                                           "Ind.registration_date",
       individual.facility_id                                                                                 "Ind.facility_id",
       individual.is_voided                                                                                   "Ind.is_voided",
       op.name                                                                                                "Enl.Program Name",
       programenrolment.enrolment_date_time                                                                AS "Enl.enrolment_date_time",
       programenrolment.program_exit_date_time                                                             AS "Enl.program_exit_date_time",
       programEnrolment.id                                                                                    "Enl.Id",
       programEnrolment.uuid                                                                                  "Enl.uuid",
       programEnrolment.is_voided                                                                             "Enl.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT                          as "Ind.Contact Number",
       (programEnrolment.observations ->> 'a9440019-fc51-43a9-a695-43bbe77d2da1')::DATE                    as "Enl.Last menstrual period",
       (programEnrolment.observations ->> '448d443b-ffd6-446e-bbb9-bf1b1ef450b4')::DATE                    as "Enl.Estimated Date of Delivery",
       (programEnrolment.observations ->> '3ee9088e-8809-44d1-9e76-c5bcca84fe3b')::TEXT                    as "Enl.Gravida",
       (programEnrolment.observations ->> '368466f7-3aac-4155-a114-6269cef2e90c')::TEXT                    as "Enl.Para",
       (programEnrolment.observations ->> '9bfe3d44-73b6-4f1b-a6f1-0b85f018ff34')::TEXT                    as "Enl.No of living children",
       (programEnrolment.observations ->> '1617d0e0-83e0-4f10-ba1c-7fb24a1cc3da')::TEXT                    as "Enl.No of abortions in the past",
       (programEnrolment.observations ->> '5030abb0-43f0-41e3-b618-50ac64e57113')::TEXT                    as "Enl.Gestational age in weeks",
       single_select_coded(
               programEnrolment.observations ->> '59c70bbd-a02e-4519-8b65-8383ae59adbc')::TEXT             as "Enl.Thai card available",
       (programEnrolment.observations ->> '11682aa1-5e0e-4f76-834e-c0e4c3eb03e3')::TEXT                    as "Enl.Name of the ASHA",
       single_select_coded(
               programEnrolment.observations ->> '41ff539e-2f33-43cb-a902-036c9b114860')::TEXT             as "Enl.Is present pregnancy registered",
       (programEnrolment.observations ->> 'fff8bd3b-f054-46e4-934c-ab931117a435')::TEXT                    as "Enl.week of registration",
       single_select_coded(
               programEnrolment.observations ->> 'cb75cb80-d3a4-4a54-bd0d-82a5b76971ea')::TEXT             as "Enl.Place of registration",
       single_select_coded(
               programEnrolment.observations ->> '2fd7c36a-b025-4cb6-954c-2806e9b1269f')::TEXT             as "Enl.Early registration (<12 weeks)",
       single_select_coded(
               programEnrolment.observations ->> '184bf8da-db08-4167-b312-afcf2ab654a6')::TEXT             as "Enl.Antenatal checkup received",
       single_select_coded(
               programEnrolment.observations ->> 'a48e9723-5b93-4e1a-a8ac-43d7192c5edb')::TEXT             as "Enl.If yes, preferred place of antenatal check up",
       (programEnrolment.observations ->> '21cf25b4-7c0f-470c-9886-47ca4279bd6a')::TEXT                    as "Enl.No of antenatal visits in present pregnancy",
       single_select_coded(
               programEnrolment.observations ->> 'f8380766-d281-477a-a91f-249ee6073dec')::TEXT             as "Enl.Have you received first dose of TT",
       (programEnrolment.observations ->> '0389ab96-b15e-4fc5-872f-75bc2fabe138')::DATE                    as "Enl.Date of first dose of TT",
       single_select_coded(
               programEnrolment.observations ->> 'a4527091-7229-410f-8df0-1d2484f99169')::TEXT             as "Enl.Have you received second dose of TT",
       (programEnrolment.observations ->> 'bcafed31-d484-4a1d-b141-15f2f470d7ae')::DATE                    as "Enl.Date of second dose of TT",
       single_select_coded(
               programEnrolment.observations ->> '519d0b30-7296-481c-bc62-b9a9ec640426')::TEXT             as "Enl.Received and consumed iron and folic acid tablets",
       single_select_coded(
               programEnrolment.observations ->> '5188bc03-371a-495d-b724-385c5fbb0c58')::TEXT             as "Enl.Received and consumed calcium tablet",
       single_select_coded(
               programEnrolment.observations ->> 'dd280449-48fd-4086-9d98-fd56aebc9a3d')::TEXT             as "Enl.Received and consumed Albendazole tablet",
       (programEnrolment.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                    as "Enl.Height in CM",
       (programEnrolment.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                    as "Enl.Weight",
       (programEnrolment.observations ->> '0b5ae1e8-e44a-4457-a38a-44d5103a8fdd')::TEXT                    as "Enl.BMI",
       (programEnrolment.observations ->> 'a121ed17-61fd-4497-bb13-10ccc34c1db0')::TEXT                    as "Enl.Hemoglobin level",
       (programEnrolment.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                    as "Enl.Blood Pressure (systolic)",
       (programEnrolment.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                    as "Enl.Blood Pressure (Diastolic)",
       (programEnrolment.observations ->> '18d36389-e42d-4366-a316-053407c3a0ab')::TEXT                    as "Enl.Random blood sugar levels report",
       single_select_coded(
               programEnrolment.observations ->> '9fc68cda-63b0-4a67-9917-681f6636ff89')::TEXT             as "Enl.Availed services under PMSMA scheme",
       single_select_coded(
               programEnrolment.observations ->> 'd5ad5edc-756c-4243-b49e-514219b9f9b8')::TEXT             as "Enl.Whether received one specialist consultation",
       single_select_coded(
               programEnrolment.observations ->> 'b4ddba1a-7acc-4b28-9892-1d865dec88f6')::TEXT             as "Enl.Whether thyroid profile done",
       single_select_coded(
               programEnrolment.observations ->> '574b3d38-50c0-4085-8812-cd3c3a3294b1')::TEXT             as "Enl.Whether anomaly scan done",
       single_select_coded(
               programEnrolment.observations ->> '87f44c12-e03a-4fdd-bce1-ce0d0f487908')::TEXT             as "Enl.Received & consumed supplementary nutrition (Cooked food/TH",
       (programEnrolment.observations ->> 'f123fcf5-c94c-4a8f-8fc0-eddb4ddd200e')::TEXT                    as "Enl.IF yes how many times in a week utilized the services",
       single_select_coded(
               programEnrolment.observations ->> '646b471d-08cd-4ebe-a5ba-9a3c781d26a3')::TEXT             as "Enl.History of bleeding/leaking per vagina",
       single_select_coded(
               programEnrolment.observations ->> '3b1763e9-3a77-4976-874f-ad11e9436a92')::TEXT             as "Enl.Whether present pregnancy is twin pregnancy",
       single_select_coded(
               programEnrolment.observations ->> '0e5f1135-f3a8-4b66-8fb6-3acb74959e3a')::TEXT             as "Enl.Foetal movements felt",
       single_select_coded(
               programEnrolment.observations ->> 'c8698b30-5dac-47bc-a2d3-209bb4912aaa')::TEXT             as "Enl.Any medical illness diagnosed from last visit",
       multi_select_coded(
               programEnrolment.observations -> '141e5d6a-2882-4d76-8730-e369614c9b3f')::TEXT              as "Enl.If yes, Medical illness",
       (programEnrolment.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT                    as "Enl.Specify Other",
       single_select_coded(
               programEnrolment.observations ->> '9a4b7389-92e3-4cb2-9330-4911e9959899')::TEXT             as "Enl.If the medical illness is DM/HT/Thyroid disorder then wheth",
       single_select_coded(
               programEnrolment.observations ->> '9b338ab9-73f3-4e32-b625-914c754f52f0')::TEXT             as "Enl.History of previous cesarean section",
       multi_select_coded(
               programEnrolment.observations -> 'd06dd2e8-ae04-4288-aab3-e55c87ecfb03')::TEXT              as "Enl.Past Obstetric history",
       (programEnrolment.observations ->> '0cf117f9-fc79-438c-bfdc-3c3bbe5c8f6f')::TEXT                    as "Enl.Specify Other obstetric History"


FROM program_enrolment programEnrolment
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT JOIN address_level a ON individual.address_id = a.id
         LEFT JOIN address_level panchayat on a.parent_id = panchayat.id
         LEFT JOIN address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id


WHERE op.uuid = '59847f47-b600-4956-8b88-3bc834f19cdd'
  AND programEnrolment.enrolment_date_time IS NOT NULL;



drop view if exists yenepoya_anc_form_view;
create view yenepoya_anc_form_view
as
SELECT individual.id                                                                                          "Ind.Id",
       individual.address_id                                                                                  "Ind.address_id",
       individual.uuid                                                                                        "Ind.uuid",
       individual.first_name                                                                                  "Ind.first_name",
       individual.last_name                                                                                   "Ind.last_name",
       g.name                                                                                                 "Ind.Gender",
       individual.date_of_birth                                                                               "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                      "Ind.date_of_birth_verified",
       individual.registration_date                                                                           "Ind.registration_date",
       individual.facility_id                                                                                 "Ind.facility_id",
       a.title                                                                                             as "Ind.village",
       panchayat.title                                                                                     as "Ind.panchayat",
       surveillance_unit.title                                                                             as "Ind.surveillance_unit",
       individual.is_voided                                                                                   "Ind.is_voided",
       op.name                                                                                                "Enl.Program Name",
       individual.is_voided                                                                                   "Ind.is_voided",
       op.name                                                                                                "Enl.Program Name",
       programenrolment.enrolment_date_time                                                                AS "Enl.enrolment_date_time",
       programenrolment.program_exit_date_time                                                             AS "Enl.program_exit_date_time",
       programEnrolment.id                                                                                    "Enl.Id",
       programEnrolment.uuid                                                                                  "Enl.uuid",
       programEnrolment.is_voided                                                                             "Enl.is_voided",
       oet.name                                                                                               "Enc.Type",
       programEncounter.id                                                                                    "Enc.Id",
       programEncounter.earliest_visit_date_time                                                              "Enc.earliest_visit_date_time",
       programEncounter.encounter_date_time                                                                   "Enc.encounter_date_time",
       programEncounter.program_enrolment_id                                                                  "Enc.program_enrolment_id",
       programEncounter.uuid                                                                                  "Enc.uuid",
       programEncounter.name                                                                                  "Enc.name",
       programEncounter.max_visit_date_time                                                                   "Enc.max_visit_date_time",
       programEncounter.is_voided                                                                             "Enc.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT                          as "Ind.Contact Number",
       (programEnrolment.observations ->> 'a9440019-fc51-43a9-a695-43bbe77d2da1')::DATE                    as "Enl.Last menstrual period",
       (programEnrolment.observations ->> '448d443b-ffd6-446e-bbb9-bf1b1ef450b4')::DATE                    as "Enl.Estimated Date of Delivery",
       (programEnrolment.observations ->> '3ee9088e-8809-44d1-9e76-c5bcca84fe3b')::TEXT                    as "Enl.Gravida",
       (programEnrolment.observations ->> '368466f7-3aac-4155-a114-6269cef2e90c')::TEXT                    as "Enl.Para",
       (programEnrolment.observations ->> '9bfe3d44-73b6-4f1b-a6f1-0b85f018ff34')::TEXT                    as "Enl.No of living children",
       (programEnrolment.observations ->> '1617d0e0-83e0-4f10-ba1c-7fb24a1cc3da')::TEXT                    as "Enl.No of abortions in the past",
       (programEnrolment.observations ->> '5030abb0-43f0-41e3-b618-50ac64e57113')::TEXT                    as "Enl.Gestational age in weeks",
       single_select_coded(
               programEnrolment.observations ->> '59c70bbd-a02e-4519-8b65-8383ae59adbc')::TEXT             as "Enl.Thai card available",
       (programEnrolment.observations ->> '11682aa1-5e0e-4f76-834e-c0e4c3eb03e3')::TEXT                    as "Enl.Name of the ASHA",
       single_select_coded(
               programEnrolment.observations ->> '41ff539e-2f33-43cb-a902-036c9b114860')::TEXT             as "Enl.Is present pregnancy registered",
       (programEnrolment.observations ->> 'fff8bd3b-f054-46e4-934c-ab931117a435')::TEXT                    as "Enl.week of registration",
       single_select_coded(
               programEnrolment.observations ->> 'cb75cb80-d3a4-4a54-bd0d-82a5b76971ea')::TEXT             as "Enl.Place of registration",
       single_select_coded(
               programEnrolment.observations ->> '2fd7c36a-b025-4cb6-954c-2806e9b1269f')::TEXT             as "Enl.Early registration (<12 weeks)",
       single_select_coded(
               programEnrolment.observations ->> '184bf8da-db08-4167-b312-afcf2ab654a6')::TEXT             as "Enl.Antenatal checkup received",
       single_select_coded(
               programEnrolment.observations ->> 'a48e9723-5b93-4e1a-a8ac-43d7192c5edb')::TEXT             as "Enl.If yes, preferred place of antenatal check up",
       (programEnrolment.observations ->> '21cf25b4-7c0f-470c-9886-47ca4279bd6a')::TEXT                    as "Enl.No of antenatal visits in present pregnancy",
       single_select_coded(
               programEnrolment.observations ->> 'f8380766-d281-477a-a91f-249ee6073dec')::TEXT             as "Enl.Have you received first dose of TT",
       (programEnrolment.observations ->> '0389ab96-b15e-4fc5-872f-75bc2fabe138')::DATE                    as "Enl.Date of first dose of TT",
       single_select_coded(
               programEnrolment.observations ->> 'a4527091-7229-410f-8df0-1d2484f99169')::TEXT             as "Enl.Have you received second dose of TT",
       (programEnrolment.observations ->> 'bcafed31-d484-4a1d-b141-15f2f470d7ae')::DATE                    as "Enl.Date of second dose of TT",
       single_select_coded(
               programEnrolment.observations ->> '519d0b30-7296-481c-bc62-b9a9ec640426')::TEXT             as "Enl.Received and consumed iron and folic acid tablets",
       single_select_coded(
               programEnrolment.observations ->> '5188bc03-371a-495d-b724-385c5fbb0c58')::TEXT             as "Enl.Received and consumed calcium tablet",
       single_select_coded(
               programEnrolment.observations ->> 'dd280449-48fd-4086-9d98-fd56aebc9a3d')::TEXT             as "Enl.Received and consumed Albendazole tablet",
       (programEnrolment.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                    as "Enl.Height in CM",
       (programEnrolment.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                    as "Enl.Weight",
       (programEnrolment.observations ->> '0b5ae1e8-e44a-4457-a38a-44d5103a8fdd')::TEXT                    as "Enl.BMI",
       (programEnrolment.observations ->> 'a121ed17-61fd-4497-bb13-10ccc34c1db0')::TEXT                    as "Enl.Hemoglobin level",
       (programEnrolment.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                    as "Enl.Blood Pressure (systolic)",
       (programEnrolment.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                    as "Enl.Blood Pressure (Diastolic)",
       (programEnrolment.observations ->> '18d36389-e42d-4366-a316-053407c3a0ab')::TEXT                    as "Enl.Random blood sugar levels report",
       single_select_coded(
               programEnrolment.observations ->> '9fc68cda-63b0-4a67-9917-681f6636ff89')::TEXT             as "Enl.Availed services under PMSMA scheme",
       single_select_coded(
               programEnrolment.observations ->> 'd5ad5edc-756c-4243-b49e-514219b9f9b8')::TEXT             as "Enl.Whether received one specialist consultation",
       single_select_coded(
               programEnrolment.observations ->> 'b4ddba1a-7acc-4b28-9892-1d865dec88f6')::TEXT             as "Enl.Whether thyroid profile done",
       single_select_coded(
               programEnrolment.observations ->> '574b3d38-50c0-4085-8812-cd3c3a3294b1')::TEXT             as "Enl.Whether anomaly scan done",
       single_select_coded(
               programEnrolment.observations ->> '87f44c12-e03a-4fdd-bce1-ce0d0f487908')::TEXT             as "Enl.Received & consumed supplementary nutrition (Cooked food/TH",
       (programEnrolment.observations ->> 'f123fcf5-c94c-4a8f-8fc0-eddb4ddd200e')::TEXT                    as "Enl.IF yes how many times in a week utilized the services",
       single_select_coded(
               programEnrolment.observations ->> '646b471d-08cd-4ebe-a5ba-9a3c781d26a3')::TEXT             as "Enl.History of bleeding/leaking per vagina",
       single_select_coded(
               programEnrolment.observations ->> '3b1763e9-3a77-4976-874f-ad11e9436a92')::TEXT             as "Enl.Whether present pregnancy is twin pregnancy",
       single_select_coded(
               programEnrolment.observations ->> '0e5f1135-f3a8-4b66-8fb6-3acb74959e3a')::TEXT             as "Enl.Foetal movements felt",
       single_select_coded(
               programEnrolment.observations ->> 'c8698b30-5dac-47bc-a2d3-209bb4912aaa')::TEXT             as "Enl.Any medical illness diagnosed from last visit",
       multi_select_coded(
               programEnrolment.observations -> '141e5d6a-2882-4d76-8730-e369614c9b3f')::TEXT              as "Enl.If yes, Medical illness",
       (programEnrolment.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT                    as "Enl.Specify Other",
       single_select_coded(
               programEnrolment.observations ->> '9a4b7389-92e3-4cb2-9330-4911e9959899')::TEXT             as "Enl.If the medical illness is DM/HT/Thyroid disorder then wheth",
       single_select_coded(
               programEnrolment.observations ->> '9b338ab9-73f3-4e32-b625-914c754f52f0')::TEXT             as "Enl.History of previous cesarean section",
       multi_select_coded(
               programEnrolment.observations -> 'd06dd2e8-ae04-4288-aab3-e55c87ecfb03')::TEXT              as "Enl.Past Obstetric history",
       (programEnrolment.observations ->> '0cf117f9-fc79-438c-bfdc-3c3bbe5c8f6f')::TEXT                    as "Enl.Specify Other obstetric History",
       (programEncounter.observations ->> '5030abb0-43f0-41e3-b618-50ac64e57113')::TEXT                    as "Enc.Gestational age in weeks",
       (programEncounter.observations ->> '8dfb696a-0111-4a26-a52c-1119912dcd5e')::TEXT                    as "Enc.No of antenatal visits in present pregnancy you made to the",
       (programEncounter.observations ->> '9d3d23c2-23b7-43c4-9f85-754effc4b308')::TEXT                    as "Enc.No of home visits made by ASHA/ANM in present pregnancy",
       single_select_coded(
               programEncounter.observations ->> 'f8380766-d281-477a-a91f-249ee6073dec')::TEXT             as "Enc.Have you received first dose of TT",
       (programEncounter.observations ->> '0389ab96-b15e-4fc5-872f-75bc2fabe138')::DATE                    as "Enc.Date of first dose of TT",
       single_select_coded(
               programEncounter.observations ->> 'a4527091-7229-410f-8df0-1d2484f99169')::TEXT             as "Enc.Have you received second dose of TT",
       (programEncounter.observations ->> 'bcafed31-d484-4a1d-b141-15f2f470d7ae')::DATE                    as "Enc.Date of second dose of TT",
       single_select_coded(
               programEncounter.observations ->> '519d0b30-7296-481c-bc62-b9a9ec640426')::TEXT             as "Enc.Received and consumed iron and folic acid tablets",
       single_select_coded(
               programEncounter.observations ->> '5188bc03-371a-495d-b724-385c5fbb0c58')::TEXT             as "Enc.Received and consumed calcium tablet",
       single_select_coded(
               programEncounter.observations ->> 'dd280449-48fd-4086-9d98-fd56aebc9a3d')::TEXT             as "Enc.Received and consumed Albendazole tablet",
       (programEncounter.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                    as "Enc.Weight",
       (programEncounter.observations ->> '0b5ae1e8-e44a-4457-a38a-44d5103a8fdd')::TEXT                    as "Enc.BMI",
       (programEncounter.observations ->> 'a121ed17-61fd-4497-bb13-10ccc34c1db0')::TEXT                    as "Enc.Hemoglobin level",
       (programEncounter.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                    as "Enc.Blood Pressure (systolic)",
       (programEncounter.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                    as "Enc.Blood Pressure (Diastolic)",
       (programEncounter.observations ->> '18d36389-e42d-4366-a316-053407c3a0ab')::TEXT                    as "Enc.Random blood sugar levels report",
       single_select_coded(
               programEncounter.observations ->> '9fc68cda-63b0-4a67-9917-681f6636ff89')::TEXT             as "Enc.Availed services under PMSMA scheme",
       single_select_coded(
               programEncounter.observations ->> 'd5ad5edc-756c-4243-b49e-514219b9f9b8')::TEXT             as "Enc.Whether received one specialist consultation",
       single_select_coded(
               programEncounter.observations ->> 'b4ddba1a-7acc-4b28-9892-1d865dec88f6')::TEXT             as "Enc.Whether thyroid profile done",
       single_select_coded(
               programEncounter.observations ->> '574b3d38-50c0-4085-8812-cd3c3a3294b1')::TEXT             as "Enc.Whether anomaly scan done",
       single_select_coded(
               programEncounter.observations ->> '87f44c12-e03a-4fdd-bce1-ce0d0f487908')::TEXT             as "Enc.Received & consumed supplementary nutrition (Cooked food/TH",
       (programEncounter.observations ->> '5e19aac4-ed3e-4ab2-b47d-692301fffa49')::TEXT                    as "Enc.How many times in a last one year utilized the services",
       single_select_coded(
               programEncounter.observations ->> '646b471d-08cd-4ebe-a5ba-9a3c781d26a3')::TEXT             as "Enc.History of bleeding/leaking per vagina",
       single_select_coded(
               programEncounter.observations ->> '0e5f1135-f3a8-4b66-8fb6-3acb74959e3a')::TEXT             as "Enc.Foetal movements felt",
       programEncounter.cancel_date_time                                                                      "EncCancel.cancel_date_time",
       single_select_coded(
               programEncounter.observations ->> '5592def2-fe5e-4234-9253-ca5fd0322e26')::TEXT             as "EncCancel.Reason Of Cancellation",
       (programEncounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862')::TEXT                    as "EncCancel.Other Reason of Cancellation"
FROM program_encounter programEncounter
         LEFT OUTER JOIN operational_encounter_type oet on programEncounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN program_enrolment programEnrolment
                         ON programEncounter.program_enrolment_id = programEnrolment.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT JOIN address_level a ON individual.address_id = a.id
         LEFT JOIN address_level panchayat on a.parent_id = panchayat.id
         LEFT JOIN address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id

WHERE op.uuid = '59847f47-b600-4956-8b88-3bc834f19cdd'
  AND oet.uuid = '36c9cb57-180b-4377-a87e-0694d2c3aaf3'
  AND programEncounter.encounter_date_time IS NOT NULL
  AND programEnrolment.enrolment_date_time IS NOT NULL;



drop view if exists yenepoya_pregnancy_outcome_form_view;
create view yenepoya_pregnancy_outcome_form_view
as
SELECT individual.id                                                                                          "Ind.Id",
       individual.address_id                                                                                  "Ind.address_id",
       individual.uuid                                                                                        "Ind.uuid",
       individual.first_name                                                                                  "Ind.first_name",
       individual.last_name                                                                                   "Ind.last_name",
       g.name                                                                                                 "Ind.Gender",
       individual.date_of_birth                                                                               "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                      "Ind.date_of_birth_verified",
       individual.registration_date                                                                           "Ind.registration_date",
       individual.facility_id                                                                                 "Ind.facility_id",
       a.title                                                                                             as "Ind.village",
       panchayat.title                                                                                     as "Ind.panchayat",
       surveillance_unit.title                                                                             as "Ind.surveillance_unit",
       individual.is_voided                                                                                   "Ind.is_voided",
       op.name                                                                                                "Enl.Program Name",
       programenrolment.enrolment_date_time                                                                AS "Enl.enrolment_date_time",
       programenrolment.program_exit_date_time                                                             AS "Enl.program_exit_date_time",
       programEnrolment.id                                                                                    "Enl.Id",
       programEnrolment.uuid                                                                                  "Enl.uuid",
       programEnrolment.is_voided                                                                             "Enl.is_voided",
       oet.name                                                                                               "Enc.Type",
       programEncounter.id                                                                                    "Enc.Id",
       programEncounter.earliest_visit_date_time                                                              "Enc.earliest_visit_date_time",
       programEncounter.encounter_date_time                                                                   "Enc.encounter_date_time",
       programEncounter.program_enrolment_id                                                                  "Enc.program_enrolment_id",
       programEncounter.uuid                                                                                  "Enc.uuid",
       programEncounter.name                                                                                  "Enc.name",
       programEncounter.max_visit_date_time                                                                   "Enc.max_visit_date_time",
       programEncounter.is_voided                                                                             "Enc.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT                          as "Ind.Contact Number",
       (programEnrolment.observations ->> 'a9440019-fc51-43a9-a695-43bbe77d2da1')::DATE                    as "Enl.Last menstrual period",
       (programEnrolment.observations ->> '448d443b-ffd6-446e-bbb9-bf1b1ef450b4')::DATE                    as "Enl.Estimated Date of Delivery",
       (programEnrolment.observations ->> '3ee9088e-8809-44d1-9e76-c5bcca84fe3b')::TEXT                    as "Enl.Gravida",
       (programEnrolment.observations ->> '368466f7-3aac-4155-a114-6269cef2e90c')::TEXT                    as "Enl.Para",
       (programEnrolment.observations ->> '9bfe3d44-73b6-4f1b-a6f1-0b85f018ff34')::TEXT                    as "Enl.No of living children",
       (programEnrolment.observations ->> '1617d0e0-83e0-4f10-ba1c-7fb24a1cc3da')::TEXT                    as "Enl.No of abortions in the past",
       (programEnrolment.observations ->> '5030abb0-43f0-41e3-b618-50ac64e57113')::TEXT                    as "Enl.Gestational age in weeks",
       single_select_coded(
               programEnrolment.observations ->> '59c70bbd-a02e-4519-8b65-8383ae59adbc')::TEXT             as "Enl.Thai card available",
       (programEnrolment.observations ->> '11682aa1-5e0e-4f76-834e-c0e4c3eb03e3')::TEXT                    as "Enl.Name of the ASHA",
       single_select_coded(
               programEnrolment.observations ->> '41ff539e-2f33-43cb-a902-036c9b114860')::TEXT             as "Enl.Is present pregnancy registered",
       (programEnrolment.observations ->> 'fff8bd3b-f054-46e4-934c-ab931117a435')::TEXT                    as "Enl.week of registration",
       single_select_coded(
               programEnrolment.observations ->> 'cb75cb80-d3a4-4a54-bd0d-82a5b76971ea')::TEXT             as "Enl.Place of registration",
       single_select_coded(
               programEnrolment.observations ->> '2fd7c36a-b025-4cb6-954c-2806e9b1269f')::TEXT             as "Enl.Early registration (<12 weeks)",
       single_select_coded(
               programEnrolment.observations ->> '184bf8da-db08-4167-b312-afcf2ab654a6')::TEXT             as "Enl.Antenatal checkup received",
       single_select_coded(
               programEnrolment.observations ->> 'a48e9723-5b93-4e1a-a8ac-43d7192c5edb')::TEXT             as "Enl.If yes, preferred place of antenatal check up",
       (programEnrolment.observations ->> '21cf25b4-7c0f-470c-9886-47ca4279bd6a')::TEXT                    as "Enl.No of antenatal visits in present pregnancy",
       single_select_coded(
               programEnrolment.observations ->> 'f8380766-d281-477a-a91f-249ee6073dec')::TEXT             as "Enl.Have you received first dose of TT",
       (programEnrolment.observations ->> '0389ab96-b15e-4fc5-872f-75bc2fabe138')::DATE                    as "Enl.Date of first dose of TT",
       single_select_coded(
               programEnrolment.observations ->> 'a4527091-7229-410f-8df0-1d2484f99169')::TEXT             as "Enl.Have you received second dose of TT",
       (programEnrolment.observations ->> 'bcafed31-d484-4a1d-b141-15f2f470d7ae')::DATE                    as "Enl.Date of second dose of TT",
       single_select_coded(
               programEnrolment.observations ->> '519d0b30-7296-481c-bc62-b9a9ec640426')::TEXT             as "Enl.Received and consumed iron and folic acid tablets",
       single_select_coded(
               programEnrolment.observations ->> '5188bc03-371a-495d-b724-385c5fbb0c58')::TEXT             as "Enl.Received and consumed calcium tablet",
       single_select_coded(
               programEnrolment.observations ->> 'dd280449-48fd-4086-9d98-fd56aebc9a3d')::TEXT             as "Enl.Received and consumed Albendazole tablet",
       (programEnrolment.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                    as "Enl.Height in CM",
       (programEnrolment.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                    as "Enl.Weight",
       (programEnrolment.observations ->> '0b5ae1e8-e44a-4457-a38a-44d5103a8fdd')::TEXT                    as "Enl.BMI",
       (programEnrolment.observations ->> 'a121ed17-61fd-4497-bb13-10ccc34c1db0')::TEXT                    as "Enl.Hemoglobin level",
       (programEnrolment.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                    as "Enl.Blood Pressure (systolic)",
       (programEnrolment.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                    as "Enl.Blood Pressure (Diastolic)",
       (programEnrolment.observations ->> '18d36389-e42d-4366-a316-053407c3a0ab')::TEXT                    as "Enl.Random blood sugar levels report",
       single_select_coded(
               programEnrolment.observations ->> '9fc68cda-63b0-4a67-9917-681f6636ff89')::TEXT             as "Enl.Availed services under PMSMA scheme",
       single_select_coded(
               programEnrolment.observations ->> 'd5ad5edc-756c-4243-b49e-514219b9f9b8')::TEXT             as "Enl.Whether received one specialist consultation",
       single_select_coded(
               programEnrolment.observations ->> 'b4ddba1a-7acc-4b28-9892-1d865dec88f6')::TEXT             as "Enl.Whether thyroid profile done",
       single_select_coded(
               programEnrolment.observations ->> '574b3d38-50c0-4085-8812-cd3c3a3294b1')::TEXT             as "Enl.Whether anomaly scan done",
       single_select_coded(
               programEnrolment.observations ->> '87f44c12-e03a-4fdd-bce1-ce0d0f487908')::TEXT             as "Enl.Received & consumed supplementary nutrition (Cooked food/TH",
       (programEnrolment.observations ->> 'f123fcf5-c94c-4a8f-8fc0-eddb4ddd200e')::TEXT                    as "Enl.IF yes how many times in a week utilized the services",
       single_select_coded(
               programEnrolment.observations ->> '646b471d-08cd-4ebe-a5ba-9a3c781d26a3')::TEXT             as "Enl.History of bleeding/leaking per vagina",
       single_select_coded(
               programEnrolment.observations ->> '3b1763e9-3a77-4976-874f-ad11e9436a92')::TEXT             as "Enl.Whether present pregnancy is twin pregnancy",
       single_select_coded(
               programEnrolment.observations ->> '0e5f1135-f3a8-4b66-8fb6-3acb74959e3a')::TEXT             as "Enl.Foetal movements felt",
       single_select_coded(
               programEnrolment.observations ->> 'c8698b30-5dac-47bc-a2d3-209bb4912aaa')::TEXT             as "Enl.Any medical illness diagnosed from last visit",
       multi_select_coded(
               programEnrolment.observations -> '141e5d6a-2882-4d76-8730-e369614c9b3f')::TEXT              as "Enl.If yes, Medical illness",
       (programEnrolment.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT                    as "Enl.Specify Other",
       single_select_coded(
               programEnrolment.observations ->> '9a4b7389-92e3-4cb2-9330-4911e9959899')::TEXT             as "Enl.If the medical illness is DM/HT/Thyroid disorder then wheth",
       single_select_coded(
               programEnrolment.observations ->> '9b338ab9-73f3-4e32-b625-914c754f52f0')::TEXT             as "Enl.History of previous cesarean section",
       multi_select_coded(
               programEnrolment.observations -> 'd06dd2e8-ae04-4288-aab3-e55c87ecfb03')::TEXT              as "Enl.Past Obstetric history",
       (programEnrolment.observations ->> '0cf117f9-fc79-438c-bfdc-3c3bbe5c8f6f')::TEXT                    as "Enl.Specify Other obstetric History",
       (programEncounter.observations ->> '227adfb9-d254-4bf2-a4e2-1bac9358d867')::DATE                    as "Enc.Date of Pregnancy Outcome",
       single_select_coded(
               programEncounter.observations ->> 'a2adfec5-d84b-44a2-a410-7ebe2fdfe431')::TEXT             as "Enc.Pregnancy outcome",
       (programEncounter.observations ->> '5030abb0-43f0-41e3-b618-50ac64e57113')::TEXT                    as "Enc.Gestational age in weeks",
       (programEncounter.observations ->> 'ef04966b-a0b4-4173-b5b7-49b1d26721b2')::TEXT                    as "Enc.Order of this delivery",
       single_select_coded(
               programEncounter.observations ->> '5c125db9-506f-44fc-9771-91b63316583b')::TEXT             as "Enc.Place of delivery",
       single_select_coded(
               programEncounter.observations ->> '7bd8cbdc-bc4b-42f1-87e2-09130ceb298c')::TEXT             as "Enc.Type of delivery",
       single_select_coded(
               programEncounter.observations ->> 'd2ba600e-3b2e-4ed2-bb67-c65af4dbdcdc')::TEXT             as "Enc.Type of person who conducted the delivery",
       (programEncounter.observations ->> '7be55c84-4cdc-4165-89a9-a1621c12f9a4')::TEXT                    as "Enc.Number of Babies",
       single_select_coded(
               programEncounter.observations ->> '0c953cca-3d44-4834-a888-4d3f58ce8183')::TEXT             as "Enc.Gender of the baby",
       single_select_coded(
               programEncounter.observations ->> 'd8e6e4b1-4aaf-47b2-a68f-1eec293da0b6')::TEXT             as "Enc.Gender of the baby 2",
       single_select_coded(
               programEncounter.observations ->> 'e231e0a0-d4b8-4312-94fb-abdad593d2ef')::TEXT             as "Enc.Gender of the baby 3",
       (programEncounter.observations ->> 'b852e7b8-1c5f-4a7d-9262-99dd3ac2718c')::TEXT                    as "Enc.Birth weight of the baby in kgs",
       (programEncounter.observations ->> '9f31cc39-60d1-4501-84fb-5d0ef2edd840')::TEXT                    as "Enc.Birth weight of the baby 2 in kgs",
       (programEncounter.observations ->> 'a099aad2-703c-42dc-bc1a-89f0cd6ffd70')::TEXT                    as "Enc.Birth weight of the baby 3 in kgs",
       single_select_coded(
               programEncounter.observations ->> 'ceb91b63-c9e2-456e-af24-32c15e2c9433')::TEXT             as "Enc.Colostrum given",
       single_select_coded(
               programEncounter.observations ->> 'a85e83dc-f37c-48ef-af84-9aa52c82d620')::TEXT             as "Enc.Initiated breast feeding within 1 hr for normal delivery or",
       single_select_coded(
               programEncounter.observations ->> 'b648b78f-79af-45d6-b8c4-b77a77967a73')::TEXT             as "Enc.Pregnancy complications",
       (programEncounter.observations ->> '575adac4-05da-42f9-9400-2ea0ce6bad4a')::TEXT                    as "Enc.If yes specify",
       single_select_coded(
               programEncounter.observations ->> 'c9aeb1ee-ddc1-4872-b885-e3e000463610')::TEXT             as "Enc.Health status of the new born",
       single_select_coded(
               programEncounter.observations ->> '9878f701-2476-4d9b-9811-08b77748826a')::TEXT             as "Enc.Whether discharged within 48 hours/Two days",
       single_select_coded(
               programEncounter.observations ->> '1b12cdc2-3403-4a1b-b796-2772e1c66e81')::TEXT             as "Enc.Practicing any family planning methods",
       single_select_coded(
               programEncounter.observations ->> '31de6e7e-ba59-4416-8f79-9f668bf3b59d')::TEXT             as "Enc.IF YES specify",
       single_select_coded(
               programEncounter.observations ->> '8f33bbb7-982d-4401-ae9f-f49c3a0063ac')::TEXT             as "Enc.Child Immunization before discharge from the hospital",
       single_select_coded(
               programEncounter.observations ->> '5d322b1b-9682-4d9d-919d-4f0ba9bd1928')::TEXT             as "Enc.Zero dose OPV",
       single_select_coded(programEncounter.observations ->> '55be5f5b-64c4-493d-bc7b-267f21d606ff')::TEXT as "Enc.BCG",
       single_select_coded(programEncounter.observations ->> '011d87b7-0404-4fcd-a85a-87893ea85678')::TEXT as "Enc.HBV",
       single_select_coded(
               programEncounter.observations ->> '519d0b30-7296-481c-bc62-b9a9ec640426')::TEXT             as "Enc.Received and consumed iron and folic acid tablets",
       single_select_coded(
               programEncounter.observations ->> 'd99fa549-b82e-404c-9f26-24cc71b6c43b')::TEXT             as "Enc.Received any financial benefit under JSY",
       single_select_coded(
               programEncounter.observations ->> '6f274445-9121-4cf2-8b79-6d95be16be32')::TEXT             as "Enc.Received any financial benefit under JSSK",
       single_select_coded(
               programEncounter.observations ->> '87f44c12-e03a-4fdd-bce1-ce0d0f487908')::TEXT             as "Enc.Received & consumed supplementary nutrition (Cooked food/TH",
       (programEncounter.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                    as "Enc.Height in CM",
       (programEncounter.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                    as "Enc.Weight",
       (programEncounter.observations ->> '0b5ae1e8-e44a-4457-a38a-44d5103a8fdd')::TEXT                    as "Enc.BMI",
       (programEncounter.observations ->> 'a121ed17-61fd-4497-bb13-10ccc34c1db0')::TEXT                    as "Enc.Hemoglobin level",
       (programEncounter.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                    as "Enc.Blood Pressure (systolic)",
       (programEncounter.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                    as "Enc.Blood Pressure (Diastolic)",
       programEncounter.cancel_date_time                                                                      "EncCancel.cancel_date_time"

FROM program_encounter programEncounter
         LEFT OUTER JOIN operational_encounter_type oet on programEncounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN program_enrolment programEnrolment
                         ON programEncounter.program_enrolment_id = programEnrolment.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT JOIN address_level a ON individual.address_id = a.id
         LEFT JOIN address_level panchayat on a.parent_id = panchayat.id
         LEFT JOIN address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id

WHERE op.uuid = '59847f47-b600-4956-8b88-3bc834f19cdd'
  AND oet.uuid = '40634b19-9060-45ef-b890-6821adc82270'
  AND programEncounter.encounter_date_time IS NOT NULL
  AND programEnrolment.enrolment_date_time IS NOT NULL;



drop view if exists yenepoya_pnc_form_view;
create view yenepoya_pnc_form_view
as
SELECT individual.id                                                                                          "Ind.Id",
       individual.address_id                                                                                  "Ind.address_id",
       individual.uuid                                                                                        "Ind.uuid",
       individual.first_name                                                                                  "Ind.first_name",
       individual.last_name                                                                                   "Ind.last_name",
       g.name                                                                                                 "Ind.Gender",
       individual.date_of_birth                                                                               "Ind.date_of_birth",
       individual.date_of_birth_verified                                                                      "Ind.date_of_birth_verified",
       individual.registration_date                                                                           "Ind.registration_date",
       individual.facility_id                                                                                 "Ind.facility_id",
       a.title                                                                                             as "Ind.village",
       panchayat.title                                                                                     as "Ind.panchayat",
       surveillance_unit.title                                                                             as "Ind.surveillance_unit",
       individual.is_voided                                                                                   "Ind.is_voided",
       op.name                                                                                                "Enl.Program Name",
       programenrolment.program_exit_date_time                                                                "Enl.program_exit_date_time",
       programEnrolment.id                                                                                    "Enl.Id",
       programEnrolment.uuid                                                                                  "Enl.uuid",
       programEnrolment.is_voided                                                                             "Enl.is_voided",
       oet.name                                                                                               "Enc.Type",
       programEncounter.id                                                                                    "Enc.Id",
       programEncounter.earliest_visit_date_time                                                              "Enc.earliest_visit_date_time",
       programEncounter.encounter_date_time                                                                   "Enc.encounter_date_time",
       programEncounter.program_enrolment_id                                                                  "Enc.program_enrolment_id",
       programEncounter.uuid                                                                                  "Enc.uuid",
       programEncounter.name                                                                                  "Enc.name",
       programEncounter.max_visit_date_time                                                                   "Enc.max_visit_date_time",
       programEncounter.is_voided                                                                             "Enc.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT                          as "Ind.Contact Number",
       (programEnrolment.observations ->> 'a9440019-fc51-43a9-a695-43bbe77d2da1')::DATE                    as "Enl.Last menstrual period",
       (programEnrolment.observations ->> '448d443b-ffd6-446e-bbb9-bf1b1ef450b4')::DATE                    as "Enl.Estimated Date of Delivery",
       (programEnrolment.observations ->> '3ee9088e-8809-44d1-9e76-c5bcca84fe3b')::TEXT                    as "Enl.Gravida",
       (programEnrolment.observations ->> '368466f7-3aac-4155-a114-6269cef2e90c')::TEXT                    as "Enl.Para",
       (programEnrolment.observations ->> '9bfe3d44-73b6-4f1b-a6f1-0b85f018ff34')::TEXT                    as "Enl.No of living children",
       (programEnrolment.observations ->> '1617d0e0-83e0-4f10-ba1c-7fb24a1cc3da')::TEXT                    as "Enl.No of abortions in the past",
       (programEnrolment.observations ->> '5030abb0-43f0-41e3-b618-50ac64e57113')::TEXT                    as "Enl.Gestational age in weeks",
       single_select_coded(
               programEnrolment.observations ->> '59c70bbd-a02e-4519-8b65-8383ae59adbc')::TEXT             as "Enl.Thai card available",
       (programEnrolment.observations ->> '11682aa1-5e0e-4f76-834e-c0e4c3eb03e3')::TEXT                    as "Enl.Name of the ASHA",
       single_select_coded(
               programEnrolment.observations ->> '41ff539e-2f33-43cb-a902-036c9b114860')::TEXT             as "Enl.Is present pregnancy registered",
       (programEnrolment.observations ->> 'fff8bd3b-f054-46e4-934c-ab931117a435')::TEXT                    as "Enl.week of registration",
       single_select_coded(
               programEnrolment.observations ->> 'cb75cb80-d3a4-4a54-bd0d-82a5b76971ea')::TEXT             as "Enl.Place of registration",
       single_select_coded(
               programEnrolment.observations ->> '2fd7c36a-b025-4cb6-954c-2806e9b1269f')::TEXT             as "Enl.Early registration (<12 weeks)",
       single_select_coded(
               programEnrolment.observations ->> '184bf8da-db08-4167-b312-afcf2ab654a6')::TEXT             as "Enl.Antenatal checkup received",
       single_select_coded(
               programEnrolment.observations ->> 'a48e9723-5b93-4e1a-a8ac-43d7192c5edb')::TEXT             as "Enl.If yes, preferred place of antenatal check up",
       (programEnrolment.observations ->> '21cf25b4-7c0f-470c-9886-47ca4279bd6a')::TEXT                    as "Enl.No of antenatal visits in present pregnancy",
       single_select_coded(
               programEnrolment.observations ->> 'f8380766-d281-477a-a91f-249ee6073dec')::TEXT             as "Enl.Have you received first dose of TT",
       (programEnrolment.observations ->> '0389ab96-b15e-4fc5-872f-75bc2fabe138')::DATE                    as "Enl.Date of first dose of TT",
       single_select_coded(
               programEnrolment.observations ->> 'a4527091-7229-410f-8df0-1d2484f99169')::TEXT             as "Enl.Have you received second dose of TT",
       (programEnrolment.observations ->> 'bcafed31-d484-4a1d-b141-15f2f470d7ae')::DATE                    as "Enl.Date of second dose of TT",
       single_select_coded(
               programEnrolment.observations ->> '519d0b30-7296-481c-bc62-b9a9ec640426')::TEXT             as "Enl.Received and consumed iron and folic acid tablets",
       single_select_coded(
               programEnrolment.observations ->> '5188bc03-371a-495d-b724-385c5fbb0c58')::TEXT             as "Enl.Received and consumed calcium tablet",
       single_select_coded(
               programEnrolment.observations ->> 'dd280449-48fd-4086-9d98-fd56aebc9a3d')::TEXT             as "Enl.Received and consumed Albendazole tablet",
       (programEnrolment.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                    as "Enl.Height in CM",
       (programEnrolment.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                    as "Enl.Weight",
       (programEnrolment.observations ->> '0b5ae1e8-e44a-4457-a38a-44d5103a8fdd')::TEXT                    as "Enl.BMI",
       (programEnrolment.observations ->> 'a121ed17-61fd-4497-bb13-10ccc34c1db0')::TEXT                    as "Enl.Hemoglobin level",
       (programEnrolment.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                    as "Enl.Blood Pressure (systolic)",
       (programEnrolment.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                    as "Enl.Blood Pressure (Diastolic)",
       (programEnrolment.observations ->> '18d36389-e42d-4366-a316-053407c3a0ab')::TEXT                    as "Enl.Random blood sugar levels report",
       single_select_coded(
               programEnrolment.observations ->> '9fc68cda-63b0-4a67-9917-681f6636ff89')::TEXT             as "Enl.Availed services under PMSMA scheme",
       single_select_coded(
               programEnrolment.observations ->> 'd5ad5edc-756c-4243-b49e-514219b9f9b8')::TEXT             as "Enl.Whether received one specialist consultation",
       single_select_coded(
               programEnrolment.observations ->> 'b4ddba1a-7acc-4b28-9892-1d865dec88f6')::TEXT             as "Enl.Whether thyroid profile done",
       single_select_coded(
               programEnrolment.observations ->> '574b3d38-50c0-4085-8812-cd3c3a3294b1')::TEXT             as "Enl.Whether anomaly scan done",
       single_select_coded(
               programEnrolment.observations ->> '87f44c12-e03a-4fdd-bce1-ce0d0f487908')::TEXT             as "Enl.Received & consumed supplementary nutrition (Cooked food/TH",
       (programEnrolment.observations ->> 'f123fcf5-c94c-4a8f-8fc0-eddb4ddd200e')::TEXT                    as "Enl.IF yes how many times in a week utilized the services",
       single_select_coded(
               programEnrolment.observations ->> '646b471d-08cd-4ebe-a5ba-9a3c781d26a3')::TEXT             as "Enl.History of bleeding/leaking per vagina",
       single_select_coded(
               programEnrolment.observations ->> '3b1763e9-3a77-4976-874f-ad11e9436a92')::TEXT             as "Enl.Whether present pregnancy is twin pregnancy",
       single_select_coded(
               programEnrolment.observations ->> '0e5f1135-f3a8-4b66-8fb6-3acb74959e3a')::TEXT             as "Enl.Foetal movements felt",
       single_select_coded(
               programEnrolment.observations ->> 'c8698b30-5dac-47bc-a2d3-209bb4912aaa')::TEXT             as "Enl.Any medical illness diagnosed from last visit",
       multi_select_coded(
               programEnrolment.observations -> '141e5d6a-2882-4d76-8730-e369614c9b3f')::TEXT              as "Enl.If yes, Medical illness",
       (programEnrolment.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT                    as "Enl.Specify Other",
       single_select_coded(
               programEnrolment.observations ->> '9a4b7389-92e3-4cb2-9330-4911e9959899')::TEXT             as "Enl.If the medical illness is DM/HT/Thyroid disorder then wheth",
       single_select_coded(
               programEnrolment.observations ->> '9b338ab9-73f3-4e32-b625-914c754f52f0')::TEXT             as "Enl.History of previous cesarean section",
       multi_select_coded(
               programEnrolment.observations -> 'd06dd2e8-ae04-4288-aab3-e55c87ecfb03')::TEXT              as "Enl.Past Obstetric history",
       (programEnrolment.observations ->> '0cf117f9-fc79-438c-bfdc-3c3bbe5c8f6f')::TEXT                    as "Enl.Specify Other obstetric History",
       single_select_coded(
               programEncounter.observations ->> 'f263bd30-d350-45bf-bba4-b9c28b98dcbf')::TEXT             as "Enc.Pregnancy complications from last visit",
       multi_select_coded(
               programEncounter.observations -> 'b3773e5b-93e4-43cd-946c-2e7623254d63')::TEXT              as "Enc.Health status of new born in PNC",
       single_select_coded(
               programEncounter.observations ->> '1b12cdc2-3403-4a1b-b796-2772e1c66e81')::TEXT             as "Enc.Practicing any family planning methods",
       single_select_coded(
               programEncounter.observations ->> '31de6e7e-ba59-4416-8f79-9f668bf3b59d')::TEXT             as "Enc.IF YES specify",
       single_select_coded(
               programEncounter.observations ->> 'b355767f-f082-4292-a9c8-1ef2c6ca81b7')::TEXT             as "Enc.Immunization status of child",
       single_select_coded(
               programEncounter.observations ->> '519d0b30-7296-481c-bc62-b9a9ec640426')::TEXT             as "Enc.Received and consumed iron and folic acid tablets",
       single_select_coded(
               programEncounter.observations ->> '5188bc03-371a-495d-b724-385c5fbb0c58')::TEXT             as "Enc.Received and consumed calcium tablet",
       single_select_coded(
               programEncounter.observations ->> 'd99fa549-b82e-404c-9f26-24cc71b6c43b')::TEXT             as "Enc.Received any financial benefit under JSY",
       single_select_coded(
               programEncounter.observations ->> '6f274445-9121-4cf2-8b79-6d95be16be32')::TEXT             as "Enc.Received any financial benefit under JSSK",
       single_select_coded(
               programEncounter.observations ->> '87f44c12-e03a-4fdd-bce1-ce0d0f487908')::TEXT             as "Enc.Received & consumed supplementary nutrition (Cooked food/TH",
       (programEncounter.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                    as "Enc.Height in CM",
       (programEncounter.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                    as "Enc.Weight",
       (programEncounter.observations ->> '0b5ae1e8-e44a-4457-a38a-44d5103a8fdd')::TEXT                    as "Enc.BMI",
       (programEncounter.observations ->> 'a121ed17-61fd-4497-bb13-10ccc34c1db0')::TEXT                    as "Enc.Hemoglobin level",
       (programEncounter.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT                    as "Enc.Blood Pressure (systolic)",
       (programEncounter.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT                    as "Enc.Blood Pressure (Diastolic)",
       single_select_coded(
               programEncounter.observations ->> 'fca3dc5c-72ba-4923-b17a-ab66c1126276')::TEXT             as "Enc.Practicing exclusive breast feeding",
       (programEncounter.observations ->> '89319985-aded-4213-adeb-b694c1767d3f')::TEXT                    as "Enc.No of postnatal visits in present pregnancy (first 42 days)",
       (programEncounter.observations ->> 'a8f3aeb4-2a3d-4708-8133-587f048f1190')::TEXT                    as "Enc.No of home visits made by ASHA/ANM in present pregnancy wit",
       programEncounter.cancel_date_time                                                                      "EncCancel.cancel_date_time",
       single_select_coded(
               programEncounter.observations ->> '5592def2-fe5e-4234-9253-ca5fd0322e26')::TEXT             as "EncCancel.Reason Of Cancellation",
       (programEncounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862')::TEXT                    as "EncCancel.Other Reason of Cancellation"

FROM program_encounter programEncounter
         LEFT OUTER JOIN operational_encounter_type oet on programEncounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN program_enrolment programEnrolment
                         ON programEncounter.program_enrolment_id = programEnrolment.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT JOIN address_level a ON individual.address_id = a.id
         LEFT JOIN address_level panchayat on a.parent_id = panchayat.id
         LEFT JOIN address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
WHERE op.uuid = '59847f47-b600-4956-8b88-3bc834f19cdd'
  AND oet.uuid = '3e166862-081e-41f0-84a5-f8e3cda733bf'
  AND programEncounter.encounter_date_time IS NOT NULL
  AND programEnrolment.enrolment_date_time IS NOT NULL;

drop view if exists yenepoya_child_checklist_form_view;
create view yenepoya_child_checklist_form_view as (
    SELECT individual.id                                                                                     AS "Ind.Id",
           individual.address_id                                                                             AS "Ind.address_id",
           individual.uuid                                                                                   AS "Ind.uuid",
           individual.first_name                                                                             AS "Ind.first_name",
           individual.last_name                                                                              AS "Ind.last_name",
           g.name                                                                                            AS "Ind.Gender",
           individual.date_of_birth                                                                          AS "Ind.date_of_birth",
           individual.date_of_birth_verified                                                                 AS "Ind.date_of_birth_verified",
           individual.registration_date                                                                      AS "Ind.registration_date",
           individual.facility_id                                                                            AS "Ind.facility_id",
           village.title                                                                                     as "Ind.village",
           panchayat.title                                                                                   as "Ind.panchayat",
           surveillance_unit.title                                                                           as "Ind.surveillance_unit",
           individual.is_voided                                                                              AS "Ind.is_voided",
           (individual.observations ->>
            'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                                                    AS "Ind.Contact Number",
           programenrolment.id                                                                               AS "Enl.Id",
           programenrolment.enrolment_date_time                                                              AS "Enl.enrolment_date_time",
           programenrolment.program_exit_date_time                                                           AS "Enl.program_exit_date_time",
           programenrolment.is_voided                                                                        AS "Enl.is_voided",
           single_select_coded(
                   checklist_item.observations ->> '284354e3-78c4-41d7-830e-771aa313d171')::TEXT             as "ChecklistItem.Vaccination provider",
           u.name                                                                                               "ChecklistItem.username"
    FROM checklist_item
             JOIN checklist on checklist_item.checklist_id = checklist.id
             JOIN program_enrolment programEnrolment on checklist.program_enrolment_id = programEnrolment.id
             JOIN operational_program op ON op.program_id = programEnrolment.program_id
             JOIN individual individual ON programEnrolment.individual_id = individual.id
             JOIN gender g ON g.id = individual.gender_id
             left join address_level village on individual.address_id = village.id
             left join address_level panchayat on village.parent_id = panchayat.id
             left join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
             LEFT JOIN audit a ON checklist_item.audit_id = a.id
             LEFT JOIN users u ON a.created_by_id = u.id
    WHERE op.uuid = '4b2372a8-3198-4bd9-8863-df4d1e618948'
      AND programEnrolment.enrolment_date_time IS NOT NULL
      AND checklist_item.completion_date IS NOT NULL
);

drop view if exists yenepoya_subject_registration_enrolment_view;
create view yenepoya_subject_registration_enrolment_view as
SELECT individual.id                                                               AS "Ind.Id",
       individual.address_id                                                       AS "Ind.address_id",
       individual.uuid                                                             AS "Ind.uuid",
       individual.first_name                                                       AS "Ind.first_name",
       individual.last_name                                                        AS "Ind.last_name",
       g.name                                                                      AS "Ind.Gender",
       individual.date_of_birth                                                    AS "Ind.date_of_birth",
       extract(year from age(individual.date_of_birth))                            AS "Ind.age",
       individual.date_of_birth_verified                                           AS "Ind.date_of_birth_verified",
       individual.registration_date                                                AS "Ind.registration_date",
       individual.facility_id                                                      AS "Ind.facility_id",
       village.title                                                               as "Ind.village",
       panchayat.title                                                             as "Ind.panchayat",
       surveillance_unit.title                                                     as "Ind.surveillance_unit",
       individual.is_voided                                                        AS "Ind.is_voided",
       individual.registration_location                                            AS "Ind.registration_location",
       (single_select_coded((individual.observations ->>
                             '1de1bfa2-030a-4ccb-8381-ee5105048fa2'::text)))::text AS "Ind.Name of the surveillance Unit",
       (single_select_coded((individual.observations ->>
                             '673a87ab-78cd-42a3-a6cf-47761c8beffe'::text)))::text AS "Ind.Name of the panchayat/Ward",
       (individual.observations ->>
        'ef182a85-8f38-418e-bf0e-fcf2c3c655f0'::text)                              AS "Ind.landmark",
       (single_select_coded((individual.observations ->>
                             '1948be58-d42e-4313-8ec5-ac9ca87eb399'::text)))::text AS "Ind.Name of the PHC/UPHC",
       (individual.observations ->>
        '7868f697-abc9-4f49-8a0d-3deab5679502'::text)                              AS "Ind.Specify Other",
       (individual.observations ->>
        'e9ce5187-db1e-40cf-ad42-4b1c27d553f8'::text)                              AS "Ind.Name of the sub centre",
       (individual.observations ->>
        '558469e8-d993-45ec-9d9b-f019c3642bab'::text)                              AS "Ind.Household number",
       (individual.observations ->>
        'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text)                              AS "Ind.Contact Number",
       st.name                                                                     AS subject_type_name,
       op.name                                                                     AS program_name,
       enl.id                                                                      AS program_enrolment_id,
       enl.enrolment_date_time                                                     AS enrolment_date_time
FROM individual individual
         left join operational_subject_type st on st.subject_type_id = individual.subject_type_id
         left join program_enrolment enl on individual.id = enl.individual_id
         left join operational_program op on op.program_id = enl.program_id
         left join address_level village on individual.address_id = village.id
         left join address_level panchayat on village.parent_id = panchayat.id
         left join address_level surveillance_unit on surveillance_unit.id = panchayat.parent_id
         left join gender g on individual.gender_id = g.id;

drop view if exists yenepoya_child_enrolment_view;
create view yenepoya_child_enrolment_view
as
SELECT individual.id                                                                              "Ind.Id",
       individual.address_id                                                                      "Ind.address_id",
       individual.uuid                                                                            "Ind.uuid",
       individual.first_name                                                                      "Ind.first_name",
       individual.last_name                                                                       "Ind.last_name",
       g.name                                                                                     "Ind.Gender",
       individual.date_of_birth                                                                   "Ind.date_of_birth",
       individual.date_of_birth_verified                                                          "Ind.date_of_birth_verified",
       individual.registration_date                                                               "Ind.registration_date",
       individual.facility_id                                                                     "Ind.facility_id",
       a.title                                                                                 AS "Ind.village",
       panchayat.title                                                                         AS "Ind.panchayat",
       surveillance_unit.title                                                                 AS "Ind.surveillance_unit",
       programenrolment.id                                                                     as "Enl.Id",
       op.name                                                                                 AS "Enl.Program Name",
       programenrolment.enrolment_date_time                                                    AS "Enl.enrolment_date_time",
       programenrolment.program_exit_date_time                                                 AS "Enl.program_exit_date_time",
       individual.is_voided                                                                       "Ind.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT              as "Ind.Contact Number",
       (programEnrolment.observations ->> '2cec6829-f0c5-4c5d-8517-3a216fa34f4d')::TEXT        as "Enl.Birth order of the child",
       (programEnrolment.observations ->> 'b852e7b8-1c5f-4a7d-9262-99dd3ac2718c')::TEXT        as "Enl.Birth weight of the baby in kgs",
       single_select_coded(
               programEnrolment.observations ->> '923b2b78-6138-436b-b691-8e319c4f9c9c')::TEXT as "Enl.Colostrum given to the child",
       (programEnrolment.observations ->> '502552c4-7d2a-4e81-b6ce-acacfaf21560')::TEXT        as "Enl.Height",
       (programEnrolment.observations ->> '9f21ecb8-93a2-461f-842f-15dd5602bfb9')::TEXT        as "Enl.Present weight of the child in kgs",
       (programEnrolment.observations ->> '594d859a-65dc-45e7-ae44-fffedd1de1b8')::TEXT        as "Enl.Nutritional Status",
       (programEnrolment.observations ->> '86f5e096-cbfc-4fa3-b045-08d81f82e23c')::TEXT        as "Enl.Present Mid Arm Circumference in CM",
       single_select_coded(
               programEnrolment.observations ->> '1f0dbb20-1da6-40cb-bb69-cbee9fb570f6')::TEXT as "Enl.Child given pre-lacteal feeds like (honey, zum-zum water, cow’s milk etc)",
       (programEnrolment.observations ->> 'b78188e8-9f08-497d-8b2f-197c14c5445c')::TEXT        as "Enl.Duration of Exclusive breastfeeding in months",
       single_select_coded(
               programEnrolment.observations ->> '4fae8872-daae-4ab4-a2c0-2b3ddd59bb33')::TEXT as "Enl.Child bottle-fed or not",
       (programEnrolment.observations ->> '3e2cb7b9-9fdb-4de5-8562-070243841e54')::TEXT        as "Enl.If yes, Duration of bottle feeding in months",
       single_select_coded(
               programEnrolment.observations ->> 'e45c7db0-f3d0-44de-9f82-61238f31bf80')::TEXT as "Enl.Child weaned at 6 months of age",
       single_select_coded(
               programEnrolment.observations ->> '7e2abce5-0dfa-4fb8-8480-c5a74e3caeac')::TEXT as "Enl.Health status of the child",
       multi_select_coded(
               programEnrolment.observations -> 'e9f6eeea-5ce3-4d7a-9765-5d9540177df1')::TEXT  as "Enl.If any health complaints specify",
       single_select_coded(
               programEnrolment.observations ->> 'a35a4955-fe92-40b0-bdd6-0101cdd5af8a')::TEXT as "Enl.Child attained all developmental milestones",
       single_select_coded(
               programEnrolment.observations ->> 'cd633d8c-eef0-4396-a096-4c321fb1a44c')::TEXT as "Enl.Does the child have any deformity",
       (programEnrolment.observations ->> '6645ac75-db15-4cc7-8ba0-7695396def8e')::TEXT        as "Enl.Does the child have any known deficiency",
       single_select_coded(
               programEnrolment.observations ->> '226d2d35-d003-48a7-a699-542d9d0b8b84')::TEXT as "Enl.Child fully immunized till date",
       single_select_coded(
               programEnrolment.observations ->> '77e29849-fa61-4d63-b73f-fb9f6a61ef05')::TEXT as "Enl.Child experienced acute respiratory infection in the last 3 months",
       single_select_coded(
               programEnrolment.observations ->> 'af2c1850-88e8-4922-9987-77fba6eafb89')::TEXT as "Enl.Child experienced diarrhoea in the last 3 months",
       single_select_coded(
               programEnrolment.observations ->> '47b12e85-1b82-415d-a488-07b98be7cc76')::TEXT as "Enl.Does the child has any other health problem",
       (programEnrolment.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT        as "Enl.Specify Other"

FROM ((((((program_enrolment programenrolment
    LEFT JOIN operational_program op ON ((op.program_id = programenrolment.program_id)))
    LEFT JOIN individual individual ON ((programenrolment.individual_id = individual.id)))
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
    LEFT JOIN address_level a ON ((individual.address_id = a.id)))
    LEFT JOIN address_level panchayat ON ((a.parent_id = panchayat.id)))
         LEFT JOIN address_level surveillance_unit ON ((surveillance_unit.id = panchayat.parent_id)))
WHERE (((op.uuid)::text = '4b2372a8-3198-4bd9-8863-df4d1e618948'::text) AND
       (programenrolment.enrolment_date_time IS NOT NULL));


create view yenepoya_child_growth_followup_view as
SELECT individual.id                                                                              "Ind.Id",
       individual.address_id                                                                      "Ind.address_id",
       individual.uuid                                                                            "Ind.uuid",
       individual.first_name                                                                      "Ind.first_name",
       individual.last_name                                                                       "Ind.last_name",
       g.name                                                                                     "Ind.Gender",
       individual.date_of_birth                                                                   "Ind.date_of_birth",
       individual.date_of_birth_verified                                                          "Ind.date_of_birth_verified",
       individual.registration_date                                                               "Ind.registration_date",
       individual.facility_id                                                                     "Ind.facility_id",
       a.title                                                                                 AS "Ind.village",
       panchayat.title                                                                         AS "Ind.panchayat",
       surveillance_unit.title                                                                 AS "Ind.surveillance_unit",
       individual.is_voided                                                                       "Ind.is_voided",
       op.name                                                                                    "Enl.Program Name",
       programEnrolment.id                                                                        "Enl.Id",
       programEnrolment.uuid                                                                      "Enl.uuid",
       programEnrolment.is_voided                                                                 "Enl.is_voided",
       oet.name                                                                                   "Enc.Type",
       programEncounter.id                                                                        "Enc.Id",
       programEncounter.earliest_visit_date_time                                                  "Enc.earliest_visit_date_time",
       programEncounter.encounter_date_time                                                       "Enc.encounter_date_time",
       programEncounter.program_enrolment_id                                                      "Enc.program_enrolment_id",
       programEncounter.uuid                                                                      "Enc.uuid",
       programEncounter.name                                                                      "Enc.name",
       programEncounter.max_visit_date_time                                                       "Enc.max_visit_date_time",
       programEncounter.is_voided                                                                 "Enc.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT              as "Ind.Contact Number",
       (programEnrolment.observations ->> '2cec6829-f0c5-4c5d-8517-3a216fa34f4d')::TEXT        as "Enl.Birth order of the child",
       (programEnrolment.observations ->> 'b852e7b8-1c5f-4a7d-9262-99dd3ac2718c')::TEXT        as "Enl.Birth weight of the baby in kgs",
       single_select_coded(
               programEnrolment.observations ->> '923b2b78-6138-436b-b691-8e319c4f9c9c')::TEXT as "Enl.Colostrum given to the child",
       (programEnrolment.observations ->> '502552c4-7d2a-4e81-b6ce-acacfaf21560')::TEXT        as "Enl.Height",
       (programEnrolment.observations ->> '9f21ecb8-93a2-461f-842f-15dd5602bfb9')::TEXT        as "Enl.Present weight of the child in kgs",
       (programEnrolment.observations ->> '594d859a-65dc-45e7-ae44-fffedd1de1b8')::TEXT        as "Enl.Nutritional Status",
       (programEnrolment.observations ->> '86f5e096-cbfc-4fa3-b045-08d81f82e23c')::TEXT        as "Enl.Present Mid Arm Circumference in CM",
       single_select_coded(
               programEnrolment.observations ->> '1f0dbb20-1da6-40cb-bb69-cbee9fb570f6')::TEXT as "Enl.Child given pre-lacteal feeds like (honey, zum-zum water, cow’s milk etc)",
       (programEnrolment.observations ->> 'b78188e8-9f08-497d-8b2f-197c14c5445c')::TEXT        as "Enl.Duration of Exclusive breastfeeding in months",
       single_select_coded(
               programEnrolment.observations ->> '4fae8872-daae-4ab4-a2c0-2b3ddd59bb33')::TEXT as "Enl.Child bottle-fed or not",
       (programEnrolment.observations ->> '3e2cb7b9-9fdb-4de5-8562-070243841e54')::TEXT        as "Enl.If yes, Duration of bottle feeding in months",
       single_select_coded(
               programEnrolment.observations ->> 'e45c7db0-f3d0-44de-9f82-61238f31bf80')::TEXT as "Enl.Child weaned at 6 months of age",
       single_select_coded(
               programEnrolment.observations ->> '7e2abce5-0dfa-4fb8-8480-c5a74e3caeac')::TEXT as "Enl.Health status of the child",
       multi_select_coded(
               programEnrolment.observations -> 'e9f6eeea-5ce3-4d7a-9765-5d9540177df1')::TEXT  as "Enl.If any health complaints specify",
       single_select_coded(
               programEnrolment.observations ->> 'a35a4955-fe92-40b0-bdd6-0101cdd5af8a')::TEXT as "Enl.Child attained all developmental milestones",
       single_select_coded(
               programEnrolment.observations ->> 'cd633d8c-eef0-4396-a096-4c321fb1a44c')::TEXT as "Enl.Does the child have any deformity",
       (programEnrolment.observations ->> '6645ac75-db15-4cc7-8ba0-7695396def8e')::TEXT        as "Enl.Does the child have any known deficiency",
       single_select_coded(
               programEnrolment.observations ->> '226d2d35-d003-48a7-a699-542d9d0b8b84')::TEXT as "Enl.Child fully immunized till date",
       single_select_coded(
               programEnrolment.observations ->> '77e29849-fa61-4d63-b73f-fb9f6a61ef05')::TEXT as "Enl.Child experienced acute respiratory infection in the last 3 months",
       single_select_coded(
               programEnrolment.observations ->> 'af2c1850-88e8-4922-9987-77fba6eafb89')::TEXT as "Enl.Child experienced diarrhoea in the last 3 months",
       single_select_coded(
               programEnrolment.observations ->> '47b12e85-1b82-415d-a488-07b98be7cc76')::TEXT as "Enl.Does the child has any other health problem",
       (programEnrolment.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT        as "Enl.Specify Other",
       (programEncounter.observations ->> '502552c4-7d2a-4e81-b6ce-acacfaf21560')::TEXT        as "Enc.Height",
       (programEncounter.observations ->> '9f21ecb8-93a2-461f-842f-15dd5602bfb9')::TEXT        as "Enc.Present weight of the child in kgs",
       (programEncounter.observations ->> '594d859a-65dc-45e7-ae44-fffedd1de1b8')::TEXT        as "Enc.Nutritional Status",
       (programEncounter.observations ->> '86f5e096-cbfc-4fa3-b045-08d81f82e23c')::TEXT        as "Enc.Present Mid Arm Circumference in CM",
       single_select_coded(
               programEncounter.observations ->> '7e2abce5-0dfa-4fb8-8480-c5a74e3caeac')::TEXT as "Enc.Health status of the child",
       single_select_coded(
               programEncounter.observations ->> 'cd633d8c-eef0-4396-a096-4c321fb1a44c')::TEXT as "Enc.Does the child have any deformity",
       single_select_coded(
               programEncounter.observations ->> 'a35a4955-fe92-40b0-bdd6-0101cdd5af8a')::TEXT as "Enc.Child attained all developmental milestones",
       (programEncounter.observations ->> '6645ac75-db15-4cc7-8ba0-7695396def8e')::TEXT        as "Enc.Does the child have any known deficiency",
       single_select_coded(
               programEncounter.observations ->> '226d2d35-d003-48a7-a699-542d9d0b8b84')::TEXT as "Enc.Child fully immunized till date",
       single_select_coded(
               programEncounter.observations ->> '653c3368-bc21-4a39-a834-cf5f27325d1d')::TEXT as "Enc.Whether your child had the fast or difficult breathing due to a problem in the chest or to a blocked or runny nose in last 3 months?",
       single_select_coded(
               programEncounter.observations ->> '77e29849-fa61-4d63-b73f-fb9f6a61ef05')::TEXT as "Enc.Child experienced acute respiratory infection in the last 3 months",
       single_select_coded(
               programEncounter.observations ->> '33861da7-a628-4f7c-9b72-891eeb85c9e7')::TEXT as "Enc.Whether Child had fever in the last 3 months",
       single_select_coded(
               programEncounter.observations ->> 'af2c1850-88e8-4922-9987-77fba6eafb89')::TEXT as "Enc.Child experienced diarrhoea in the last 3 months",
       single_select_coded(
               programEncounter.observations ->> '47b12e85-1b82-415d-a488-07b98be7cc76')::TEXT as "Enc.Does the child has any other health problem",
       single_select_coded(
               programEncounter.observations ->> '141f724d-4171-4eb0-b4c2-6e3a2365df31')::TEXT as "Enc.Whether the  newborn child received all home based newborn care visits by ASHA during first month of delivery",
       programEncounter.cancel_date_time                                                          "EncCancel.cancel_date_time",
       single_select_coded(
               programEncounter.observations ->> '5592def2-fe5e-4234-9253-ca5fd0322e26')::TEXT as "EncCancel.Reason Of Cancellation",
       (programEncounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862')::TEXT        as "EncCancel.Other Reason of Cancellation"
FROM program_encounter programEncounter
         LEFT OUTER JOIN operational_encounter_type oet on programEncounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN program_enrolment programEnrolment
                         ON programEncounter.program_enrolment_id = programEnrolment.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
         LEFT JOIN address_level panchayat ON ((a.parent_id = panchayat.id))
         LEFT JOIN address_level surveillance_unit ON ((surveillance_unit.id = panchayat.parent_id))
WHERE op.uuid = '4b2372a8-3198-4bd9-8863-df4d1e618948'
  AND oet.uuid = 'bcd9b84b-2558-44ad-9d85-113c29fc2e0a'
  AND programEncounter.encounter_date_time IS NOT NULL
  AND programEnrolment.enrolment_date_time IS NOT NULL;


