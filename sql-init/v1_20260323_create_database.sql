-- v1_20260323_create_database.sql

DROP DATABASE IF EXISTS midb;

CREATE DATABASE midb;

\c midb;

GRANT ALL PRIVILEGES ON DATABASE midb TO postgres;
