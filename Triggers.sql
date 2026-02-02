/*******************************************************************************
 SCRIPT FINAL DE LOGICA Y AUTOMATIZACION: GREEN TECH METRICS - UTN
 Este script corrige errores de triggers, nombres de columnas y tablas mutantes.
 *******************************************************************************/

-- 1. TRIGGER DE AUDITORIA PARA UNIVERSIDADES
-- Mantiene actualizada la fecha de modificación automáticamente.
CREATE OR REPLACE TRIGGER tr_univ_upd 
BEFORE UPDATE ON universidades 
FOR EACH ROW 
BEGIN 
    :NEW.actualizado_el := CURRENT_TIMESTAMP;
END;
/

-- 2. TRIGGER DE AUDITORIA PARA PROGRAMAS
CREATE OR REPLACE TRIGGER tr_programas_upd 
BEFORE UPDATE ON programas 
FOR EACH ROW 
BEGIN 
    :NEW.actualizado_el := CURRENT_TIMESTAMP;
END;
/

-- 3. TRIGGER DE AUDITORIA PARA POBLACIONES
CREATE OR REPLACE TRIGGER tr_poblaciones_upd 
BEFORE UPDATE ON poblaciones 
FOR EACH ROW 
BEGIN 
    :NEW.actualizado_el := CURRENT_TIMESTAMP;
END;
/

-- 4. TRIGGER DE CALIFICACION AUTOMATICA (CORREGIDO)
-- Busca en RANGOS_EVALUACION y asigna el puntaje a PUNTAJE_OBTENIDO_MET.
CREATE OR REPLACE TRIGGER trg_puntuar_metrica_auto 
BEFORE INSERT OR UPDATE OF valor_real_utn ON resultados_metricas 
FOR EACH ROW 
DECLARE 
    v_puntaje NUMBER(10, 2) := 0;
BEGIN 
    -- Buscamos el puntaje exacto según el rango configurado para esa métrica
    SELECT r.puntaje_asignado INTO v_puntaje
    FROM rangos_evaluacion r
    JOIN escalas_evaluacion e ON r.id_escala = e.id_escala
    JOIN metricas m ON e.id_indicador = m.id_indicador
    WHERE m.id_metrica = :NEW.id_metrica
      AND :NEW.valor_real_utn BETWEEN r.valor_minimo AND r.valor_maximo
      AND ROWNUM = 1;

    :NEW.puntaje_obtenido_met := v_puntaje;

EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        :NEW.puntaje_obtenido_met := 0;
    WHEN OTHERS THEN 
        :NEW.puntaje_obtenido_met := 0;
END;
/

-- 5. TRIGGER DE BLOQUEO POR PERIODO CERRADO
-- Seguridad: Impide modificar datos si el año ya fue cerrado para auditoría.
CREATE OR REPLACE TRIGGER trg_bloqueo_periodo_cerrado 
BEFORE INSERT OR UPDATE OR DELETE ON resultados_metricas
FOR EACH ROW 
DECLARE 
    v_estado VARCHAR2(20);
    v_periodo_id NUMBER;
BEGIN 
    v_periodo_id := CASE WHEN DELETING THEN :OLD.id_periodo ELSE :NEW.id_periodo END;

    SELECT estado INTO v_estado FROM periodos WHERE id_periodo = v_periodo_id;

    IF v_estado = 'CERRADO' THEN 
        RAISE_APPLICATION_ERROR(-20001, 'ERROR: El periodo seleccionado ya está CERRADO y no permite cambios.');
    END IF;
END;
/

