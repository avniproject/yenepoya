drop view yenepoya_hypertension_followup_view;

create view yenepoya_hypertension_followup_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name",
             "Ind.Gender", "Ind.date_of_birth", "Ind.date_of_birth_verified",
             "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Enl.Id", "Enc.Type",
             "Enc.Id",
             "Enc.earliest_visit_date_time",
             "Enc.encounter_date_time",
             "Enc.program_enrolment_id",
             "Enc.uuid",
             "Enc.name",
             "Enc.max_visit_date_time",
             "Enc.is_voided", "Ind.Contact Number", "Enc.Adherence to medications",
             "Enc.Do you check your foot daily",
             "Enc.What about your physical activity",
             "Enc.Alcohol use in last 1 year",
             "Enc.What about the use of tobacco",
             "Enc.Eating of fast foods like fried and bakery items weekly",
             "Enc.preference for food with excess salt",
             "Enc.Habit of vegetable intake atleast 3 servings daily",
             "Enc.Habit of fruit intake atleast 3 servings daily", "Enc.Height in CM",
             "Enc.weight",
             "Enc.mid arm circumference",
             "Enc.waist circumference",
             "Enc.blood Pressure (systolic)",
             "Enc.blood Pressure (Diastolic)",
            "Enc.whether your blood sugar level is under control","EncCancel.cancel_date_time",
                "EncCancel.Reason Of Cancellation",
             "EncCancel.Other Reason of Cancellation",   "rank")

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
      programEnrolment.id  "Enl.Id",
    oet.name "Enc.Type",
    programEncounter.id "Enc.Id",
    programEncounter.earliest_visit_date_time "Enc.earliest_visit_date_time",
    programEncounter.encounter_date_time "Enc.encounter_date_time",
    programEncounter.program_enrolment_id "Enc.program_enrolment_id",
    programEncounter.uuid "Enc.uuid",
    programEncounter.name "Enc.name",
    programEncounter.max_visit_date_time "Enc.max_visit_date_time",
    programEncounter.is_voided "Enc.is_voided",
    (individual.observations->>'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT as "Ind.Contact Number",
    single_select_coded(programEncounter.observations->>'1341e326-d2b5-4cbc-b09a-108e10a84808')::TEXT as "Enc.Adherence to medications",
    single_select_coded(programEncounter.observations->>'644a912d-beb9-4140-a629-c6639b304e67')::TEXT as "Enc.Do you check your foot daily",
    single_select_coded(programEncounter.observations->>'d7e707f2-4c4e-47e8-8907-7dab7770fc89')::TEXT as "Enc.What about your physical activity",
    single_select_coded(programEncounter.observations->>'29e472b6-0478-4de5-89f9-d7a4a373ff42')::TEXT as "Enc.Alcohol use in last 1 year",
    single_select_coded(programEncounter.observations->>'ec3e201d-f4de-4705-b954-02c750ca5063')::TEXT as "Enc.What about the use of tobacco",
    single_select_coded(programEncounter.observations->>'182d8aef-512d-4d50-8fd8-95cb01f3ccbe')::TEXT as "Enc.Eating of fast foods like fried and bakery items weekly",
     single_select_coded(programEncounter.observations->>'fc5fb2db-c47c-43c3-9872-c64fd0ec23e4')::TEXT as "Enc.preference for food with excess salt",
    single_select_coded(programEncounter.observations->>'d31251b0-616a-47d5-84d6-7b5fad85baad')::TEXT as "Enc.Habit of vegetable intake atleast 3 servings daily",
    single_select_coded(programEncounter.observations->>'2ec1f0cb-1e3a-4c1e-be3b-a9790a9d832d')::TEXT as "Enc.Habit of fruit intake atleast 3 servings daily",
    (programEncounter.observations->>'80d88c23-1e44-423a-96bf-5ddaf105042e')::TEXT as "Enc.Height in CM",
    (programEncounter.observations->>'e9190320-3211-4d9f-a72c-288f42cf830c')::TEXT as "Enc.Weight",
    (programEncounter.observations->>'44a608f8-54d3-4a8b-96b8-7175c65e1d01')::TEXT as "Enc.Mid arm circumference",
    (programEncounter.observations->>'a9f45a38-99a7-4fd8-8e28-1291434eace0')::TEXT as "Enc.Waist circumference",
    (programEncounter.observations->>'7a320ebc-366d-4301-8e8b-71edcbaad78d')::TEXT as "Enc.Blood Pressure (systolic)",
    (programEncounter.observations->>'f9469b1c-47f5-494f-8e1e-e5dbb5c87b51')::TEXT as "Enc.Blood Pressure (Diastolic)",
    single_select_coded(programEncounter.observations->>'8bc6db2a-388d-4028-a995-865ff018c8f6')::TEXT as "Enc.Whether your blood pressure is under control",
    programEncounter.cancel_date_time "EncCancel.cancel_date_time",
    single_select_coded(programEncounter.observations->>'5592def2-fe5e-4234-9253-ca5fd0322e26')::TEXT as "EncCancel.Reason Of Cancellation",
    (programEncounter.observations->>'8263f129-5851-4f9d-a909-818dacacd862')::TEXT as "EncCancel.Other Reason of Cancellation",
    row_number() OVER (PARTITION BY individual.id ORDER BY programEncounter.encounter_date_time DESC) AS rank

FROM program_encounter programEncounter
         LEFT OUTER JOIN operational_encounter_type oet on programEncounter.encounter_type_id = oet.encounter_type_id
         LEFT OUTER JOIN program_enrolment programEnrolment ON programEncounter.program_enrolment_id = programEnrolment.id
         LEFT OUTER JOIN operational_program op ON op.program_id = programEnrolment.program_id
         LEFT OUTER JOIN individual individual ON programEnrolment.individual_id = individual.id
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
WHERE op.uuid = '4e3dc382-f14a-4a56-8ab8-e4cc4faca774'
  AND oet.uuid = '5defe5af-b031-4783-80d6-52d49aa66884'
  AND programEncounter.encounter_date_time IS NOT NULL
  AND programEnrolment.enrolment_date_time IS NOT NULL;