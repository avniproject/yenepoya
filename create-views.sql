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
                   encounter.observations -> 'c5c9d1b4-54f8-4676-ba39-18d9a5f3c7a3')::TEXT   as "Enc.Are there any individuals in your family with known case of chronic illness?",
           (encounter.observations ->> 'caa23e49-901e-43ac-a246-33a16e83493a')::TEXT         as "Enc.Specify  known case of chronic illness",
           multi_select_coded(
                   encounter.observations -> '0b5215d5-f721-4993-8f30-b85f5b397988')::TEXT   as "Enc.Are there any individuals in your family with any illness in last two weeks?",
           (encounter.observations ->> '9b12024d-08e0-486b-b4b9-ddc21b6f199d')::TEXT         as "Enc.Specify illness in last two weeks",
           single_select_coded(
                   encounter.observations ->> '2a1c24fd-912a-485d-bf8e-5a722d8ab5a1')::TEXT  as "Enc.Any member in your family with some disability",
           (encounter.observations ->> '71124244-b1e2-42a7-82b3-15b79524352e')::TEXT         as "Enc.If Yes give details about disability",
           (encounter.observations ->> '00edb1c7-acda-4982-a414-0ea121f616bf')::TEXT         as "Enc.Household Total Expenditure per month",
           single_select_coded(
                   encounter.observations ->> '0cff16cb-8018-4908-aecc-9d6410b797d1')::TEXT  as "Enc.Out-of-pocket payments equalling or exceeding 10% of a household’s total expenditure.",
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
                   encounter.observations ->> '09acf590-7148-4ec1-b5a0-3ab34309d153')::TEXT  as "Enc.Is open air defecation practiced by any of the family member (Children)",
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
           (encounter.observations ->> '54a36cb8-a7a0-415d-84c7-2ca4b88e8f87')::TEXT         as "Enc.Specify Name the health facility preferred for chronic illness",
           single_select_coded(
                   encounter.observations ->> 'da29256e-720c-4071-a8f4-9e563749aef1')::TEXT  as "Enc.Health facility preferred for acute illness",
           multi_select_coded(
                   encounter.observations -> '84a7b976-1730-479f-926a-dcdaac00b876')::TEXT   as "Enc.Name the Health facility preferred for acute illness",
           (encounter.observations ->> '1a436a53-b279-49b1-87b4-efad33a34a4d')::TEXT         as "Enc.Specify other acute illness",
           multi_select_coded(
                   encounter.observations -> '5987c751-0e34-4e76-aa1a-95b31d7af765')::TEXT   as "Enc.Reason of visiting preferred health care facility",
           (encounter.observations ->> '4239ddc6-60cc-4ac0-ad7d-3d35bf2caace')::TEXT         as "Enc.Specify Reason of visiting preferred health care facility",
           single_select_coded(
                   encounter.observations ->> '67c33f11-2358-4360-8b86-65633232c773')::TEXT  as "Enc.If someone from your family is having some mentalillness,whether she/he is availing the health services",
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


set role none;
