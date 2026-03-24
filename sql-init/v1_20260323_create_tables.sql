-- v1_20260323_create_tables.sql

DROP TABLE IF EXISTS reportes_fallos;
DROP TABLE IF EXISTS tecnicos;
DROP TABLE IF EXISTS pizarras;

CREATE TABLE pizarras (
    id SERIAL PRIMARY KEY,
    ubicacion VARCHAR(50),
    estado VARCHAR(20) CHECK (estado IN ('Operativa', 'En Reparación', 'Fuera de Servicio'))
);

CREATE TABLE tecnicos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50)
);

CREATE TABLE reportes_fallos (
    id SERIAL PRIMARY KEY,
    fecha DATE,
    descripcion VARCHAR(50)
);