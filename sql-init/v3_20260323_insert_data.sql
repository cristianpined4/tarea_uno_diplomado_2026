-- v2_20260323_insert_data.sql

-- Insertar pizarras
INSERT INTO pizarras (ubicacion, estado) VALUES
('Aula 101', 'Operativa'),
('Aula 102', 'En Reparación'),
('Aula 103', 'Fuera de Servicio'),
('Sala de Reuniones', 'Operativa'),
('Laboratorio 1', 'Operativa');

-- Insertar tecnicos
INSERT INTO tecnicos (nombre, especialidad) VALUES
('Carlos Pérez', 'Electrónica'),
('María López', 'Software'),
('Juan Martínez', 'Hardware'),
('Ana García', 'Redes');

-- Insertar reportes_fallos
INSERT INTO reportes_fallos (fecha, descripcion, pizarra_id, tecnico_id,nivel_prioridad) VALUES
('2026-01-10', 'Pantalla no enciende', 1, 1, 2);