--[Data Extract Report]
set role yenepoya;


create view yenepoya_ncd_followup_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name",
             "Ind.Gender", "Ind.date_of_birth", "Ind.date_of_birth_verified",
             "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Id",
             "Enc.Type", "Enc.Id",
             "Enc.earliest_visit_date_time", "Enc.encounter_date_time",
             "Enc.program_enrolment_id",
             "Enc.uuid",
             "Enc.name", "Enc.max_visit_date_time",
             "Enc.is_voided", "Enc.Smoking or consume smokeless products", "Enc.Alcohol consumption",
             "Enc.Height in CM",
             "Enc.Weight",
             "Enc.Mid arm circumference",
             "Enc.Waist circumference",
             "Enc.Physical activity for >150 min/week",
             "Enc.Are you practicing any Yoga",
             "Enc.Family histroy of high BP, DM or heart disease",
             "Enc.Difficulty in opening mouth",
             "Enc.Ulcer/ patch/ growth in mouth that has not healed for 2 weeks",
             "Enc.Whether change in the tone of voice",
             "Enc.Lump in the breast",
             "Enc.Blood stained discharge from nipple",
             "Enc.Change in shape and size of breast",
             "Enc.Bleeding between periods",
             "Enc.Bleeding after menopause",
             "Enc.Bleeding after intercourse",
             "Enc.Foul smelling vaginal discharge",
             "EncCancel.cancel_date_time", "EncCancel.Reason Of Cancellation",
             "EncCancel.Other Reason of Cancellation", "rank"
                )

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
       single_select_coded(
               programEncounter.observations ->> '0fc3b733-0ee0-4554-b316-e5e29c1978d2')::TEXT           as "Enc.Smoking or consume smokeless products",
       single_select_coded(
               programEncounter.observations ->> 'ac4d5664-0b5f-467f-a3c9-c0e4c8c221b7')::TEXT           as "Enc.Alcohol consumption",
       (programEncounter.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT                  as "Enc.Height in CM",
       (programEncounter.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT                  as "Enc.Weight",
       (programEncounter.observations ->> '44a608f8-54d3-4a8b-96b8-7175c65e1d01')::TEXT                  as "Enc.Mid arm circumference",
       (programEncounter.observations ->> 'a9f45a38-99a7-4fd8-8e28-1291434eace0')::TEXT                  as "Enc.Waist circumference",
       single_select_coded(
               programEncounter.observations ->> 'dfdc75c1-5a47-4aae-887c-3ee9f050d75e')::TEXT           as "Enc.Physical activity for >150 min/week",
       single_select_coded(
               programEncounter.observations ->> '3e092c91-8e32-42b1-ac26-045b846e3893')::TEXT           as "Enc.Are you practicing any Yoga",
       single_select_coded(
               programEncounter.observations ->> '8f67d53a-07bf-4652-b7ad-f2f6ef6bdfa2')::TEXT           as "Enc.Family histroy of high BP, DM or heart disease",
       single_select_coded(
               programEncounter.observations ->> '83f01615-04b1-4115-84a5-48e89c9aff54')::TEXT           as "Enc.Difficulty in opening mouth",
       single_select_coded(
               programEncounter.observations ->> '5e4d8a9d-28a5-49ec-a4c9-cd9cfd4dd134')::TEXT           as "Enc.Ulcer/ patch/ growth in mouth that has not healed for 2 weeks",
       single_select_coded(
               programEncounter.observations ->> '89bf3601-d8ab-4353-85a3-8070a959394e')::TEXT           as "Enc.Whether change in the tone of voice",
       single_select_coded(
               programEncounter.observations ->> 'd9f8ee0c-960f-43d7-9b02-aa2557a9aa10')::TEXT           as "Enc.Lump in the breast",
       single_select_coded(
               programEncounter.observations ->> '74745370-ee9e-4f58-b25e-57ebac69d75d')::TEXT           as "Enc.Blood stained discharge from nipple",
       single_select_coded(
               programEncounter.observations ->> '2da75202-7f70-4a76-a8eb-cd9b289cdf8a')::TEXT           as "Enc.Change in shape and size of breast",
       single_select_coded(
               programEncounter.observations ->> '45f02196-217b-4772-8085-3d17c41244da')::TEXT           as "Enc.Bleeding between periods",
       single_select_coded(
               programEncounter.observations ->> 'd1774f83-ee28-41b8-9cb8-309098ee0f16')::TEXT           as "Enc.Bleeding after menopause",
       single_select_coded(
               programEncounter.observations ->> '82efa85a-46a9-4c75-8c53-c488b8c48c54')::TEXT           as "Enc.Bleeding after intercourse",
       single_select_coded(
               programEncounter.observations ->> '84a99b8c-f9bb-4436-9d83-d79a60a0b450')::TEXT           as "Enc.Foul smelling vaginal discharge",
       programEncounter.cancel_date_time                                                                    "EncCancel.cancel_date_time",
       single_select_coded(
               programEncounter.observations ->> '5592def2-fe5e-4234-9253-ca5fd0322e26')::TEXT           as "EncCancel.Reason Of Cancellation",
       (programEncounter.observations ->> '8263f129-5851-4f9d-a909-818dacacd862')::TEXT                  as "EncCancel.Other Reason of Cancellation",
       row_number() OVER (PARTITION BY individual.id ORDER BY programEncounter.encounter_date_time DESC) AS rank

FROM program_encounter programEncounter
         LEFT OUTER JOIN operational_encounter_type oet on programEncounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN program_enrolment programEnrolment
                         ON programEncounter.program_enrolment_id = programEnrolment.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
WHERE op.uuid = '85a36148-26a2-4a30-921c-5c1fc64e8acc'
  AND oet.uuid = 'b0d16b85-218c-4392-999c-4fa19476cf42'
  AND programEncounter.encounter_date_time IS NOT NULL
  AND programEnrolment.enrolment_date_time IS NOT NULL;



"Enc.Abnormal waist circumference",
 "Enc.Waist circumference is normal",
 "Enc.Physical activity for >150 min/week",
 "Enc.Are you practicing any Yoga",
 "Enc.Family histroy of high BP, DM or heart disease",
 "Enc.Difficulty in opening mouth",
 "Enc.Ulcer/ patch/ growth in mouth that has not healed for 2 weeks",
 "Enc.Whether change in the tone of voice",
 "Enc.Lump in the breast",
 "Enc.Blood stained discharge from nipple",
 "Enc.Change in shape and size of breast",
 "Enc.Bleeding between periods",
 "Enc.Bleeding after menopause",
 "Enc.Bleeding after intercourse",
 "Enc.Foul smelling vaginal discharge",