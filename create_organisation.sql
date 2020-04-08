select create_db_user('yenepoya', 'password');

INSERT into organisation (name, db_user, uuid, media_directory)
values ('Yenepoya', 'yenepoya', '06614185-f322-46c1-a641-33a7a20c4843', 'yenepoya')
ON CONFLICT (uuid) DO NOTHING;