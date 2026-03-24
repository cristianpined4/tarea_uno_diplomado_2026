-- v1_20260323_create_functions_and_triggers.sql

DROP TRIGGER IF EXISTS trg_actualizar_estado_pizarra ON reportes_fallos;
DROP FUNCTION IF EXISTS fn_actualizar_estado_pizarra();

CREATE OR REPLACE FUNCTION fn_actualizar_estado_pizarra()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.pizarra_id IS NOT NULL THEN
		UPDATE pizarras
		SET estado = 'En Reparación'
		WHERE id = NEW.pizarra_id
		  AND estado <> 'En Reparación';
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_actualizar_estado_pizarra
AFTER INSERT ON reportes_fallos
FOR EACH ROW
EXECUTE FUNCTION fn_actualizar_estado_pizarra();

-- Justificación técnica:
-- 1) FOR EACH ROW se utiliza porque cada nuevo reporte puede apuntar a una pizarra distinta.
--    El trigger necesita leer NEW.pizarra_id por cada fila insertada para actualizar el activo correcto.
-- 2) AFTER se prefiere porque la actualización cruzada de pizarras debe ejecutarse únicamente
--    cuando el INSERT en reportes_fallos ya fue aceptado por PostgreSQL (fila válida y persistida).
--    Así se evita propagar cambios de estado si el INSERT falla y se mantiene coherencia transaccional.
