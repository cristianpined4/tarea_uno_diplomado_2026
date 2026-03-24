-- v1_20260323_maintenance.sql
-- Mantenimiento rutinario: limpieza de espacio y estadísticas
-- (Marqués Cap. 8.1.4 - Fragmentación física y tuplas muertas)

-- VACUUM + ANALYZE en reportes_fallos
-- Se ejecutan juntos porque:
-- 1. VACUUM reclamará espacio de tuplas eliminadas (hace limpieza física)
-- 2. ANALYZE actualiza stats para que el Planificador sepa cómo están distribuidos los datos

VACUUM ANALYZE reportes_fallos;

-- ¿Por qué esto importa en un entorno tipo UJI con alta rotación?
-- - Inserciones masivas de reportes -> la tabla crece constantemente
-- - Borrados de históricos (ej: reportes > 2 años) -> dejan "agujeros" en disco
-- - Sin VACUUM: los ficheros siguen siendo enormes aunque no haya datos útiles
--   (el espacio no se reclama automáticamente)
-- - Sin ANALYZE: el Planificador usa stats viejas y elige planes mediocres
--   (puede hacer table scan cuando debería usar índice, o vice versa)

-- VACUUM hace:
--   - Marca tuplas muertas como reutilizables
--   - Compacta páginas
--   - Reduce tamaño físico del archivo
--   => Evita que reportes_fallos crezca indefinidamente

-- ANALYZE hace:
--   - Lee muestras de datos
--   - Actualiza pg_statistic con: N filas, distribuición, valores comunes
--   - El Query Planner usa esto para elegir Index Scan vs Seq Scan, Si hay 
--     100k reportes pero ANALYZE no sabe, puede hacer scan completo 
--     innecesariamente

-- TIP de sysadmin:
-- Ejecutar:
--   - VACUUM ANALYZE en carga baja (ej: 3 AM)
--   - VACUUM FULL si el tamaño en disco se dispara (pero bloquea tabla!)
--   - Para tablas enormes: considerar VACUUM ANALYZE concurrente (VACUUM ANALYZE VERBOSE)
--
-- IMPORTANTE: no ejecutar VACUUM FULL en horario laboral, cuelga todo
