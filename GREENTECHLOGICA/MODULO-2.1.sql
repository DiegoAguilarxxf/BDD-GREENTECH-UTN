/*******************************************************************************
SISTEMA INTEGRAL GREEN TECH METRICS - UTN
MODULO 2.2 ODS, CATEGORÍAS, INDICADORES Y METRICAS TÉCNICAS
*******************************************************************************/

/*******************************************************************************
CARGA DE DATOS MAESTROS - OBJETIVOS DE DESARROLLO SOSTENIBLE (ONU)
*******************************************************************************/

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (1, 'Fin de la Pobreza', 
'Erradicación de la pobreza multidimensional mediante el fortalecimiento de la resiliencia económica y el acceso equitativo a recursos y servicios básicos.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (2, 'Hambre Cero', 
'Promoción de la seguridad alimentaria, la mejora de la nutrición institucional y el fomento de prácticas agrícolas sostenibles y resilientes.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (3, 'Salud y Bienestar', 
'Garantía de una vida saludable y promoción del bienestar integral para la comunidad universitaria en todas las etapas del desarrollo humano.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (4, 'Educación de Calidad', 
'Aseguramiento de una formación inclusiva, equitativa y de excelencia que promueva oportunidades de aprendizaje permanente y competencias para el desarrollo sostenible.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (5, 'Igualdad de Género', 
'Institucionalización de la paridad de género, eliminación de brechas de desigualdad y empoderamiento integral de mujeres y niñas en el ámbito académico y social.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (6, 'Agua Limpia y Saneamiento', 
'Gestión técnica e integral del recurso hídrico, garantizando su disponibilidad, saneamiento eficiente y tratamiento sostenible de vertidos.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (7, 'Energía Asequible y No Contaminante', 
'Transición hacia una matriz energética eficiente y renovable, asegurando servicios modernos, fiables y de bajo impacto ambiental para la infraestructura.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (8, 'Trabajo Decente y Crecimiento Económico', 
'Fomento de un entorno laboral productivo y seguro que impulse el crecimiento económico sostenido, inclusivo y la innovación profesional.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (9, 'Industria, Innovación e Infraestructura', 
'Desarrollo de infraestructuras resilientes, promoción de la industrialización sostenible y el fortalecimiento de la capacidad tecnológica y científica.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (10, 'Reducción de las Desigualdades', 
'Implementación de políticas inclusivas para reducir las disparidades socioeconómicas y garantizar la igualdad de oportunidades sin discriminación.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (11, 'Ciudades y Comunidades Sostenibles', 
'Transformación de los campus en entornos inclusivos, seguros y resilientes, minimizando el impacto ambiental negativo de la urbanización universitaria.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (12, 'Producción y Consumo Responsables', 
'Fomento de la economía circular mediante la gestión eficiente de recursos, reducción de desperdicios y adopción de modalidades de consumo sostenibles.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (13, 'Acción por el Clima', 
'Adopción de medidas estratégicas para la mitigación del cambio climático y el fortalecimiento de la resiliencia ante desastres naturales y emisiones de GEI.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (14, 'Vida Submarina', 
'Conservación y aprovechamiento sostenible de los ecosistemas marinos y costeros, combatiendo la contaminación y protegiendo la biodiversidad acuática.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (15, 'Vida de Ecosistemas Terrestres', 
'Protección y restauración de ecosistemas terrestres, gestión forestal sostenible y lucha contra la degradación de tierras y pérdida de biodiversidad.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (16, 'Paz, Justicia e Instituciones Sólidas', 
'Promoción de la transparencia institucional, acceso a la justicia y construcción de una cultura de paz basada en la rendición de cuentas y el estado de derecho.');

INSERT INTO ods (id_ods, nombre, descripcion) VALUES (17, 'Alianzas para lograr los Objetivos', 
'Fortalecimiento de la cooperación multisectorial y alianzas estratégicas globales para movilizar recursos y conocimientos en favor del desarrollo sostenible.');

COMMIT;

/*******************************************************************************
 CATEGORÍAS (CORREGIDAS)
 *******************************************************************************/

