\c template1
-- clean
REVOKE CONNECT ON DATABASE database_one FROM public;
SELECT  pg_terminate_backend(pg_stat_activity.pid)
FROM    pg_stat_activity
WHERE   pg_stat_activity.datname = 'database_one';
DROP DATABASE IF EXISTS database_one;

REVOKE CONNECT ON DATABASE database_two FROM public;
SELECT  pg_terminate_backend(pg_stat_activity.pid)
FROM    pg_stat_activity
WHERE   pg_stat_activity.datname = 'database_two';
DROP DATABASE IF EXISTS database_two;

DROP USER IF EXISTS abe;
DROP ROLE IF EXISTS abe;
DROP USER IF EXISTS bob;
DROP ROLE IF EXISTS bob;


-- recreate
CREATE USER abe;
CREATE USER bob;

CREATE DATABASE database_one;
CREATE DATABASE database_two;

\c database_one
CREATE TABLE events (id integer, description text);
CREATE TABLE profiles (id integer, name text);

GRANT ALL PRIVILEGES ON TABLE events to abe;
GRANT ALL PRIVILEGES ON TABLE events to bob;
GRANT ALL PRIVILEGES ON TABLE profiles to abe;
GRANT ALL PRIVILEGES ON TABLE profiles to bob;

\c database_two
CREATE TABLE another (id integer, name text);