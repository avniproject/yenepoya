
create view yenepoya_history_of_fever_form_view
            ("Ind.Id", "Ind.address_id",
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
             "Enc.Type",
             "Enc.Id",
             "Enc.earliest_visit_date_time",
             "Enc.encounter_date_time",
             "Enc.uuid",
             "Enc.name",
             "Enc.max_visit_date_time",
             "Enc.is_voided",
             "Ind.Contact Number",
             "Enc.History of fever in last 15 days", "Enc.Have you consulted the doctor",
             "Enc.Was malaria/dengue test done", "Enc.Specify the test result", "Enc.Treatment taken",
             "Enc.Type of health facility utilized for diagnosis", "Enc.Type of health facility utilized for treatment",
             "Enc.Have you taken the full course of treatment", "Enc.Are you practising any mosquito prevention method",
             "Enc.Mention the method", "Enc.Any collection of water in surrounding", "Enc.Surce of water collection",
             "Enc.Have you been provided LLIN by Govt. health workers", "Enc.Are you utilizing the LLIN?",
             "Enc.Any Govt. health worker/MPW visited house in past 3 months",
                 "Enc.Are you aware of mosquito control other than LLIN?",
             "Enc.What mosquito control measures are you aware of? mention.",
             "Enc.Type of health care utilization",
             "Enc.If government,
              then",
             "Enc.If private,
              then",
             "Enc.Are you aware of 24*7 hour Mobile Malaria Detection Unit?",
             "Enc.Have you utilized 24*7 hour Mobile Malaria Detection Unit?",
             "EncCancel.cancel_date_time",
             "EncCancel.Reason Of Cancellation",
             "EncCancel.Other Reason of Cancellation"
                )
as
SELECT individual.id                                                                                 "Ind.Id",
       individual.address_id                                                                         "Ind.address_id",
       individual.uuid                                                                               "Ind.uuid",
       individual.first_name                                                                         "Ind.first_name",
       individual.last_name                                                                          "Ind.last_name",
       g.name                                                                                        "Ind.Gender",
       individual.date_of_birth                                                                      "Ind.date_of_birth",
       individual.date_of_birth_verified                                                             "Ind.date_of_birth_verified",
       individual.registration_date                                                                  "Ind.registration_date",
       individual.facility_id                                                                        "Ind.facility_id",
       a.title                                                                                       "Ind.Area",
       individual.is_voided                                                                          "Ind.is_voided",
       oet.name                                                                                      "Enc.Type",
       encounter.id                                                                                  "Enc.Id",
       encounter.earliest_visit_date_time                                                            "Enc.earliest_visit_date_time",
       encounter.encounter_date_time                                                                 "Enc.encounter_date_time",
       encounter.uuid                                                                                "Enc.uuid",
       encounter.name                                                                                "Enc.name",
       encounter.max_visit_date_time                                                                 "Enc.max_visit_date_time",
       encounter.is_voided                                                                           "Enc.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT                 as "Ind.Contact Number",
       single_select_coded(
               encounter.observations ->> '59d2e12f-1d6d-4fac-9d9a-cae3ca021269')::TEXT           as "Enc.History of fever in last 15 days",
       single_select_coded(
               encounter.observations ->> '900b7304-3936-4ad7-bd59-3bf42a4cde64')::TEXT           as "Enc.Have you consulted the doctor",
       single_select_coded(
               encounter.observations ->> '38f12c1d-2536-4932-84f5-cf977a4a0e25')::TEXT           as "Enc.Was malaria/dengue test done",
       single_select_coded(
               encounter.observations ->> '08110960-7364-43ed-8990-afdcb47e975b')::TEXT           as "Enc.Specify the test result",
       single_select_coded(
               encounter.observations ->> '87fa4bfa-c929-4c12-a328-bc2620b7db79')::TEXT           as "Enc.Treatment taken",
       single_select_coded(
               encounter.observations ->> 'b0a3576e-3379-4105-afec-c37dddde80db')::TEXT           as "Enc.Type of health facility utilized for diagnosis",
       single_select_coded(
               encounter.observations ->> '0b267bfd-6c1a-43dd-a953-0b31e300ba6d')::TEXT           as "Enc.Type of health facility utilized for treatment",
       single_select_coded(
               encounter.observations ->> '162edcfb-6c3f-49a6-9024-608ff7f74c35')::TEXT           as "Enc.Have you taken the full course of treatment",
       single_select_coded(
               encounter.observations ->> 'a75978ab-b246-4500-b212-dc25e327c09a')::TEXT           as "Enc.Are you practising any mosquito prevention method",
       multi_select_coded(
               encounter.observations -> '9baaadc0-479b-44b3-87d3-4abc0fdb67a4')::TEXT            as "Enc.Mention the method",
       single_select_coded(
               encounter.observations ->> 'b82ec179-0c04-4c9c-a2e9-ed94834084a4')::TEXT           as "Enc.Any collection of water in surrounding",
       multi_select_coded(
               encounter.observations -> '0afc590f-5a27-44f2-94a6-28c2f8bc92a7')::TEXT            as "Enc.Surce of water collection",
       single_select_coded(
               encounter.observations ->> '12eb504d-f7c2-4e27-a690-3030511f135a')::TEXT           as "Enc.Have you been provided LLIN by Govt. health workers",
       single_select_coded(
               encounter.observations ->> '687e6e05-4103-4270-b76c-18521df8cf1f')::TEXT           as "Enc.Are you utilizing the LLIN?",
       single_select_coded(
               encounter.observations ->> 'cc9fcdfe-8465-4ff8-b28d-f3ad246b499b')::TEXT           as "Enc.Any Govt. health worker/MPW visited house in past 3 months",
       single_select_coded(
               encounter.observations ->> '2a19b6ac-896e-42e5-b3d6-c45896a7df35')::TEXT           as "Enc.Are you aware of mosquito control other than LLIN?",
       multi_select_coded(
               encounter.observations -> '3eeacd19-1d67-4a1a-9d39-0c919968cbf8')::TEXT            as "Enc.What mosquito control measures are you aware of? mention.",
       multi_select_coded(
               encounter.observations -> '9b031289-dcfa-4ccd-a868-cee9d2d33cba')::TEXT            as "Enc.Type of health care utilization",
       multi_select_coded(encounter.observations -> '92ca8513-897b-4d73-8b55-fbed59f19b56')::TEXT as "Enc.If government,
 then",
       multi_select_coded(encounter.observations -> '8290ba03-6b33-4f5e-a8af-a22a376099ad')::TEXT as "Enc.If private,
 then",
       single_select_coded(
               encounter.observations ->> '44154176-fc48-4ae6-9fe6-d534ad7f7c93')::TEXT           as "Enc.Are you aware of 24*7 hour Mobile Malaria Detection Unit?",
       single_select_coded(
               encounter.observations ->> 'e224f89f-f9a1-4731-9c05-3ce61d46eef5')::TEXT           as "Enc.Have you utilized 24*7 hour Mobile Malaria Detection Unit?",
       encounter.cancel_date_time                                                                    "EncCancel.cancel_date_time",
       single_select_coded(
               encounter.observations ->> '5592def2-fe5e-4234-9253-ca5fd0322e26')::TEXT           as "EncCancel.Reason Of Cancellation",
       (encounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862')::TEXT                  as "EncCancel.Other Reason of Cancellation"
FROM encounter encounter
         LEFT OUTER JOIN operational_encounter_type oet on encounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN individual individual ON encounter.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
WHERE oet.uuid = '0e511773-157a-400c-837c-33e46a30b71e'
  AND encounter.encounter_date_time IS NOT NULL;