-- SI: Setting and Infrastructure
INSERT INTO categorias (codigo_ref, nombre, descripcion, peso_porcentaje, puntaje_maximo, color_hex, orden_visual) 
VALUES (
    'SI', 
    'Entorno e Infraestructura', 
    'Representa el compromiso de la UTN con la creación de un campus resiliente. Gestiona la relación entre las áreas edificadas y el entorno natural, priorizando la conservación de suelos permeables, la expansión de la infraestructura verde y la asignación presupuestaria estratégica para el mantenimiento de un ecosistema universitario sostenible.', 
    15.00, 
    1500, 
    '#2E7D32', 
    1
);

-- EC: Energy and Climate Change
INSERT INTO categorias (codigo_ref, nombre, descripcion, peso_porcentaje, puntaje_maximo, color_hex, orden_visual) 
VALUES (
    'EC', 
    'Energía y Cambio Climático', 
    'Pilar enfocado en la descarbonización institucional y la transición energética. Analiza la implementación de tecnologías inteligentes en edificaciones, el despliegue de fuentes de energía renovable en el campus y la ejecución de programas de mitigación para reducir la huella de carbono y combatir el calentamiento global.', 
    21.00, 
    2100, 
    '#FBC02D', 
    2
);

-- WS: Waste
INSERT INTO categorias (codigo_ref, nombre, descripcion, peso_porcentaje, puntaje_maximo, color_hex, orden_visual) 
VALUES (
    'WS', 
    'Gestión de Residuos', 
    'Promueve el modelo de economía circular dentro de la universidad. Incluye políticas estrictas de reducción de plásticos, el tratamiento técnico especializado de desechos orgánicos e inorgánicos, y la disposición segura de residuos químicos y tóxicos bajo estándares de seguridad biológica y ambiental.', 
    18.00, 
    1800, 
    '#5D4037', 
    3
);

-- WR: Water
INSERT INTO categorias (codigo_ref, nombre, descripcion, peso_porcentaje, puntaje_maximo, color_hex, orden_visual) 
VALUES (
    'WR', 
    'Recursos Hídricos', 
    'Mide la eficiencia en el ciclo de uso del agua. Se centra en la conservación del recurso mediante la implementación de sistemas de reciclaje (aguas grises), captación de agua pluvial y la instalación de infraestructura hidrosanitaria de última generación para minimizar el desperdicio y garantizar la sostenibilidad del suministro.', 
    10.00, 
    1000, 
    '#1976D2', 
    4
);

-- TR: Transportation
INSERT INTO categorias (codigo_ref, nombre, descripcion, peso_porcentaje, puntaje_maximo, color_hex, orden_visual) 
VALUES (
    'TR', 
    'Movilidad Sostenible', 
    'Estrategia de transporte dirigida a la movilidad de bajas emisiones. Fomenta la peatonalización inteligente, el uso de vehículos eléctricos e híbridos, la infraestructura para el transporte no motorizado (bicicletas) y políticas de reducción de vehículos privados para mejorar la calidad del aire en el campus.', 
    18.00, 
    1800, 
    '#616161', 
    5
);

-- ED: Education and Research
INSERT INTO categorias (codigo_ref, nombre, descripcion, peso_porcentaje, puntaje_maximo, color_hex, orden_visual) 
VALUES (
    'ED', 
    'Educación e Investigación', 
    'Refleja la misión académica de la UTN en la formación de líderes con conciencia ambiental. Evalúa la integración de la sostenibilidad en las mallas curriculares, el impacto de la investigación científica vinculada a los ODS y el rol de las organizaciones estudiantiles en la transformación social hacia un futuro sostenible.', 
    18.00, 
    1800, 
    '#C2185B', 
    6
);

COMMIT;


/*******************************************************************************
 CATEGORÍA SI 
 *******************************************************************************/

-- SI1
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI1', 'Ratio de área de espacio abierto respecto al área total', 
'Cálculo de la superficie no edificada en relación al terreno total del campus.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI2
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI2', 'Vegetación boscosa para investigación y vinculación', 
'Áreas con vegetación densa utilizadas para fines académicos o investigación.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI3
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI3', 'Área cubierta por vegetación plantada', 
'Superficie destinada a jardines, césped y techos verdes.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI4
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI4', 'Área de absorción de agua', 
'Superficie de suelo permeable destinada a la recarga de acuíferos.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI5
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI5', 'Espacio abierto disponible por persona', 
'Ratio de espacio abierto total por la población total del campus.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI6
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI6', 'Porcentaje del presupuesto para esfuerzos de sostenibilidad', 
'Inversión institucional dedicada a programas ambientales.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI7
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI7', 'Instalaciones para necesidades especiales y maternidad', 
'Evaluación de accesibilidad universal y espacios de maternidad.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI8
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI8', 'Instalaciones de seguridad y protección', 
'Equipamiento para garantizar la integridad de la comunidad.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI9
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI9', 'Infraestructura de salud y bienestar', 
'Disponibilidad de servicios médicos y centros de bienestar.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI10
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI10', 'Conservación de biodiversidad y recursos genéticos', 
'Instalaciones para la conservación de flora, fauna o recursos genéticos.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

