/*******************************************************************************
 GREEN TECH METRICS - UTN
 SCRIPT FINAL (DROP + CREATE) - LISTO PARA APEX
*******************************************************************************/

--------------------------------------------------------------------------------
-- 0) LIMPIEZA SEGURA (no falla si no existe)
--------------------------------------------------------------------------------
BEGIN
  -- Triggers
  EXECUTE IMMEDIATE 'DROP TRIGGER tr_univ_upd';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TRIGGER tr_programas_upd';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TRIGGER tr_poblaciones_upd';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TRIGGER trg_puntuar_metrica_auto';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TRIGGER trg_bloqueo_periodo_cerrado';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  -- Procedures / Functions
  EXECUTE IMMEDIATE 'DROP PROCEDURE prc_recalcular_totales_ranking';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP FUNCTION fn_tiene_permiso';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE prc_actualizar_vistas_dashboard';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  -- Views
  EXECUTE IMMEDIATE 'DROP VIEW vw_metricas_gestion';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  -- Materialized views
  EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW mv_resumen_categorias';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW mv_detalle_indicadores';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  -- Indexes
  EXECUTE IMMEDIATE 'DROP INDEX idx_res_met_periodo';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP INDEX idx_res_ind_periodo';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP INDEX idx_res_cat_periodo';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
--------------------------------------------------------------------------------
-- 1) TRIGGERS DE AUDITORÍA
--------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER tr_univ_upd
BEFORE UPDATE ON universidades
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := CURRENT_TIMESTAMP;
END;
/
SHOW ERRORS

CREATE OR REPLACE TRIGGER tr_programas_upd
BEFORE UPDATE ON programas
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := CURRENT_TIMESTAMP;
END;
/
SHOW ERRORS

CREATE OR REPLACE TRIGGER tr_poblaciones_upd
BEFORE UPDATE ON poblaciones
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := CURRENT_TIMESTAMP;
END;
/
SHOW ERRORS

--------------------------------------------------------------------------------
-- 2) TRIGGER: BLOQUEO POR PERIODO CERRADO (primero por seguridad)
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_bloqueo_periodo_cerrado
BEFORE INSERT OR UPDATE OR DELETE ON resultados_metricas
FOR EACH ROW
DECLARE
  v_estado    periodos.estado%TYPE;
  v_periodo_id resultados_metricas.id_periodo%TYPE;
BEGIN
  v_periodo_id := CASE WHEN DELETING THEN :OLD.id_periodo ELSE :NEW.id_periodo END;

  SELECT estado
    INTO v_estado
    FROM periodos
   WHERE id_periodo = v_periodo_id;

  IF v_estado = 'CERRADO' THEN
    RAISE_APPLICATION_ERROR(-20001, 'ERROR: El periodo seleccionado está CERRADO y no permite cambios.');
  END IF;
END;
/
SHOW ERRORS

--------------------------------------------------------------------------------
-- 3) TRIGGER: CALIFICACIÓN AUTOMÁTICA (corregido)
--    Nota: Tus rangos están definidos por INDICADOR (vía escalas_evaluacion.id_indicador).
--    Entonces buscamos el indicador de la métrica y aplicamos rangos del indicador (y versión).
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_puntuar_metrica_auto
BEFORE INSERT OR UPDATE OF valor_real_utn ON resultados_metricas
FOR EACH ROW
DECLARE
  v_puntaje  NUMBER(10,2);
  v_indicador_id metricas.id_indicador%TYPE;
  v_version_id   periodos.id_version%TYPE;
