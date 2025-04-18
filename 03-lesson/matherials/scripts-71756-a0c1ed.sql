select datname from pg_database;

select datname, datistemplate, datallowconn from pg_database;

--- создание базы данных шаблона
create database template_my2 is_template = true;

--- создание базы из шаблона
create database pr_temp2 template = template_my2;
ALTER DATABASE template_my2 IS_TEMPLATE false;
DROP DATABASE template_my2;

-- Создание табличного пространства
select * from pg_tablespace;
create tablespace ts2 location '/var/lib/postgresql/data';
SHOW data_directory;

--- создание ролей
create role role1;
create user user2 with password '222';
SELECT rolname, rolsuper FROM pg_roles WHERE rolname = 'user2';

ALTER ROLE user2 NOSUPERUSER;

GRANT CONNECT ON DATABASE postgres TO user2;
GRANT CREATE ON SCHEMA public TO "user2";

grant all privileges on database "postgres" to user2;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "user2";

ALTER ROLE user2 createdb
REVOKE CONNECT ON DATABASE postgres FROM user2;
REVOKE CREATE ON SCHEMA public FROM "user2";
REVOKE all privileges on database "postgres" FROM user2;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM "user2";

drop ROLE user2
create database group_db owner group1;
alter tablespace otus_2 owner to user1;

----схемы
create schema documents;
create table documents.student_otus(id serial, fio text); 
drop schema if exists documents;
drop schema if exists documents cascade;
create schema doc;
ALTER TABLE documents.student_otus SET SCHEMA doc;

---- создание таблиц
create table doc.pr1(id int); --tablespace ext_tabspace;
drop table doc.pr1;
drop schema if exists doc cascade;

--секционирование таблиц
create table docum(id int, title text) partition by list(id);

create table docum_1 partition of docum for values in(1, 2, 3);
create table docum_2 partition of docum for values in(4, 5);
create table docum_3 partition of docum for values in(6);

alter table docum detach partition docum_3;
alter table docum attach partition docum_3 for values in (6, 7);

insert into docum values(0, 'primer');
insert into docum values(7, 'primer');
insert into docum values(2, 'primer');
insert into docum values(4, 'primer4');
insert into docum values(5, 'primer5');
insert into docum values(6, 'primer6');

select * from docum_1
--------
create table docum_10(id int, title text) partition by list((id % 10));
create table doc_0 partition of docum_10 for values in(0);
create table doc_1 partition of docum_10 for values in(1);
create table doc_2 partition of docum_10 for values in(2);
create table doc_3 partition of docum_10 for values in(3);
...
insert into docum_10 (id) values (1), (10), (111), (22);

insert into from_otus_in_pr
 select *
FROM generate_series(11, 20);


---------последовательности
create table t1(id serial)
create sequence next_val1 start 100;
select nextval('next_val1');
select nextval('next_val1');
select currval('next_val1');
select setval('next_val1', 200, true);
select nextval('next_val');
select setval('next_val1', 300, false);
select nextval('next_val1');
select nextval('next_val');


----- внешние таблицы
CREATE EXTENSION postgres_fdw;

CREATE SERVER postgres_fdw_test FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', dbname 'sakila');

CREATE USER MAPPING FOR PUBLIC SERVER postgres_fdw_test
OPTIONS ("user" 'postgres', password '1111');

CREATE FOREIGN TABLE ft_actor
(
actor_id integer,
    first_name character varying(45),
    last_name character varying(45),
    last_update timestamp without time zone
)
SERVER postgres_fdw_test
OPTIONS (table_name 'actor');

select * from ft_actor

insert into ft_actor values(999999, 'ft_test', 'ft_test', NOW())
delete from ft_actor where actor_id = 999999

-- Представления
CREATE TABLE table_one
(
    id_one      integer PRIMARY KEY,
    some_text   text
);

CREATE TABLE table_two
(
    id_two      integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_one      integer REFERENCES table_one (id_one),
    some_text   text UNIQUE
);

INSERT INTO table_one (id_one, some_text) VALUES (1, 'one'), (2, 'two');

INSERT INTO table_two (id_one, some_text) VALUES (1, '1-1'), (1, '1-2'), (2, '2-1');
--
CREATE VIEW view_one
AS
SELECT T1.id_one, T1.some_text AS first_text, T2.id_two, T2.some_text AS second_text
FROM table_one T1
INNER JOIN table_two T2 ON T2.id_one = T1.id_one;

SELECT * FROM view_one;

CREATE VIEW single_view
AS
SELECT 'Hello world!';

select * from single_view

-- Материализованные представления
CREATE MATERIALIZED VIEW mat_view_one
AS
SELECT T1.id_one, T1.some_text AS first_text, T2.id_two, T2.some_text AS second_text
FROM table_one T1
INNER JOIN table_two T2 ON T2.id_one = T1.id_one;

SELECT * FROM mat_view_one;

INSERT INTO table_two (id_one, some_text) VALUES (2, '2-2'), (2, '2-3');

SELECT * FROM view_one;
SELECT * FROM mat_view_one;

REFRESH MATERIALIZED VIEW mat_view_one;
SELECT * FROM mat_view_one;

drop MATERIALIZED VIEW mat_view_one
drop VIEW view_one
drop VIEW single_view

drop table table_one
drop table table_two