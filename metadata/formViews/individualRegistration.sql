drop view if exists yenepoya_individual_registration_view;
create view yenepoya_individual_registration_view
            ("Ind.Id", "Ind.address_id", "Ind.uuid", "Ind.first_name", "Ind.last_name", "Ind.Gender",
             "Ind.date_of_birth", "Ind.date_of_birth_verified", "Ind.registration_date", "Ind.facility_id", "Ind.Area",
             "Ind.is_voided", "Ind.Contact Number", "Ind.Household number")
as
SELECT individual.id                                                              AS "Ind.Id",
       individual.address_id                                                      AS "Ind.address_id",
       individual.uuid                                                            AS "Ind.uuid",
       individual.first_name                                                      AS "Ind.first_name",
       individual.last_name                                                       AS "Ind.last_name",
       g.name                                                                     AS "Ind.Gender",
       individual.date_of_birth                                                   AS "Ind.date_of_birth",
       individual.date_of_birth_verified                                          AS "Ind.date_of_birth_verified",
       individual.registration_date                                               AS "Ind.registration_date",
       individual.facility_id                                                     AS "Ind.facility_id",
       a.title                                                                    AS "Ind.Area",
       individual.is_voided                                                       AS "Ind.is_voided",
       (individual.observations ->> 'b8f2d179-0638-4016-afa2-a2bbf0f48e6a'::text) AS "Ind.Contact Number",
       (individual.observations ->> '558469e8-d993-45ec-9d9b-f019c3642bab'::text) AS "Ind.Household number"
FROM ((individual individual
    LEFT JOIN gender g ON ((g.id = individual.gender_id)))
         LEFT JOIN address_level a ON ((individual.address_id = a.id)))
WHERE (individual.subject_type_id = (SELECT subject_type.id
                                     FROM subject_type
                                     WHERE ((subject_type.name)::text = 'Individual'::text)));

alter table yenepoya_individual_registration
    owner to yenepoya;

