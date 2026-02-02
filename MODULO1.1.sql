/*******************************************************************************
 PASO 1: LIMPIEZA Y PREPARACIÓN DE VERSIÓN
 *******************************************************************************/
-- 1. Limpiar datos de prueba
TRUNCATE TABLE rangos_evaluacion;

DELETE FROM
    escalas_evaluacion;

DELETE FROM
    versiones_evaluacion;

-- 2. CREAR LA VERSIÓN (Sin esto, las escalas fallan por FK)
INSERT INTO
    versiones_evaluacion (nombre, anio_referencia, es_activa, notas_cambio)
VALUES
    (
        'UI GreenMetric Guideline 2025',
        2025,
        'S',
        'Configuración inicial de rangos para la UTN'
    );

COMMIT;

DECLARE -- Variables para capturar IDs de escalas
v_id_si1 NUMBER;

v_id_si2 NUMBER;

v_id_ec1 NUMBER;

v_id_ec4 NUMBER;

v_id_ec8 NUMBER;

v_id_ws3 NUMBER;

v_id_ws4 NUMBER;

v_id_wr3 NUMBER;

v_id_wr4 NUMBER;

v_id_tr1 NUMBER;

v_id_tr5 NUMBER;

v_id_ed1 NUMBER;

v_id_ed3 NUMBER;

v_version_id NUMBER;

BEGIN -- 1. LIMPIEZA TOTAL DE CONFIGURACIONES PREVIAS
EXECUTE IMMEDIATE 'TRUNCATE TABLE rangos_evaluacion';

DELETE FROM
    escalas_evaluacion;

DELETE FROM
    versiones_evaluacion;

-- 2. CREACIÓN DE LA VERSIÓN OFICIAL
INSERT INTO
    versiones_evaluacion (nombre, anio_referencia, es_activa, notas_cambio)
VALUES
    (
        'UI GreenMetric Guideline 2025',
        2025,
        'S',
        'Configuración integral UTN'
    ) RETURNING id_version INTO v_version_id;

-- 3. GENERACIÓN DE ESCALAS PARA TODOS LOS INDICADORES
INSERT INTO
    escalas_evaluacion (
        id_indicador,
        id_version,
        tipo_escala,
        descripcion
    )
SELECT
    id_indicador,
    v_version_id,
    'Oficial 2025',
    'Escala para ' || codigo_indicador
FROM
    indicadores;

-- 4. CAPTURA DE IDS ESPECÍFICOS PARA RANGOS COMPLEJOS
SELECT
    e.id_escala INTO v_id_si1
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'SI1';

SELECT
    e.id_escala INTO v_id_si2
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'SI2';

SELECT
    e.id_escala INTO v_id_ec1
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'EC1';

SELECT
    e.id_escala INTO v_id_ec4
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'EC4';

SELECT
    e.id_escala INTO v_id_ec8
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'EC8';

SELECT
    e.id_escala INTO v_id_ws3
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'WS3';

SELECT
    e.id_escala INTO v_id_ws4
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'WS4';

SELECT
    e.id_escala INTO v_id_wr3
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'WR3';

SELECT
    e.id_escala INTO v_id_wr4
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'WR4';

SELECT
    e.id_escala INTO v_id_tr1
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'TR1';

SELECT
    e.id_escala INTO v_id_tr5
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'TR5';

SELECT
    e.id_escala INTO v_id_ed1
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'ED1';

SELECT
    e.id_escala INTO v_id_ed3
FROM
    escalas_evaluacion e
    JOIN indicadores i ON e.id_indicador = i.id_indicador
WHERE
    i.codigo_indicador = 'ED3';

-- 5. INSERCIÓN DE RANGOS TÉCNICOS (EJEMPLOS CLAVE)
-- SI1
INSERT INTO
    rangos_evaluacion (
        id_escala,
        nivel,
        valor_minimo,
        valor_maximo,
        puntaje_asignado,
        descripcion
    )
VALUES
    (v_id_si1, 1, 0, 1, 40, '≤ 1%');

INSERT INTO
    rangos_evaluacion (
        id_escala,
        nivel,
        valor_minimo,
        valor_maximo,
        puntaje_asignado,
        descripcion
    )
VALUES
    (v_id_si1, 5, 95.01, 100, 200, '> 95%');

-- EC4
INSERT INTO
    rangos_evaluacion (
        id_escala,
        nivel,
        valor_minimo,
        valor_maximo,
        puntaje_asignado,
        descripcion
    )
VALUES
    (v_id_ec4, 1, 2400, 999999, 40, '>= 2400 kWh');

INSERT INTO
    rangos_evaluacion (
        id_escala,
        nivel,
        valor_minimo,
        valor_maximo,
        puntaje_asignado,
        descripcion
    )
VALUES
    (v_id_ec4, 5, 0, 249.99, 200, '< 250 kWh');

-- TR1 (Lógica Inversa)
INSERT INTO
    rangos_evaluacion (
        id_escala,
        nivel,
        valor_minimo,
        valor_maximo,
        puntaje_asignado,
        descripcion
    )
VALUES
    (v_id_tr1, 1, 1, 9999, 40, 'Ratio >= 1.0');

INSERT INTO
    rangos_evaluacion (
        id_escala,
        nivel,
        valor_minimo,
        valor_maximo,
        puntaje_asignado,
        descripcion
    )
VALUES
    (v_id_tr1, 5, 0, 0.044, 200, 'Ratio < 0.045');

-- 6. CARGA AUTOMÁTICA DE TODOS LOS INDICADORES RESTANTES (CUALITATIVOS)
-- Aplica para los 58 indicadores basándose en su puntaje máximo
FOR rec IN (
    SELECT
        e.id_escala,
        i.puntaje_maximo
    FROM
        escalas_evaluacion e
        JOIN indicadores i ON e.id_indicador = i.id_indicador
    WHERE
        NOT EXISTS (
            SELECT
                1
            FROM
                rangos_evaluacion r
            WHERE
                r.id_escala = e.id_escala
        )
) LOOP FOR n IN 1..5 LOOP
INSERT INTO
    rangos_evaluacion (
        id_escala,
        nivel,
        valor_minimo,
        valor_maximo,
        puntaje_asignado,
        descripcion
    )
VALUES
    (
        rec.id_escala,
        n,
        n,
        n,
        (rec.puntaje_maximo / 5) * n,
        'Nivel ' || n
    );

END LOOP;

END LOOP;

COMMIT;

END;