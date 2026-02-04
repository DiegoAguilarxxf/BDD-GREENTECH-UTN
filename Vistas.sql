CREATE OR REPLACE VIEW vw_public_metricas_validadas AS
SELECT
    p.id_periodo,
    p.anio,
    c.id_categoria,
    c.codigo_ref,
    c.nombre        AS categoria,
    c.color_hex,
    i.id_indicador,
    i.codigo_indicador,
    i.nombre        AS indicador,
    m.id_metrica,
    m.nombre_metrica,
    m.puntaje_max_met,
    rm.valor_real_utn,
    rm.puntaje_obtenido_met,
    e.codigo        AS estado_codigo
FROM resultados_metricas rm
JOIN estados_evaluacion e ON e.id_estado = rm.id_estado
JOIN periodos p           ON p.id_periodo = rm.id_periodo
JOIN metricas m           ON m.id_metrica = rm.id_metrica
JOIN indicadores i        ON i.id_indicador = m.id_indicador
JOIN categorias c         ON c.id_categoria = i.id_categoria
WHERE e.codigo = 'VALIDADA'
  AND p.estado = 'CERRADO';


CREATE OR REPLACE VIEW vw_public_resumen_categoria AS
SELECT
    anio,
    id_categoria,
    codigo_ref,
    categoria,
    color_hex,
    SUM(puntaje_obtenido_met) AS puntaje_obtenido,
    SUM(puntaje_max_met)      AS puntaje_maximo,
    ROUND((SUM(puntaje_obtenido_met) / NULLIF(SUM(puntaje_max_met), 0)) * 100, 2) AS porcentaje_logro
FROM vw_public_metricas_validadas
GROUP BY anio, id_categoria, codigo_ref, categoria, color_hex;



CREATE OR REPLACE VIEW vw_public_resumen_indicador AS
SELECT
    anio,
    id_categoria,
    id_indicador,
    codigo_indicador,
    indicador,
    SUM(puntaje_obtenido_met) AS puntaje_obtenido,
    SUM(puntaje_max_met)      AS puntaje_maximo,
    ROUND((SUM(puntaje_obtenido_met) / NULLIF(SUM(puntaje_max_met), 0)) * 100, 2) AS porcentaje_logro
FROM vw_public_metricas_validadas
GROUP BY anio, id_categoria, id_indicador, codigo_indicador, indicador;



CREATE OR REPLACE VIEW vw_public_total_anual AS
SELECT
    anio,
    SUM(puntaje_obtenido_met) AS puntaje_total,
    SUM(puntaje_max_met)      AS puntaje_maximo,
    ROUND((SUM(puntaje_obtenido_met) / NULLIF(SUM(puntaje_max_met), 0)) * 100, 2) AS porcentaje_logro
FROM vw_public_metricas_validadas
GROUP BY anio;



CREATE OR REPLACE VIEW vw_public_ranking AS
SELECT
    p.anio,
    rg.puntaje_total,
    rg.posicion_nacional,
    rg.posicion_global,
    rg.total_universidades
FROM resultados_generales rg
JOIN periodos p ON p.id_periodo = rg.id_periodo;