BEGIN
  -- indicador de la métrica
  SELECT id_indicador
    INTO v_indicador_id
    FROM metricas
   WHERE id_metrica = :NEW.id_metrica;

  -- versión del periodo (para aplicar escalas de la guía correspondiente)
  SELECT id_version
    INTO v_version_id
    FROM periodos
   WHERE id_periodo = :NEW.id_periodo;

  -- puntaje según rangos (determinístico)
  SELECT r.puntaje_asignado
    INTO v_puntaje
    FROM rangos_evaluacion r
    JOIN escalas_evaluacion e ON e.id_escala = r.id_escala
   WHERE e.id_indicador = v_indicador_id
     AND e.id_version   = v_version_id
     AND :NEW.valor_real_utn BETWEEN NVL(r.valor_minimo, :NEW.valor_real_utn)
                               AND NVL(r.valor_maximo, :NEW.valor_real_utn)
   ORDER BY r.nivel DESC
   FETCH FIRST 1 ROW ONLY;

  :NEW.puntaje_obtenido_met := NVL(v_puntaje, 0);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    :NEW.puntaje_obtenido_met := 0;
END;
/
SHOW ERRORS

--------------------------------------------------------------------------------
-- 4) PROCEDIMIENTO: CONSOLIDACIÓN (SIN COMMIT)
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prc_recalcular_totales_ranking(p_periodo_id NUMBER) IS
BEGIN
  -- A) Resultados por indicador (solo métricas VALIDADA)
  MERGE INTO resultados_indicadores ri
  USING (
      SELECT m.id_indicador,
             rm.id_periodo,
             SUM(m.puntaje_max_met)       AS maximo,
             SUM(rm.puntaje_obtenido_met) AS obtenido
        FROM resultados_metricas rm
        JOIN metricas m           ON m.id_metrica = rm.id_metrica
        JOIN estados_evaluacion e ON e.id_estado = rm.id_estado
       WHERE rm.id_periodo = p_periodo_id
         AND e.codigo      = 'VALIDADA'
       GROUP BY m.id_indicador, rm.id_periodo
  ) src
     ON (ri.id_indicador = src.id_indicador AND ri.id_periodo = src.id_periodo)
  WHEN MATCHED THEN UPDATE SET
       ri.puntaje_maximo   = src.maximo,
       ri.puntaje_obtenido = src.obtenido,
       ri.porcentaje_logro = ROUND((src.obtenido / NULLIF(src.maximo,0)) * 100, 2)
  WHEN NOT MATCHED THEN INSERT
       (id_indicador, id_periodo, puntaje_maximo, puntaje_obtenido, porcentaje_logro)
  VALUES
       (src.id_indicador, src.id_periodo, src.maximo, src.obtenido,
        ROUND((src.obtenido / NULLIF(src.maximo,0)) * 100, 2));

  -- B) Resultados por categoría (suma de indicadores)
  MERGE INTO resultados_categorias rc
  USING (
      SELECT i.id_categoria,
             ri.id_periodo,
             SUM(ri.puntaje_maximo)   AS maximo,
             SUM(ri.puntaje_obtenido) AS obtenido
        FROM resultados_indicadores ri
        JOIN indicadores i ON i.id_indicador = ri.id_indicador
       WHERE ri.id_periodo = p_periodo_id
       GROUP BY i.id_categoria, ri.id_periodo
  ) src
     ON (rc.id_categoria = src.id_categoria AND rc.id_periodo = src.id_periodo)
  WHEN MATCHED THEN UPDATE SET
       rc.puntaje_maximo   = src.maximo,
       rc.puntaje_obtenido = src.obtenido,
       rc.porcentaje_logro = ROUND((src.obtenido / NULLIF(src.maximo,0)) * 100, 2)
  WHEN NOT MATCHED THEN INSERT
       (id_categoria, id_periodo, puntaje_maximo, puntaje_obtenido, porcentaje_logro)
  VALUES
       (src.id_categoria, src.id_periodo, src.maximo, src.obtenido,
        ROUND((src.obtenido / NULLIF(src.maximo,0)) * 100, 2));

  -- C) Total general
  MERGE INTO resultados_generales rg
  USING (
      SELECT id_periodo,
             SUM(puntaje_obtenido) AS total
        FROM resultados_categorias
       WHERE id_periodo = p_periodo_id
       GROUP BY id_periodo
  ) src
     ON (rg.id_periodo = src.id_periodo)
  WHEN MATCHED THEN UPDATE SET
       rg.puntaje_total = src.total
  WHEN NOT MATCHED THEN INSERT (id_periodo, puntaje_total)
  VALUES (src.id_periodo, src.total);

