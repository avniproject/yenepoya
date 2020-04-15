--[Data Extract Report] Registration

SELECT individual.id                                                                                 as "Ind.Id",
       individual.address_id                                                                         as "Ind.address_id",
       individual.uuid                                                                               as "Ind.uuid",
       individual.first_name                                                                         as "Ind.first_name",
       individual.last_name                                                                          as "Ind.last_name",
       g.name                                                                                        as "Ind.Gender",
       individual.date_of_birth                                                                      as "Ind.date_of_birth",
       individual.date_of_birth_verified                                                             as "Ind.date_of_birth_verified",
       individual.registration_date                                                                  as "Ind.registration_date",
       individual.facility_id                                                                        as "Ind.facility_id",
       a.title                                                                                       as "Ind.Area",
       individual.is_voided                                                                          as "Ind.is_voided",
       single_select_coded(
               individual.observations ->> '1de1bfa2-030a-4ccb-8381-ee5105048fa2')::TEXT             as "Ind.Name of the surveillance Unit",
       single_select_coded(
               individual.observations ->> '673a87ab-78cd-42a3-a6cf-47761c8beffe')::TEXT             as "Ind.Name of the panchayat/Ward",
       (individual.observations ->> 'ef182a85-8f38-418e-bf0e-fcf2c3c655f0')::TEXT                    as "Ind.landmark",
       single_select_coded(
               individual.observations ->> '1948be58-d42e-4313-8ec5-ac9ca87eb399')::TEXT             as "Ind.Name of the PHC/UPHC",
       (individual.observations ->> '7868f697-abc9-4f49-8a0d-3deab5679502')::TEXT                    as "Ind.Specify Other",
       (individual.observations ->> 'e9ce5187-db1e-40cf-ad42-4b1c27d553f8')::TEXT                    as "Ind.Name of the sub centre",
       (individual.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab')::TEXT                    as "Ind.Household number",
       (individual.observations ->> '6633afc7-d0e4-4427-87d4-277d8942ff48')::TEXT                    as "Ind.Name of the head of the family",
       single_select_coded(
               individual.observations ->> '83fbfa4c-164e-4eb2-b207-d9263c1b3b4d')::TEXT             as "Ind.Gender of HoF",
       single_select_coded(
               individual.observations ->> '52a8b9a2-499b-4362-a95f-4df018cd644a')::TEXT             as "Ind.Type of family",
       (individual.observations ->> '752cf346-243e-447a-a973-53891cb110b0')::TEXT                    as "Ind.Total Income",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT                    as "Ind.Contact Number",
       single_select_coded(
               individual.observations ->> '57251d49-3cfb-4e49-a053-7364a663bf1d')::TEXT             as "Ind.Mother Tongue",
       (individual.observations ->> 'f2058089-18f8-4442-84cf-94cf1cea28a6')::TEXT                    as "Ind.Other mother tongue",
       single_select_coded(
               individual.observations ->> '60320b20-433d-4167-84e2-5cea3351739f')::TEXT             as "Ind.Which religion do you practice?",
       single_select_coded(
               individual.observations ->> '26024a7b-b664-4eef-90e4-1fe23283378f')::TEXT             as "Ind.You belong to which social class?",
       (individual.observations ->> '81323643-274c-4831-9d1a-a17e2dfcd225')::TEXT                    as "Ind.Other social class",
       single_select_coded(
               individual.observations ->> '2253872c-c629-4f6f-96bc-72ba23892290')::TEXT             as "Ind.Are you resident of this area for more than 1 year",
       single_select_coded(
               individual.observations ->> '49344ffb-d10c-4e30-a284-356396970bcf')::TEXT             as "Ind.Type of Ration card"
FROM individual individual
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
where subject_type_id = (select id from subject_type where name = 'Household')