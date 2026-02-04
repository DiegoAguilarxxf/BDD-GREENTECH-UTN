/* ============================================================
   GREEN TECH METRICS - TRIGGERS CORE (SIN LOGIN)
   Compatible con Oracle / APEX
============================================================ */

/* ============================================================
   0) TRIGGERS DE AUDITORÍA (actualizado_el)
   - Universidades
   - Programas
   - Poblaciones
   - Presupuestos_sostenibilidad (si usas actualizado_el)
   - Resultados_metricas (si usas actualizado_el)
============================================================ */

CREATE OR REPLACE TRIGGER tr_universidades_audit_upd
BEFORE UPDATE ON universidades
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := SYSTIMESTAMP;
END;
/

CREATE OR REPLACE TRIGGER tr_programas_audit_upd
BEFORE UPDATE ON programas
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := SYSTIMESTAMP;
END;
/

CREATE OR REPLACE TRIGGER tr_poblaciones_audit_upd
BEFORE UPDATE ON poblaciones
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := SYSTIMESTAMP;
END;
/

CREATE OR REPLACE TRIGGER tr_presup_sost_audit_upd
BEFORE UPDATE ON presupuestos_sostenibilidad
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := SYSTIMESTAMP;
END;
/

CREATE OR REPLACE TRIGGER tr_resultados_metricas_audit_upd
BEFORE UPDATE ON resultados_metricas
FOR EACH ROW
BEGIN
  :NEW.actualizado_el := SYSTIMESTAMP;
END;
/

/* ============================================================
   1) BLOQUEO POR PERIODO CERRADO (núcleo de integridad)
   Aplica a: resultados_metricas, evidencias (si están ligadas),
   y cualquier tabla operativa por periodo si deseas.
============================================================ */

CREATE OR REPLACE TRIGGER trg_bloqueo_periodo_cerrado_rm
BEFORE INSERT OR UPDATE OR DELETE ON resultados_metricas
FOR EACH ROW
DECLARE
  v_estado periodos.estado%TYPE;
  v_periodo_id periodos.id_periodo%TYPE;
BEGIN
  v_periodo_id := CASE WHEN DELETING THEN :OLD.id_periodo ELSE :NEW.id_periodo END;

  SELECT estado
    INTO v_estado
    FROM periodos
   WHERE id_periodo = v_periodo_id;

  IF v_estado = 'CERRADO' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Periodo CERRADO: no se permiten cambios en resultados_metricas.');
  END IF;
END;
/

-- (Opcional pero recomendado) Si evidencias cuelga de resultados_metricas, bloquea también:
CREATE OR REPLACE TRIGGER trg_bloqueo_periodo_cerrado_evid
BEFORE INSERT OR UPDATE OR DELETE ON evidencias
FOR EACH ROW
DECLARE
  v_estado periodos.estado%TYPE;
  v_periodo_id periodos.id_periodo%TYPE;
BEGIN
  -- si INSERT/UPDATE usa :NEW.id_resultado_met, si DELETE usa :OLD.id_resultado_met
  SELECT rm.id_periodo
    INTO v_periodo_id
    FROM resultados_metricas rm
   WHERE rm.id_resultado_met =
         CASE WHEN DELETING THEN :OLD.id_resultado_met ELSE :NEW.id_resultado_met END;

  SELECT estado
    INTO v_estado
    FROM periodos
   WHERE id_periodo = v_periodo_id;

  IF v_estado = 'CERRADO' THEN
    RAISE_APPLICATION_ERROR(-20002, 'Periodo CERRADO: no se permiten cambios en evidencias.');
  END IF;
END;
/

/* ============================================================
   2) VALIDACIONES NUMÉRICAS BÁSICAS (evitar datos basura)
============================================================ */

CREATE OR REPLACE TRIGGER trg_validaciones_rm
BEFORE INSERT OR UPDATE ON resultados_metricas
FOR EACH ROW
BEGIN
  IF :NEW.valor_real_utn IS NOT NULL AND :NEW.valor_real_utn < 0 THEN
    RAISE_APPLICATION_ERROR(-20010, 'valor_real_utn no puede ser negativo.');
  END IF;

  IF :NEW.puntaje_obtenido_met IS NOT NULL AND :NEW.puntaje_obtenido_met < 0 THEN
    RAISE_APPLICATION_ERROR(-20011, 'puntaje_obtenido_met no puede ser negativo.');
  END IF;
END;
/