-- SI11
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'SI11', 'TIC para la gestión y monitoreo de infraestructura', 
'Uso de tecnologías de información para la planificación de infraestructura.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'SI';

COMMIT;

/*******************************************************************************
 CATEGORÍA EC 
 *******************************************************************************/

-- EC1
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC1', 'Uso de aparatos de eficiencia energética', 
'Evaluación del uso de dispositivos certificados con estándares de bajo consumo.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC2
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC2', 'Implementación de edificios inteligentes', 
'Grado de automatización y control inteligente de servicios.', 300, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC3
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC3', 'Fuentes de energía renovable en el campus', 
'Disponibilidad de tecnologías de generación de energía limpia.', 300, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC4
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC4', 'Consumo eléctrico total per cápita (kWh por persona)', 
'Ratio del consumo de electricidad dividido por la población total.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC5
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC5', 'Ratio de producción de energía renovable vs consumo total', 
'Porcentaje de demanda anual cubierta por producción interna renovable.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC6
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC6', 'Elementos de construcción verde en los edificios', 
'Presencia de características de diseño sostenible integradas en edificios.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC7
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC7', 'Programa de reducción de emisiones de gases de efecto invernadero', 
'Existencia de políticas orientadas a disminuir emisiones de CO2.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC8
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC8', 'Huella de carbono total per cápita', 
'Cálculo de emisiones totales de carbono divididas por la población.', 200, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC9
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC9', 'Programas innovadores en energía y cambio climático', 
'Iniciativas de vanguardia para retos energéticos y climáticos.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC10
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC10', 'Programas universitarios de alto impacto sobre el clima', 
'Proyectos emblemáticos que generan cambio positivo medible.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

-- EC11
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'EC11', 'TIC para la gestión y evaluación de energía y clima', 
'Uso de TIC para planificar y monitorear programas de esta categoría.', 100, 'ACTIVO' 
FROM categorias WHERE codigo_ref = 'EC';

COMMIT;

/*******************************************************************************
 CATEGORÍA WS 
 *******************************************************************************/

-- WS1
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WS1', 'Programa 3R (Reducir, Reutilizar, Reciclar) para residuos universitarios', 
'Implementación de programas institucionales enfocados en la reducción, reutilización y reciclaje de desechos generados en el campus.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WS';

-- WS2
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WS2', 'Programa para reducir el uso de papel y plástico en el campus', 
'Políticas y acciones específicas dirigidas a disminuir el consumo de papel y plásticos de un solo uso en todas las dependencias.', 
300, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WS';

-- WS3
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WS3', 'Tratamiento de residuos orgánicos', 
'Métodos y procesos aplicados para el manejo y valorización de desechos biodegradables (compostaje, digestión anaerobia, etc.).', 
300, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WS';

-- WS4
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WS4', 'Tratamiento de residuos inorgánicos', 
'Sistemas de gestión para residuos no biodegradables, enfocados en su recolección diferenciada, procesamiento y reciclaje técnico.', 
300, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WS';

-- WS5
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WS5', 'Tratamiento de residuos tóxicos', 
'Procedimientos técnicos para la gestión segura y disposición final de residuos peligrosos (químicos, biológicos, electrónicos, etc.).', 
300, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WS';

-- WS6
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WS6', 'Disposición de aguas residuales', 
'Gestión del alcantarillado y tratamiento de efluentes líquidos para prevenir la contaminación del suelo y fuentes de agua.', 
300, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WS';

-- WS7
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WS7', 'TIC para la gestión y evaluación del manejo de residuos', 
'Uso de tecnologías de información para la planificación, implementación, monitoreo y/o evaluación de todos los programas de gestión de residuos.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WS';

COMMIT;


/*******************************************************************************
 CATEGORÍA WR 
 *******************************************************************************/

