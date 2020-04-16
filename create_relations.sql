set role yenepoya;

INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('son', '4df65c96-8c03-4b05-b91f-dbbbc383d399', 1, (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('daughter', '7809590c-2838-4474-aa81-723667c02f57', 1,
        (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('father', '182d757b-b383-4792-a8d0-4f752863652b', 1, (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('mother', 'aaed8ff3-8afe-48e2-b5f7-764902760bcf', 1, (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('husband', 'b24baea3-86bd-4180-a3bb-9face7ff938e', 1, (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('wife', '79f4835c-114e-4cd2-b228-6e89ae7e4d89', 1, (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('brother', 'c441abae-c26f-4916-8def-028fc8ff2cda', 1, (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('sister', '11b385fb-9825-4db9-8a80-63e3ff138ab3', 1, (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('grandson', '60339907-63e3-4398-bb14-c12d5d7a4acb', 1,
        (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('granddaughter', '86612d2c-5c7d-4863-9b35-551a419151e2', 1,
        (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('grandfather', '89d760cb-f349-446a-b906-08f9c5fb4a77', 1,
        (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relation (name, uuid, version, organisation_id, audit_id)
VALUES ('grandmother', '40f634da-fc17-458d-a269-f0caff758d71', 1,
        (select id from organisation where name = 'Yenepoya'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('d006028f-ecc7-4519-a79e-fdd2783e0168', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'son'), (select id from gender where name = 'Male'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('1601e116-4550-460f-8283-f1c99b8c442c', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'daughter'),
        (select id from gender where name = 'Female'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('03bc9b4a-089d-4622-96ac-e94237426f2d', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'father'), (select id from gender where name = 'Male'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('04d4fffe-ec25-418e-81e1-5d6088785ab4', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'mother'), (select id from gender where name = 'Female'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('d25af054-b7d9-48fa-ac1e-7e3ddc848e8b', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'husband'), (select id from gender where name = 'Male'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('3cfd64bb-a9a7-4ce7-9ea1-4b767af5dec8', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'wife'), (select id from gender where name = 'Female'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('9eb1f861-aa85-4286-ad14-3a9cd9b1ce30', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'brother'), (select id from gender where name = 'Male'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('3de43118-cdfa-4270-a88c-4757302fd2cf', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'sister'), (select id from gender where name = 'Female'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('daf2c380-a38c-4e74-a15d-45114ba9103c', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'grandson'),
        (select id from gender where name = 'Male'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('bcbe90bc-b753-423d-9b3a-995b73571f7c', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'granddaughter'),
        (select id from gender where name = 'Female'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('b6ea28cc-0255-4e3c-8771-58e2c637986a', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'grandfather'),
        (select id from gender where name = 'Male'),
        create_audit((select id from users where username = 'admin@yenepoya')));
insert into individual_relation_gender_mapping(uuid, version, organisation_id, relation_id, gender_id, audit_id)
VALUES ('d7dd23f5-cd42-494a-9310-7a1cb3968cac', 1, (select id from organisation where name = 'Yenepoya'),
        (select id from individual_relation where name = 'grandmother'),
        (select id from gender where name = 'Female'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('a1fe32c9-46d6-4c2c-acc6-574f3486a0a0', 1, (select id from organisation where name = 'Yenepoya'),
        'father-son',
        (select id from individual_relation where name = 'father'),
        (select id from individual_relation where name = 'son'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('a2e764a6-2354-49fe-8c90-a3f2c8c63095', 1, (select id from organisation where name = 'Yenepoya'),
        'father-daughter',
        (select id from individual_relation where name = 'father'),
        (select id from individual_relation where name = 'daughter'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('26973982-1c94-4357-b515-de586f933156', 1, (select id from organisation where name = 'Yenepoya'),
        'mother-son',
        (select id from individual_relation where name = 'mother'),
        (select id from individual_relation where name = 'son'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('aaac20ef-b8ec-4064-b9bf-aa5b90e0db8b', 1, (select id from organisation where name = 'Yenepoya'),
        'mother-daughter',
        (select id from individual_relation where name = 'mother'),
        (select id from individual_relation where name = 'daughter'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('410e6371-120c-43a8-8e4c-4f73b3b46f3a', 1, (select id from organisation where name = 'Yenepoya'), 'spouse',
        (select id from individual_relation where name = 'husband'),
        (select id from individual_relation where name = 'wife'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('280c9298-bf4a-4cce-abbd-558ae19c78b2', 1, (select id from organisation where name = 'Yenepoya'),
        'brother-brother',
        (select id from individual_relation where name = 'brother'),
        (select id from individual_relation where name = 'brother'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('0dde7b53-6fd6-4764-833c-4a5b54799243', 1, (select id from organisation where name = 'Yenepoya'),
        'sister-sister',
        (select id from individual_relation where name = 'sister'),
        (select id from individual_relation where name = 'sister'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('a5f32d30-69be-4565-917e-9758a90a742c', 1, (select id from organisation where name = 'Yenepoya'),
        'brother-sister',
        (select id from individual_relation where name = 'brother'),
        (select id from individual_relation where name = 'sister'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('44ec744c-565f-42f3-a261-e1b7e69405be', 1, (select id from organisation where name = 'Yenepoya'),
        'grandfather-grandson',
        (select id from individual_relation where name = 'grandfather'),
        (select id from individual_relation where name = 'grandson'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('58898b28-fd7f-4af6-8136-bfabd2250f9a', 1, (select id from organisation where name = 'Yenepoya'),
        'grandfather-granddaughter',
        (select id from individual_relation where name = 'grandfather'),
        (select id from individual_relation where name = 'granddaughter'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('f6e68776-87ff-4164-adbc-334e153cc2ad', 1, (select id from organisation where name = 'Yenepoya'),
        'grandmother-grandson',
        (select id from individual_relation where name = 'grandmother'),
        (select id from individual_relation where name = 'grandson'),
        create_audit((select id from users where username = 'admin@yenepoya')));
INSERT INTO individual_relationship_type (uuid, version, organisation_id, name, individual_a_is_to_b_relation_id,
                                          individual_b_is_to_a_relation_id, audit_id)
VALUES ('597b48f0-df13-4f0c-a689-db234a3d25aa', 1, (select id from organisation where name = 'Yenepoya'),
        'grandmother-granddaughter',
        (select id from individual_relation where name = 'grandmother'),
        (select id from individual_relation where name = 'granddaughter'),
        create_audit((select id from users where username = 'admin@yenepoya')));

set role none;
