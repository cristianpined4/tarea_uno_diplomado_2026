-- v1_20260323_create_schema.sql
DROP SCHEMA IF EXISTS mantenimiento_pizarras CASCADE;

CREATE SCHEMA IF NOT EXISTS mantenimiento_pizarras AUTHORIZATION postgres;

SET search_path TO mantenimiento_pizarras, public;