END;
/
SHOW ERRORS

--------------------------------------------------------------------------------
-- 5) FUNCIÓN RBAC PARA APEX (retorna NUMBER, no BOOLEAN)
--    Usa usuarios_roles.activo = 'S'
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_tiene_permiso (
    p_usuario_id NUMBER,
    p_permiso    VARCHAR2
) RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO v_count
      FROM usuarios_roles ur
      JOIN rol_permisos rp ON rp.id_rol = ur.id_rol
      JOIN permisos p      ON p.id_permiso = rp.id_permiso
     WHERE ur.id_usuario = p_usuario_id
       AND ur.activo     = 'S'
       AND p.clave       = p_permiso;

    RETURN CASE 
             WHEN v_count > 0 THEN 1 
             ELSE 0 
           END;
END;
/
SHOW ERRORS

--------------------------------------------------------------------------------
-- 6) VISTA PARA GESTIÓN (APEX)
--------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_metricas_gestion AS
SELECT
  rm.id_resultado_met,
  p.anio,
  c.nombre AS categoria,
  i.nombre AS indicador,
  m.nombre_metrica,
  rm.valor_real_utn,
  rm.puntaje_obtenido_met,
  e.nombre AS estado
FROM resultados_metricas rm
JOIN metricas m           ON rm.id_metrica  = m.id_metrica
JOIN indicadores i        ON m.id_indicador = i.id_indicador
JOIN categorias c         ON i.id_categoria = c.id_categoria
JOIN periodos p           ON rm.id_periodo  = p.id_periodo
JOIN estados_evaluacion e ON rm.id_estado   = e.id_estado;

--------------------------------------------------------------------------------
-- 7) ÍNDICES
--------------------------------------------------------------------------------
CREATE INDEX idx_res_met_periodo ON resultados_metricas (id_periodo, id_estado);
CREATE INDEX idx_res_ind_periodo ON resultados_indicadores (id_periodo);
CREATE INDEX idx_res_cat_periodo ON resultados_categorias (id_periodo);

--------------------------------------------------------------------------------
-- 8) MATERIALIZED VIEWS (ON DEMAND)
--------------------------------------------------------------------------------
CREATE MATERIALIZED VIEW mv_resumen_categorias
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT
  p.anio,
  c.nombre AS categoria,
  rc.puntaje_obtenido,
  rc.puntaje_maximo,
  rc.porcentaje_logro
FROM resultados_categorias rc
JOIN categorias c ON rc.id_categoria = c.id_categoria
JOIN periodos p   ON rc.id_periodo   = p.id_periodo;

CREATE MATERIALIZED VIEW mv_detalle_indicadores
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT
  p.anio,
  c.nombre AS categoria,
  i.nombre AS indicador,
  ri.puntaje_obtenido,
  ri.puntaje_maximo,
  ri.porcentaje_logro
FROM resultados_indicadores ri
JOIN indicadores i ON ri.id_indicador = i.id_indicador
JOIN categorias c  ON i.id_categoria  = c.id_categoria
JOIN periodos p    ON ri.id_periodo   = p.id_periodo;

--------------------------------------------------------------------------------
-- 9) PROCEDIMIENTO REFRESH MVs
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prc_actualizar_vistas_dashboard IS
BEGIN
  DBMS_MVIEW.REFRESH('MV_RESUMEN_CATEGORIAS');
  DBMS_MVIEW.REFRESH('MV_DETALLE_INDICADORES');
END;
/
SHOW ERRORS