-- WR1
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WR1', 'Programa e implementación de conservación de agua', 
'Desarrollo y ejecución de políticas institucionales para reducir el consumo de agua y promover su uso responsable en todo el campus.', 
150, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WR';

-- WR2
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WR2', 'Implementación de programas de reciclaje de agua', 
'Existencia de infraestructura y procesos para el tratamiento y reutilización de agua (aguas grises o tratadas) dentro de las instalaciones.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WR';

-- WR3
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WR3', 'Uso de dispositivos de eficiencia hídrica', 
'Porcentaje de implementación de grifería, inodoros y sistemas de bajo flujo para minimizar el desperdicio del recurso en edificios.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WR';

-- WR4
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WR4', 'Consumo de agua tratada', 
'Mide el volumen de agua que ha pasado por procesos de tratamiento consumida en el campus, fomentando el uso de agua recuperada.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WR';

-- WR5
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WR5', 'Control de la contaminación del agua en el área del campus', 
'Estrategias y monitoreo para prevenir la contaminación de fuentes de agua locales y asegurar que los vertidos cumplan con normativas ambientales.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WR';

-- WR6
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'WR6', 'TIC para la gestión y evaluación del manejo del agua', 
'Uso de tecnologías de información para la planificación, implementación, monitoreo y/o evaluación de todos los programas relacionados con el agua.', 
50, 'ACTIVO' FROM categorias WHERE codigo_ref = 'WR';

COMMIT;

/*******************************************************************************
 CATEGORÍA TR (INDICADORES CORREGIDOS - DESCRIPCIONES INTEGRADAS)
 *******************************************************************************/

-- TR1
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR1', 'Ratio de vehículos de combustión por población total', 
'Suma total de automóviles y motocicletas con motor de combustión interna dividida por la población total del campus.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR2
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR2', 'Servicios de transporte interno (Shuttle)', 
'Disponibilidad, frecuencia y capacidad de los servicios de transporte colectivo proporcionados por la universidad para la comunidad.', 
250, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR3
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR3', 'Disponibilidad de Vehículos de Cero Emisiones (ZEV)', 
'Conteo y disponibilidad de vehículos eléctricos o no motorizados (bicicletas) que operan activamente dentro del campus.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR4
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR4', 'Ratio de vehículos ZEV por población universitaria', 
'Proporción de vehículos de cero emisiones disponibles en relación al número total de integrantes de la institución.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR5
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR5', 'Ratio de área de estacionamiento respecto al área total', 
'Superficie total destinada al parqueo vehicular en superficie en relación con la extensión territorial total del campus.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR6
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR6', 'Programa de reducción de áreas de estacionamiento', 
'Iniciativas implementadas en los últimos 3 años para limitar o disminuir el espacio físico dedicado al parqueo de vehículos.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR7
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR7', 'Iniciativas para reducir el uso de vehículos privados', 
'Cantidad de programas activos (carpooling, incentivos, teletrabajo) diseñados para desincentivar el ingreso de autos particulares.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR8
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR8', 'Infraestructura de senderos peatonales', 
'Evaluación de la extensión, seguridad y accesibilidad de las vías exclusivas para peatones dentro de las instalaciones universitarias.', 
250, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

-- TR9
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'TR9', 'TIC para la gestión y evaluación del transporte', 
'Uso de tecnologías de información para la planificación, implementación, monitoreo y/o evaluación de todos los programas de movilidad.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'TR';

COMMIT;



/*******************************************************************************
 CATEGORÍA ED (INDICADORES CORREGIDOS - GUÍA 2025)
 *******************************************************************************/

