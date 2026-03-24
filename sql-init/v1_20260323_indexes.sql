-- v1_20260323_indexes.sql

DROP INDEX IF EXISTS idx_reportes_fallos_fecha;
DROP INDEX IF EXISTS idx_reportes_fallos_tecnico_id;

-- idx en fecha -> para range queries y ORDER BY
CREATE INDEX idx_reportes_fallos_fecha ON reportes_fallos(fecha);

-- idx en tecnico_id -> para JOINs con tecnicos y búsquedas por técnico
CREATE INDEX idx_reportes_fallos_tecnico_id ON reportes_fallos(tecnico_id);

-- EXPLICACIÓN:
-- 1. El Planificador usa idx_reportes_fallos_fecha para queries tipo:
--    - WHERE fecha BETWEEN X AND Y
--    - ORDER BY fecha
--    - Acceso O(log n) en lugar de table scan O(n) = mucho más rápido
--
-- 2. El idx en tecnico_id optimiza JOINs:
--    - SELECT ... FROM reportes_fallos rf JOIN tecnicos t ON rf.tecnico_id = t.id
--    - Mejor que hacer cross product
--
-- 3. TRADE-OFF:
--    PRO: SELECT rápidos, mejor experiencia en reportes
--    CONTRA: 
--      - INSERT/UPDATE más lentos (mantener índices), ~20-30% más disco usado. 
--      Para este caso está bien porque reportes_fallos es más lectura que 
--      escritura, Si tuviéramos 1000+ INSERT/seg habría que repensar 
--      (staging tables, particionamiento, etc)