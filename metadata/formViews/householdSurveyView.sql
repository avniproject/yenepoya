--[Data Extract Report] Household Survey

SELECT e.individual_id                                                                AS individual_id,
       (e.observations ->> '25723471-1596-4786-a390-79a687e9c61b')                    AS hof_age,
       single_select_coded(e.observations ->> 'be84eb6c-fe84-457b-b2f7-f512b6961125') AS hof_marital_status,
       e.observations ->> '0bd4084c-11cb-4a30-84aa-c4cf5b2926d1'                      AS household_individual_count,
       multi_select_coded(
               e.observations -> 'c5c9d1b4-54f8-4676-ba39-18d9a5f3c7a3')              AS member_known_chronic_illness,
       e.observations ->> 'caa23e49-901e-43ac-a246-33a16e83493a'                      AS member_known_chronic_illness_other,
       multi_select_coded(
               e.observations -> '0b5215d5-f721-4993-8f30-b85f5b397988')              AS member_last_two_weeks_illness,
       e.observations ->> '9b12024d-08e0-486b-b4b9-ddc21b6f199d'                      AS member_last_two_weeks_illness_other,
       single_select_coded(
               e.observations ->> '2a1c24fd-912a-485d-bf8e-5a722d8ab5a1')             AS member_with_disability,
       e.observations ->> '71124244-b1e2-42a7-82b3-15b79524352e'                      AS member_with_disability_details,
       e.observations ->> '00edb1c7-acda-4982-a414-0ea121f616bf'                      AS household_total_monthly_expenditure,
       single_select_coded(
               e.observations ->> '0cff16cb-8018-4908-aecc-9d6410b797d1')             AS household_out_of_pocket_payments_exceeds_10_percent,
       e.observations ->> 'd3031e04-7ad0-4075-b465-1f75678177aa'                      AS household_sleeping_room_count,
       single_select_coded(
               e.observations ->> 'a69677d2-d3e8-4458-8d21-0936bc9a510d')             AS household_separate_kitchen,
       single_select_coded(e.observations ->> '4c9e7144-8e05-4b64-8d00-b769f5e23cf3') AS household_fuel_type,
       e.observations ->> '14c847cd-ba22-49cd-8d2e-8e4e99ec9dbd'                      AS household_fuel_type_other,
       single_select_coded(
               e.observations ->> '9d6ca8db-4d5b-42ee-8ba3-a153a91bf0e8')             AS member_reported_nuisance,
       single_select_coded(
               e.observations ->> '225531c0-df1c-4ac2-8a24-c20d38b2b124')             AS potential_breeding_sites,
       e.observations ->> '52f3f9b2-dab9-46fc-8b66-776f34a9fd58'                      AS potential_breeding_sites_other,
       single_select_coded(
               e.observations ->> '8f4baf0b-02f8-4bfc-adb7-996355c46cf4')             AS insecticide_treated_bed_nets_used,
       single_select_coded(e.observations ->> '65552252-53a2-4846-ac6f-60e06dd7dacf') AS waste_segregation,
       single_select_coded(
               e.observations ->> 'eaf15d71-4654-4efc-ba1f-28d5e365bb1a')             AS waste_disposal_most_common_method,
       single_select_coded(
               e.observations ->> 'cfa00c40-3c1a-4f98-9c34-f2f5e13f229b')             AS household_latrine_present,
       single_select_coded(
               e.observations ->> 'd21f3a62-2cd9-4f34-9797-978a1ce6fbf0')             AS household_latrine_constructed_by,
       single_select_coded(
               e.observations ->> '09acf590-7148-4ec1-b5a0-3ab34309d153')             AS member_defecate_open_air,
       single_select_coded(
               e.observations ->> '2c11d1e4-072c-40a2-8a68-24855f7d4027')             AS household_drainage_type,
       multi_select_coded(
               e.observations -> '36ab6284-c3ca-4de8-8593-eba915a03791')              AS household_domestic_water_source,
       e.observations ->> '78c763af-bced-49aa-813a-66a19dde3ebb'                      AS household_domestic_water_source_other,
       multi_select_coded(
               e.observations -> 'f3250681-0a1e-4e7a-9654-d15b24b0d78c')              AS household_drinking_water_source,
       e.observations ->> '5f3931f3-fd5e-4666-b1e2-01db24684fb6'                      AS household_drinking_water_source_other,
       single_select_coded(
               e.observations ->> '2ee24106-43f2-4b2f-9ff7-75080851bed3')             AS chlorinated_water_provided,
       single_select_coded(
               e.observations ->> '7ba3b46e-d9f7-4f91-b38d-a587a4686951')             AS domestic_purification_methods,
       single_select_coded(
               e.observations ->> 'b40f407f-b68e-44fe-b641-86ab8b7ab51d')             AS water_supply_regularity,
       single_select_coded(
               e.observations ->> 'db05dadf-5955-4d5d-a62d-b7f7a1ecf6ce')             AS preferred_health_facility_chronic_illness,
       multi_select_coded(
               e.observations -> 'db05dadf-5955-4d5d-a62d-b7f7a1ecf6ce')              AS preferred_health_facility_chronic_illness_name,
       e.observations ->> '54a36cb8-a7a0-415d-84c7-2ca4b88e8f87'                      AS preferred_health_facility_chronic_illness_name_other,
       single_select_coded(
               e.observations ->> 'da29256e-720c-4071-a8f4-9e563749aef1')             AS preferred_health_facility_acute_illness,
       multi_select_coded(
               e.observations -> '84a7b976-1730-479f-926a-dcdaac00b876')              AS preferred_health_facility_acute_illness_name,
       e.observations ->> '1a436a53-b279-49b1-87b4-efad33a34a4d'                      AS preferred_health_facility_acute_illness_name_other,
       multi_select_coded(
               e.observations -> '5987c751-0e34-4e76-aa1a-95b31d7af765')              AS health_facility_preferred_reason,
       e.observations ->> '4239ddc6-60cc-4ac0-ad7d-3d35bf2caace'                      AS health_facility_preferred_reason_other,
       single_select_coded(
               e.observations ->> '67c33f11-2358-4360-8b86-65633232c773')             AS member_with_mental_illness_availing_health_services,
       single_select_coded(
               e.observations ->> '5b99afca-55eb-4793-824b-361d94d5c3d7')             AS social_security_schemes_availed,
       multi_select_coded(
               e.observations -> 'a7815743-9b97-4631-9df7-a5a982ca3b2a')              AS social_security_schemes_availed_names,
       e.observations ->> '003d18b4-2f1f-4fa8-97fd-5049c83eb1f0'                      AS social_security_schemes_availed_names_other,
       multi_select_coded(e.observations -> '19df1265-d795-4f29-94a9-422f1bef645b')   AS transport_facility,
       multi_select_coded(e.observations -> 'ed7fa0bb-ba46-4a2f-bf3e-4005ea4c046c')   AS electronic_gadgets,
       multi_select_coded(e.observations -> '00177962-6242-48e0-8bf7-9bc879bdb976')   AS other_facilities,
       multi_select_coded(e.observations -> 'eb52fe79-3b96-4b3f-8bc6-ddda16746eed')   AS vital_events,
       multi_select_coded(e.observations -> '2457b432-21ab-4636-8551-b4682c51bb40')   AS member_working_abroad,
       e.observations ->> 'f0a15451-6e52-4d2d-b893-0f74ec662560'                      AS member_working_abroad_name_place
FROM encounter e
         LEFT OUTER JOIN individual i on i.id = e.individual_id
WHERE i.subject_type_id = (SELECT id FROM subject_type WHERE name = 'Household')
  AND e.encounter_type_id = (SELECT id FROM encounter_type WHERE name = 'Household Survey');
