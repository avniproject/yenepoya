--[Data Extract Report] Registration

SELECT individual.id                                                              as "Ind.Id",
       individual.address_id                                                      as "Ind.address_id",
       individual.uuid                                                            as "Ind.uuid",
       individual.first_name                                                      as "Ind.first_name",
       individual.last_name                                                       as "Ind.last_name",
       g.name                                                                     as "Ind.Gender",
       individual.date_of_birth                                                   as "Ind.date_of_birth",
       individual.date_of_birth_verified                                          as "Ind.date_of_birth_verified",
       individual.registration_date                                               as "Ind.registration_date",
       individual.facility_id                                                     as "Ind.facility_id",
       a.title                                                                    as "Ind.Area",
       individual.is_voided                                                       as "Ind.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a')::TEXT as "Ind.Contact Number",
       (individual.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab')::TEXT as "Ind.Household number"
FROM individual individual
         LEFT OUTER JOIN gender g ON g.id = individual.gender_id
         LEFT OUTER JOIN address_level a ON individual.address_id = a.id
where subject_type_id = (select id from subject_type where name = 'Individual')