-- v1_20260323_alter_tables.sql

ALTER TABLE reportes_fallos
ADD COLUMN nivel_prioridad NUMERIC(1,0),
ADD CONSTRAINT chk_nivel_prioridad CHECK (nivel_prioridad BETWEEN 1 AND 5);