-- 6. PROCEDIMIENTO DE CONSOLIDACIÓN (REEMPLAZA TRIGGERS DE TOTALES)
-- Evita el error de "Tabla Mutante" al consolidar de métricas a categorías.
CREATE OR REPLACE PROCEDURE prc_recalcular_totales_ranking(p_periodo_id NUMBER) IS
BEGIN
    -- A. Actualizar Resultados por Indicador (Suma de métricas validadas)
    MERGE INTO resultados_indicadores ri 
    USING (
        SELECT m.id_indicador, rm.id_periodo,
               SUM(m.puntaje_max_met) AS maximo,
               SUM(rm.puntaje_obtenido_met) AS obtenido
        FROM resultados_metricas rm
        JOIN metricas m ON rm.id_metrica = m.id_metrica
        JOIN estados_evaluacion e ON rm.id_estado = e.id_estado
        WHERE rm.id_periodo = p_periodo_id
          AND e.codigo = 'VALIDADA'
        GROUP BY m.id_indicador, rm.id_periodo
    ) src ON (ri.id_indicador = src.id_indicador AND ri.id_periodo = src.id_periodo)
    WHEN MATCHED THEN
        UPDATE SET ri.puntaje_maximo = src.maximo, 
                   ri.puntaje_obtenido = src.obtenido,
                   ri.porcentaje_logro = ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2)
    WHEN NOT MATCHED THEN
        INSERT (id_indicador, id_periodo, puntaje_maximo, puntaje_obtenido, porcentaje_logro)
        VALUES (src.id_indicador, src.id_periodo, src.maximo, src.obtenido, 
                ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2));

    -- B. Actualizar Resultados por Categoría (Suma de indicadores)
    MERGE INTO resultados_categorias rc 
    USING (
        SELECT i.id_categoria, ri.id_periodo,
               SUM(ri.puntaje_maximo) AS maximo,
               SUM(ri.puntaje_obtenido) AS obtenido
        FROM resultados_indicadores ri
        JOIN indicadores i ON ri.id_indicador = i.id_indicador
        WHERE ri.id_periodo = p_periodo_id
        GROUP BY i.id_categoria, ri.id_periodo
    ) src ON (rc.id_categoria = src.id_categoria AND rc.id_periodo = src.id_periodo)
    WHEN MATCHED THEN
        UPDATE SET rc.puntaje_maximo = src.maximo, 
                   rc.puntaje_obtenido = src.obtenido,
                   rc.porcentaje_logro = ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2)
    WHEN NOT MATCHED THEN
        INSERT (id_categoria, id_periodo, puntaje_maximo, puntaje_obtenido, porcentaje_logro)
        VALUES (src.id_categoria, src.id_periodo, src.maximo, src.obtenido, 
                ROUND((src.obtenido / NULLIF(src.maximo, 0)) * 100, 2));

    -- C. Actualizar Gran Total Institucional
    MERGE INTO resultados_generales rg 
    USING (
        SELECT id_periodo, SUM(puntaje_obtenido) AS total
        FROM resultados_categorias
        WHERE id_periodo = p_periodo_id
        GROUP BY id_periodo
    ) src ON (rg.id_periodo = src.id_periodo)
    WHEN MATCHED THEN
        UPDATE SET rg.puntaje_total = src.total
    WHEN NOT MATCHED THEN
        INSERT (id_periodo, puntaje_total)
        VALUES (src.id_periodo, src.total);

    COMMIT;
END;
/

-- 7. FUNCIÓN DE SEGURIDAD RBAC (CORREGIDA)
-- Valida permisos uniendo la tabla intermedia de usuarios_roles correctamente.
CREATE OR REPLACE FUNCTION fn_tiene_permiso (
    p_usuario_id NUMBER,
    p_permiso VARCHAR2
) RETURN BOOLEAN IS 
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM usuarios u
    JOIN usuarios_roles ur ON u.id_usuario = ur.id_usuario
    JOIN roles r ON ur.id_rol = r.id_rol
    JOIN rol_permisos rp ON r.id_rol = rp.id_rol
    JOIN permisos p ON rp.id_permiso = p.id_permiso
    WHERE u.id_usuario = p_usuario_id
      AND p.clave = p_permiso
      AND ur.es_activo = 1;

    RETURN v_count > 0;
END;
/

-- 8. VISTA DE GESTION PARA APEX
-- Reporte unificado para los administradores de la UTN.
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
JOIN metricas m ON rm.id_metrica = m.id_metrica
JOIN indicadores i ON m.id_indicador = i.id_indicador
JOIN categorias c ON i.id_categoria = c.id_categoria
JOIN periodos p ON rm.id_periodo = p.id_periodo
JOIN estados_evaluacion e ON rm.id_estado = e.id_estado;


/*******************************************************************************
 PARTE 2: OPTIMIZACIÓN Y VISTAS PARA DASHBOARDS (REPORTES)
 Ejecuta esto después del script de triggers anterior.
 *******************************************************************************/

-- 1. ÍNDICES ESTRATÉGICOS
-- Aceleran las uniones (JOINs) en los reportes de APEX.
CREATE INDEX idx_res_met_periodo ON resultados_metricas (id_periodo, id_estado);
CREATE INDEX idx_res_ind_periodo ON resultados_indicadores (id_periodo);
CREATE INDEX idx_res_cat_periodo ON resultados_categorias (id_periodo);

-- 2. VISTA MATERIALIZADA: RESUMEN POR CATEGORÍA
-- Ideal para Gráficos de Radar o Barras en la página de inicio.
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
JOIN periodos p ON rc.id_periodo = p.id_periodo;

-- 3. VISTA MATERIALIZADA: DESEMPEÑO DE INDICADORES
-- Para ver qué áreas (Agua, Energía, Residuos) necesitan mejorar.
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
JOIN categorias c ON i.id_categoria = c.id_categoria
JOIN periodos p ON ri.id_periodo = p.id_periodo;

/*******************************************************************************
 PROCEDIMIENTO DE ACTUALIZACIÓN DE VISTAS (REFRESH)
 *******************************************************************************/
CREATE OR REPLACE PROCEDURE prc_actualizar_vistas_dashboard IS
BEGIN
    -- Refresca las vistas materializadas para que muestren los datos más recientes
    DBMS_MVIEW.REFRESH('mv_resumen_categorias');
    DBMS_MVIEW.REFRESH('mv_detalle_indicadores');
END;
/