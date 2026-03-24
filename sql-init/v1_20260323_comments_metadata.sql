-- v1_20260323_comments_metadata.sql
-- Documentación del catálogo del sistema
-- (Marqués Cap. 1.1 - Independencia lógica-física mediante metadatos)

-- Comentarios en tabla tecnicos
COMMENT ON TABLE tecnicos IS 
'Tabla que almacena información de los técnicos responsables del mantenimiento de pizarras.
Contiene datos de identificación, nombre y especialidad de cada técnico.
Relacionada con reportes_fallos mediante FK tecnico_id.';

-- Comentarios en columnas de tecnicos
COMMENT ON COLUMN tecnicos.id IS 'Identificador único del técnico (PK).';
COMMENT ON COLUMN tecnicos.nombre IS 'Nombre completo del técnico.';
COMMENT ON COLUMN tecnicos.especialidad IS 'Área de especialización (ej: Electrónica, Software, Hardware, Redes).';

-- Comentarios en tabla pizarras
COMMENT ON TABLE pizarras IS
'Tabla que registra los activos de pizarras instaladas en las aulas.
Cada pizarra tiene una ubicación física y un estado que se actualiza automáticamente
cuando se registra un fallo mediante el trigger trg_actualizar_estado_pizarra.';

-- Comentarios en columnas de pizarras
COMMENT ON COLUMN pizarras.id IS 'Identificador único de la pizarra (PK).';
COMMENT ON COLUMN pizarras.ubicacion IS 'Ubicación física (ej: Aula 101, Laboratorio 1).';
COMMENT ON COLUMN pizarras.estado IS 
'Estado actual de la pizarra. Valores permitidos:
- "Operativa": En funcionamiento normal
- "En Reparación": Fallo reportado, técnico asignado (se actualiza automáticamente via TRIGGER)
- "Fuera de Servicio": No disponible temporalmente o permanentemente
El estado se modifica mediante el trigger trg_actualizar_estado_pizarra cuando se inserta un reporte.';

-- Comentarios en tabla reportes_fallos
COMMENT ON TABLE reportes_fallos IS
'Registro de fallos reportados en pizarras.
Cada reporte contiene fecha del fallo, descripción, pizarra afectada y técnico asignado.
Dispara trigger que actualiza automáticamente el estado en tabla pizarras.
Índices en fecha y tecnico_id para optimizar consultas analíticas.';

-- Comentarios en columnas de reportes_fallos
COMMENT ON COLUMN reportes_fallos.id IS 'Identificador único del reporte (PK).';
COMMENT ON COLUMN reportes_fallos.fecha IS 'Fecha en que se reportó el fallo (indexada para range queries).';
COMMENT ON COLUMN reportes_fallos.descripcion IS 'Descripción breve del problema detectado.';
COMMENT ON COLUMN reportes_fallos.pizarra_id IS 'Referencia a la pizarra afectada (FK). Dispara actualización de estado.';
COMMENT ON COLUMN reportes_fallos.tecnico_id IS 'Técnico asignado al reporte (FK, indexada para consultas por técnico).';

-- ¿Por qué esto importa? (Independencia lógica-física)
-- Estos comentarios quedan en el catálogo del sistema (pg_description)
-- Y son accesibles a través de:
--   - pgAdmin (muestra descs en UI)
--   - \d+ tabla_name en psql
--   - Herramientas de documentación automática
--
-- Beneficio: el siguiente DBA que toque esto en 2 años entiende qué hace cada cosa
-- sin necesidad de bucear en el código de la aplicación.