/* ============================================================
   3) PUNTUACIÓN AUTOMÁTICA DE MÉTRICA (motor de scoring)
   Regla:
   - Busca el rango donde cae valor_real_utn para el indicador/version.
   - Asigna puntaje_obtenido_met.
   Recomendación: asegurar que exista escala/rangos para el indicador/version.
============================================================ */

CREATE OR REPLACE TRIGGER trg_puntuar_metrica_auto
BEFORE INSERT OR UPDATE OF valor_real_utn ON resultados_metricas
FOR EACH ROW
DECLARE
  v_puntaje NUMBER(10,2);
BEGIN
  v_puntaje := 0;

  /*
    Lógica:
    resultados_metricas -> metricas (id_metrica)
    metricas -> indicadores (id_indicador)
    escalas_evaluacion: por indicador + version
    rangos_evaluacion: por escala
    periodos: determina id_version
  */
  SELECT r.puntaje_asignado
    INTO v_puntaje
    FROM periodos p
    JOIN metricas m            ON m.id_metrica = :NEW.id_metrica
    JOIN escalas_evaluacion e  ON e.id_indicador = m.id_indicador
                              AND e.id_version  = p.id_version
    JOIN rangos_evaluacion r   ON r.id_escala = e.id_escala
   WHERE p.id_periodo = :NEW.id_periodo
     AND :NEW.valor_real_utn BETWEEN NVL(r.valor_minimo, :NEW.valor_real_utn)
                               AND NVL(r.valor_maximo, :NEW.valor_real_utn)
     AND ROWNUM = 1;

  :NEW.puntaje_obtenido_met := v_puntaje;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    :NEW.puntaje_obtenido_met := 0;
  WHEN TOO_MANY_ROWS THEN
    -- Si hay solapamiento de rangos, toma 0 para forzar corrección del catálogo
    :NEW.puntaje_obtenido_met := 0;
END;
/

/* ============================================================
   4) PROCEDIMIENTO DE CONSOLIDACIÓN (SIN TRIGGER MUTANTE)
   - Recalcula: resultados_indicadores, resultados_categorias, resultados_generales
   - No se ejecuta automáticamente aquí (lo llamas desde APEX al guardar,
     o lo agendas con un job / trigger de agenda).
============================================================ */

CREATE OR REPLACE PROCEDURE prc_recalcular_totales_ranking(p_periodo_id NUMBER) IS
BEGIN
  /* A) indicadores */
  MERGE INTO resultados_indicadores ri
  USING (
    SELECT m.id_indicador,
           rm.id_periodo,
           SUM(m.puntaje_max_met) AS maximo,
           SUM(rm.puntaje_obtenido_met) AS obtenido
      FROM resultados_metricas rm
      JOIN metricas m ON m.id_metrica = rm.id_metrica
      JOIN estados_evaluacion ee ON ee.id_estado = rm.id_estado
     WHERE rm.id_periodo = p_periodo_id
       AND ee.codigo = 'VALIDADA'
     GROUP BY m.id_indicador, rm.id_periodo
  ) src
  ON (ri.id_indicador = src.id_indicador AND ri.id_periodo = src.id_periodo)
  WHEN MATCHED THEN UPDATE SET
    ri.puntaje_maximo   = src.maximo,
    ri.puntaje_obtenido = src.obtenido,
    ri.porcentaje_logro = ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2)
  WHEN NOT MATCHED THEN INSERT
    (id_indicador, id_periodo, puntaje_maximo, puntaje_obtenido, porcentaje_logro)
  VALUES
    (src.id_indicador, src.id_periodo, src.maximo, src.obtenido,
     ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2));

  /* B) categorías */
  MERGE INTO resultados_categorias rc
  USING (
    SELECT i.id_categoria,
           ri.id_periodo,
           SUM(ri.puntaje_maximo) AS maximo,
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
    rc.porcentaje_logro = ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2)
  WHEN NOT MATCHED THEN INSERT
    (id_categoria, id_periodo, puntaje_maximo, puntaje_obtenido, porcentaje_logro)
  VALUES
    (src.id_categoria, src.id_periodo, src.maximo, src.obtenido,
     ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2));

  /* C) total general */
  MERGE INTO resultados_generales rg
  USING (
    SELECT id_periodo, SUM(puntaje_obtenido) AS total
      FROM resultados_categorias
     WHERE id_periodo = p_periodo_id
     GROUP BY id_periodo
  ) src
  ON (rg.id_periodo = src.id_periodo)
  WHEN MATCHED THEN UPDATE SET
    rg.puntaje_total = src.total
  WHEN NOT MATCHED THEN INSERT
    (id_periodo, puntaje_total)
  VALUES
    (src.id_periodo, src.total);

END;
/