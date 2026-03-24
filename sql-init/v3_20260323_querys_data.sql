-- v1_20260323_querys_data.sql

-- Consultas para pizarras
SELECT * FROM pizarras;

-- Consultas para tecnicos
SELECT * FROM tecnicos;

-- Consultas para reportes_fallos
SELECT rf.fecha, rf.descripcion, tc.nombre as tecnico, p.ubicacion, p.estado FROM reportes_fallos rf JOIN tecnicos tc ON rf.tecnico_id = tc.id JOIN pizarras p ON rf.pizarra_id = p.id;