-- ED1
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED1', 'Ratio de cursos de sostenibilidad vs total de cursos', 
'Proporción de asignaturas sobre desarrollo sostenible en relación al total de materias dictadas en la universidad.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED2
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED2', 'Ratio de presupuesto de investigación en sostenibilidad', 
'Porcentaje de financiamiento dedicado a investigación en sostenibilidad respecto al presupuesto total de investigación.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED3
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED3', 'Ratio de publicaciones científicas sobre sostenibilidad', 
'Número de publicaciones académicas indexadas sobre sostenibilidad divididas por el total de docentes e investigadores de la institución.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED4
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED4', 'Número de eventos relacionados con la sostenibilidad', 
'Cantidad total de conferencias, talleres y seminarios enfocados en el medio ambiente y sostenibilidad organizados por la universidad.', 
150, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED5
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED5', 'Actividades de sostenibilidad lideradas por estudiantes', 
'Número anual de acciones o proyectos organizados por grupos y organizaciones estudiantiles vinculados a la sostenibilidad.', 
150, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED6
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED6', 'Sitio web institucional de sostenibilidad', 
'Evaluación del portal web dedicado a la difusión de políticas, datos y avances sostenibles de la universidad.', 
200, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED7
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED7', 'Reporte de sostenibilidad institucional', 
'Disponibilidad de un informe técnico periódico que documente el desempeño ambiental y social de la institución.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED8
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED8', 'Número de actividades culturales en el campus', 
'Eventos culturales que promueven la identidad, la inclusión y la conciencia social dentro de la comunidad universitaria.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED9
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED9', 'Programas de sostenibilidad con colaboración internacional', 
'Cantidad de programas de sostenibilidad desarrollados en alianza con universidades o redes internacionales.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED10
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED10', 'Servicios comunitarios vinculados a la sostenibilidad', 
'Proyectos de vinculación con la sociedad que involucran a estudiantes y abordan problemas ambientales o sociales.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED11
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED11', 'Número de startups relacionadas con la sostenibilidad', 
'Empresas emergentes o emprendimientos con enfoque sostenible incubados o apoyados por la universidad.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED12
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED12', 'Porcentaje de graduados con empleos verdes (Green Jobs)', 
'Proporción de egresados de los últimos 3 años que trabajan en sectores vinculados a la economía verde y sostenibilidad.', 
50, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED13
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED13', 'Oficina o unidad de gestión de sostenibilidad', 
'Existencia formal de una dependencia administrativa encargada de coordinar las políticas ambientales en el campus.', 
50, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

-- ED14
INSERT INTO indicadores (id_categoria, codigo_indicador, nombre, descripcion, puntaje_maximo, estado)
SELECT id_categoria, 'ED14', 'TIC para la gestión y evaluación de la gobernanza universitaria', 
'Uso de tecnologías de información para la planificación, implementación y monitoreo de la gobernanza institucional sostenible.', 
100, 'ACTIVO' FROM categorias WHERE codigo_ref = 'ED';

COMMIT;


/*******************************************************************************
 VINCULACIÓN INDICADORES - ODS 
 *******************************************************************************/

-- ODS 3: Salud y Bienestar
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 3 FROM indicadores WHERE codigo_indicador IN ('SI8', 'SI9');

-- ODS 4: Educación de Calidad
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 4 FROM indicadores WHERE codigo_indicador LIKE 'ED%';

-- ODS 6: Agua Limpia y Saneamiento
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 6 FROM indicadores WHERE codigo_indicador LIKE 'WR%' OR codigo_indicador = 'WS6';

-- ODS 7: Energía Asequible y No Contaminante
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 7 FROM indicadores WHERE codigo_indicador IN ('EC1', 'EC2', 'EC3', 'EC4', 'EC5', 'EC6');

-- ODS 8: Trabajo Decente y Crecimiento Económico
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 8 FROM indicadores WHERE codigo_indicador IN ('ED11', 'ED12');

-- ODS 9: Industria, Innovación e Infraestructura
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 9 FROM indicadores WHERE codigo_indicador IN ('SI11', 'EC11', 'WS7', 'WR6', 'TR9', 'ED14');

-- ODS 11: Ciudades y Comunidades Sostenibles
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 11 FROM indicadores WHERE codigo_indicador IN ('SI1', 'SI3', 'SI5', 'TR1', 'TR2', 'TR7', 'TR8');

-- ODS 12: Producción y Consumo Responsables
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 12 FROM indicadores WHERE codigo_indicador IN ('WS1', 'WS2', 'WS3', 'WS4', 'WS5');

-- ODS 13: Acción por el Clima
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 13 FROM indicadores WHERE codigo_indicador IN ('EC7', 'EC8', 'EC9', 'EC10', 'TR3', 'TR4');

-- ODS 15: Vida de Ecosistemas Terrestres
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 15 FROM indicadores WHERE codigo_indicador IN ('SI2', 'SI4', 'SI10');

-- ODS 17: Alianzas para lograr los Objetivos
INSERT INTO indicadores_ods (id_indicador, id_ods)
SELECT id_indicador, 17 FROM indicadores WHERE codigo_indicador = 'ED9';

COMMIT;