create view yenepoya_diabetes_enrolment_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name",
             "Ind.Gender", "Ind.date_of_birth", "Ind.date_of_birth_verified",
             "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Program Name", "Enl.Id", "Enl.uuid", "Enl.is_voided",
             "Ind.Contact Number", "Enl.Adherence to medications",
             "Enl.Do you check your foot daily",
             "Enl.What about your physical activity",
             "Enl.Alcohol use in last 1 year",
             "Enl.What about the use of tobacco",
             "Enl.Eating of fast foods like fried and bakery items weekly",
             "Enl.Habit of vegetable intake atleast 3 servings daily",
             "Enl.Habit of fruit intake atleast 3 servings daily", "Enl.Height in CM",
             "Enl.Weight",
             "Enl.Mid arm circumference",
             "Enl.Waist circumference", "Enl.Abnormal waist circumference",
             "Enl.Waist circumference is normal",
             "Enl.Blood Pressure (systolic)",
             "Enl.Blood Pressure (Diastolic)",
             "Enl.Fasting blood sugar level reports in last one month",
             "Enl.Post prandial blood sugar level reports in last one month",
             "Enl.Random blood sugar levels report",
             "Enl.Whether your blood sugar level is under control")

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
       a.title                                                                                    "Ind.Area",
       individual.is_voided                                                                       "Ind.is_voided",
       op.name                                                                                    "Enl.Program Name",
       programEnrolment.id                                                                        "Enl.Id",
       programEnrolment.uuid                                                                      "Enl.uuid",
       programEnrolment.is_voided                                                                 "Enl.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT              as "Ind.Contact Number",
       single_select_coded(
               programEnrolment.observations ->> '1341e326-d2b5-4cbc-b09a-108e10a84808')::TEXT as "Enl.Adherence to medications",
       single_select_coded(
               programEnrolment.observations ->> '644a912d-beb9-4140-a629-c6639b304e67')::TEXT as "Enl.Do you check your foot daily",
       single_select_coded(
               programEnrolment.observations ->> 'd7e707f2-4c4e-47e8-8907-7dab7770fc89')::TEXT as "Enl.What about your physical activity",
       single_select_coded(
               programEnrolment.observations ->> '29e472b6-0478-4de5-89f9-d7a4a373ff42')::TEXT as "Enl.Alcohol use in last 1 year",
       single_select_coded(
               programEnrolment.observations ->> 'ec3e201d-f4de-4705-b954-02c750ca5063')::TEXT as "Enl.What about the use of tobacco",
       single_select_coded(
               programEnrolment.observations ->> '182d8aef-512d-4d50-8fd8-95cb01f3ccbe')::TEXT as "Enl.Eating of fast foods like fried and bakery items weekly",
       single_select_coded(
               programEnrolment.observations ->> 'd31251b0-616a-47d5-84d6-7b5fad85baad')::TEXT as "Enl.Habit of vegetable intake atleast 3 servings daily",
       single_select_coded(
               programEnrolment.observations ->> '2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d')::TEXT as "Enl.Habit of fruit intake atleast 3 servings daily",
       (programEnrolment.observations ->> '80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT        as "Enl.Height in CM",
       (programEnrolment.observations ->> 'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT        as "Enl.Weight",
       (programEnrolment.observations ->> '44a608f8-54d3-4a8b-96b8-7175c65e1d01')::TEXT        as "Enl.Mid arm circumference",
       (programEnrolment.observations ->> 'a9f45a38-99a7-4fd8-8e28-1291434eace0')::TEXT        as "Enl.Waist circumference",
       single_select_coded(
               programEnrolment.observations ->> 'c78e883a-60de-4629-8d85-8e4512cd13d5')::TEXT as "Enl.Abnormal waist circumference",
       single_select_coded(
               programEnrolment.observations ->> '1cae9bd0-0dba-4479-954a-2d569c58d711')::TEXT as "Enl.Waist circumference is normal",
       (programEnrolment.observations ->> '7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT        as "Enl.Blood Pressure (systolic)",
       (programEnrolment.observations ->> 'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT        as "Enl.Blood Pressure (Diastolic)",
       (programEnrolment.observations ->> '3e30648a-5829-45bb-b2ef-f797462c397e')::TEXT        as "Enl.Fasting blood sugar level reports in last one month",
       (programEnrolment.observations ->> '22868608-488a-4be8-9dd3-d2c50fe1f6aa')::TEXT        as "Enl.Post prandial blood sugar level reports in last one month",
       (programEnrolment.observations ->> '18d36389-e42d-4366-a316-053407c3a0ab')::TEXT        as "Enl.Random blood sugar levels report",
       single_select_coded(
               programEnrolment.observations ->> '319c1184-2afb-4e10-9523-840645b6a130')::TEXT as "Enl.Whether your blood sugar level is under control"

FROM program_enrolment programEnrolment
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id

         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
WHERE op.uuid = '2106f644-da4e-46cd-9940-a495be09d857'
  AND programEnrolment.enrolment_date_time IS NOT NULL;
alter table yenepoya_diabetes_enrolment_view
    owner to yenepoya;