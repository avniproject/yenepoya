
create view yenepoya_ncd_enrolment_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name",
             "Ind.Gender", "Ind.date_of_birth", "Ind.date_of_birth_verified",
             "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Program Name", "Enl.Id", "Enl.uuid", "Enl.is_voided",
             "Ind.Contact Number", "Enl.Smoking or consume smokeless products",
             "Enl.Alcohol consumption", "Enl.Height in CM",
             "Enl.Weight",
             "Enl.Mid arm circumference",
             "Enl.Waist circumference", "Enl.Abnormal waist circumference",
             "Enl.Waist circumference is normal","Enl.Physical activity for >150 min/week",
             "Enl.Are you practicing any Yoga",
             "Enl.Family histroy of high BP, DM or heart disease",
             "Enl.Difficulty in opening mouth",
             "Enl.Ulcer/ patch/ growth in mouth that has not healed for 2 weeks",
             "Enl.Whether change in the tone of voice",
             "Enl.Lump in the breast",
             "Enl.Blood stained discharge from nipple",
             "Enl.Change in shape and size of breast",
             "Enl.Bleeding between periods",
             "Enl.Bleeding after menopause",
             "Enl.Bleeding after intercourse",
             "Enl.Foul smelling vaginal discharge")

as
SELECT
  individual.id "Ind.Id",
  individual.address_id "Ind.address_id",
  individual.uuid "Ind.uuid",
  individual.first_name "Ind.first_name",
  individual.last_name "Ind.last_name",
  g.name "Ind.Gender",
  individual.date_of_birth "Ind.date_of_birth",
  individual.date_of_birth_verified "Ind.date_of_birth_verified",
  individual.registration_date "Ind.registration_date",
  individual.facility_id  "Ind.facility_id",
  a.title "Ind.Area",
  individual.is_voided "Ind.is_voided",
  op.name "Enl.Program Name",
  programEnrolment.id  "Enl.Id",
  programEnrolment.uuid  "Enl.uuid",
  programEnrolment.is_voided "Enl.is_voided",
  (individual.observations->>'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT as "Ind.Contact Number",
  single_select_coded(programEnrolment.observations->>'0fc3b733-0ee0-4554-b316-e5e29c1978d2')::TEXT as "Enl.Smoking or consume smokeless products",
single_select_coded(programEnrolment.observations->>'ac4d5664-0b5f-467f-a3c9-c0e4c8c221b7')::TEXT as "Enl.Alcohol consumption",
(programEnrolment.observations->>'80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT as "Enl.Height in CM",
(programEnrolment.observations->>'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT as "Enl.Weight",
(programEnrolment.observations->>'44a608f8-54d3-4a8b-96b8-7175c65e1d01')::TEXT as "Enl.Mid arm circumference",
(programEnrolment.observations->>'a9f45a38-99a7-4fd8-8e28-1291434eace0')::TEXT as "Enl.Waist circumference",
single_select_coded(programEnrolment.observations->>'c78e883a-60de-4629-8d85-8e4512cd13d5')::TEXT as "Enl.Abnormal waist circumference",
single_select_coded(programEnrolment.observations->>'1cae9bd0-0dba-4479-954a-2d569c58d711')::TEXT as "Enl.Waist circumference is normal",
single_select_coded(programEnrolment.observations->>'dfdc75c1-5a47-4aae-887c-3ee9f050d75e')::TEXT as "Enl.Physical activity for >150 min/week",
single_select_coded(programEnrolment.observations->>'3e092c91-8e32-42b1-ac26-045b846e3893')::TEXT as "Enl.Are you practicing any Yoga",
single_select_coded(programEnrolment.observations->>'8f67d53a-07bf-4652-b7ad-f2f6ef6bdfa2')::TEXT as "Enl.Family histroy of high BP, DM or heart disease",
single_select_coded(programEnrolment.observations->>'83f01615-04b1-4115-84a5-48e89c9aff54')::TEXT as "Enl.Difficulty in opening mouth",
single_select_coded(programEnrolment.observations->>'5e4d8a9d-28a5-49ec-a4c9-cd9cfd4dd134')::TEXT as "Enl.Ulcer/ patch/ growth in mouth that has not healed for 2 weeks",
single_select_coded(programEnrolment.observations->>'89bf3601-d8ab-4353-85a3-8070a959394e')::TEXT as "Enl.Whether change in the tone of voice",
single_select_coded(programEnrolment.observations->>'d9f8ee0c-960f-43d7-9b02-aa2557a9aa10')::TEXT as "Enl.Lump in the breast",
single_select_coded(programEnrolment.observations->>'74745370-ee9e-4f58-b25e-57ebac69d75d')::TEXT as "Enl.Blood stained discharge from nipple",
single_select_coded(programEnrolment.observations->>'2da75202-7f70-4a76-a8eb-cd9b289cdf8a')::TEXT as "Enl.Change in shape and size of breast",
single_select_coded(programEnrolment.observations->>'45f02196-217b-4772-8085-3d17c41244da')::TEXT as "Enl.Bleeding between periods",
single_select_coded(programEnrolment.observations->>'d1774f83-ee28-41b8-9cb8-309098ee0f16')::TEXT as "Enl.Bleeding after menopause",
single_select_coded(programEnrolment.observations->>'82efa85a-46a9-4c75-8c53-c488b8c48c54')::TEXT as "Enl.Bleeding after intercourse",
single_select_coded(programEnrolment.observations->>'84a99b8c-f9bb-4436-9d83-d79a60a0b450')::TEXT as "Enl.Foul smelling vaginal discharge"

FROM program_enrolment programEnrolment
  LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
  LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
  LEFT OUTER JOIN gender g ON g.id = individual.gender_id
  LEFT OUTER JOIN address_level a ON individual.address_id = a.id
WHERE op.uuid = '85a36148-26a2-4a30-921c-5c1fc64e8acc'
  AND programEnrolment.enrolment_date_time IS NOT NULL;
