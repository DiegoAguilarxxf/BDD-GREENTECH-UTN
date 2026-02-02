/*******************************************************************************
 SISTEMA INTEGRAL GREEN TECH METRICS - UTN
 MODULO 3.1: CARGA DE MÉTRICAS - CATEGORÍA SI 
 *******************************************************************************/

-- 1.1 al 1.7: Información General y Base de Cálculo
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.1 Types of higher education institution', 'Tipo', 0, '[1] Comprehensive, [2] Specialized higher education institution' FROM indicadores WHERE codigo_indicador = 'SI1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.2 Climate', 'Categoría', 0, '[1] Tropical wet, [2] Tropical wet and dry, [3] Semiarid, [4] Arid, [5] Mediterranean, [6] Humid subtropical, [7] Marine west coast / oceanic climate, [8] Humid continental, [9] Subarctic' FROM indicadores WHERE codigo_indicador = 'SI1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.3 Number of campus sites', 'Cantidad', 0, 'Provide number of separate campus sites' FROM indicadores WHERE codigo_indicador = 'SI1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.4 Campus setting', 'Tipo', 0, '[1] Rural, [2] Suburban, [3] Urban, [4] City center, [5] High-rise building area' FROM indicadores WHERE codigo_indicador = 'SI1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.5 Total campus area (m2)', 'm2', 0, 'Total area of the campus in square meters' FROM indicadores WHERE codigo_indicador = 'SI1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.6 Total campus ground floor area of buildings (m2)', 'm2', 0, 'Total footprint area of all buildings' FROM indicadores WHERE codigo_indicador = 'SI1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.7 Total campus buildings area (m2)', 'm2', 0, 'Total floor area of all buildings (all floors)' FROM indicadores WHERE codigo_indicador = 'SI1';

-- 1.8 al 1.11: Indicadores SI1 a SI4
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.8 SI1 The ratio of open space area to total area', '%', 200, '[1] <= 1%, [2] > 1 - 80%, [3] > 80 - 90%, [4] > 90 - 95%, [5] > 95%' FROM indicadores WHERE codigo_indicador = 'SI1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.9 SI2 Total area on campus covered in forest vegetation', '%', 100, '[1] <= 2%, [2] > 2 - 10%, [3] > 10 - 25%, [4] > 25 - 35%, [5] > 35%' FROM indicadores WHERE codigo_indicador = 'SI2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.10 SI3 Total area on campus covered in planted vegetation', '%', 200, '[1] <= 10%, [2] > 10 - 20%, [3] > 20 - 30%, [4] > 30 - 50%, [5] > 50%' FROM indicadores WHERE codigo_indicador = 'SI3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.11 SI4 Total area on campus for water absorption', '%', 100, '[1] <= 2%, [2] > 2 - 10%, [3] > 10 - 20%, [4] > 20 - 40%, [5] > 40%' FROM indicadores WHERE codigo_indicador = 'SI4';

-- 1.12 al 1.15: Población e Indicador SI5
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.12 Total number of regular students', 'Población', 0, 'Number of students on campus' FROM indicadores WHERE codigo_indicador = 'SI5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.13 Total number of online students', 'Población', 0, 'Number of students studying online' FROM indicadores WHERE codigo_indicador = 'SI5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.14 Total number of academic and administrative staff', 'Población', 0, 'Total staff members' FROM indicadores WHERE codigo_indicador = 'SI5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.15 SI5 The total open space area divided by the total campus population', 'm2/p', 200, '[1] <= 10 m2/person, [2] > 10 - 20 m2/person, [3] > 20 - 40 m2/person, [4] > 40 - 70 m2/person, [5] > 70 m2/person' FROM indicadores WHERE codigo_indicador = 'SI5';

-- 1.16 al 1.18: Presupuesto e Indicador SI6
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.16 Total university budget (in US Dollars)', 'USD', 0, 'Total annual operational and capital budget' FROM indicadores WHERE codigo_indicador = 'SI6';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.17 University budget for sustainability effort (in US Dollars)', 'USD', 0, 'Annual budget for green and sustainable projects' FROM indicadores WHERE codigo_indicador = 'SI6';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.18 SI6 Percentage of university budget for sustainability efforts', '%', 200, '[1] <= 1%, [2] > 1 - 5%, [3] > 5 - 10%, [4] > 10 - 15%, [5] > 15%' FROM indicadores WHERE codigo_indicador = 'SI6';

-- 1.19 al 1.21: Facilidades e Infraestructura
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.19 SI7 Campus facilities for disabled, special needs and/or maternity care', 'Escala', 100, '[1] None, [2] Policy is in place, [3] Facilities are in the planning stage, [4] Facilities are partially available and operated, [5] Facilities exist in all buildings and are fully operated' FROM indicadores WHERE codigo_indicador = 'SI7';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.20 SI8 Security and safety facilities', 'Escala', 100, '[1] Passive security and safety system, [2] CCTV and emergency hotline/button fully functioning, [3] CCTV, hotline, certified personnel, fire extinguisher and hydrant fully functioning, [4] Full infrastructure and response time > 5 min, [5] Full infrastructure and response time < 5 min' FROM indicadores WHERE codigo_indicador = 'SI8';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.21 SI9 Health infrastructure facilities', 'Escala', 100, '[1] Not available, [2] First aid, emergency room, clinic and personnel available, [3] First aid, emergency room, clinic and certified personnel available, [4] First aid, emergency room, clinic, hospital and certified personnel available, [5] Full health infrastructure system and accessible for public' FROM indicadores WHERE codigo_indicador = 'SI9';

-- 1.22 al 1.24: Conservación, TICs e Impacto ODS
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.22 SI10 Conservation: plant (flora), animal (fauna), or wildlife', 'Escala', 100, '[1] Program in preparation, [2] 1-25% implemented, [3] 25-50% implemented, [4] 50-75% implemented, [5] >75% implemented' FROM indicadores WHERE codigo_indicador = 'SI10';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.23 SI11 ICT for Setting and Infrastructure management', 'Escala', 100, '[1] None, [2] Planning stage, [3] Implemented, [4] Implemented and evaluated, [5] Implemented, evaluated and revised' FROM indicadores WHERE codigo_indicador = 'SI11';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '1.24 Impact of SI programs in supporting the SDGs', 'Escala', 0, '[1] Low (1-2 SDGs), [2] Moderate (3-5 SDGs), [3] Significant (6-9 SDGs), [4] High (10-13 SDGs), [5] Very high (14-17 SDGs)' FROM indicadores WHERE codigo_indicador = 'SI11';

COMMIT;

/*******************************************************************************
 SISTEMA INTEGRAL GREEN TECH METRICS - UTN
 MODULO 3.2: CARGA COMPLETA - CATEGORÍA EC (CORREGIDO)
 *******************************************************************************/

-- 2.1 EC1: Energy efficient appliances usage
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.1 EC1 Energy efficient appliances usage', '%', 200, '[1] < 1%, [2] 1 - 25%, [3] > 25 - 50%, [4] > 50 - 75%, [5] > 75%' FROM indicadores WHERE codigo_indicador = 'EC1';

-- 2.2 y 2.3: Smart Buildings
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.2 Total campus smart building area (m2)', 'm2', 0, 'Total area of smart buildings' FROM indicadores WHERE codigo_indicador = 'EC2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.3 EC2 Smart building implementation', '%', 300, '[1] < 1%, [2] 1 - 25%, [3] > 25 - 50%, [4] > 50 - 75%, [5] > 75%' FROM indicadores WHERE codigo_indicador = 'EC2';

-- 2.4 y 2.5: Renewable Energy Sources
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.4 EC3 Number of renewable energy sources on campus', 'Cantidad', 300, '[1] None, [2] 1 source, [3] 2 sources, [4] 3 sources, [5] > 3 sources' FROM indicadores WHERE codigo_indicador = 'EC3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.5 Renewable energy sources and production', 'Lista', 0, '[1] None, [2] Bio diesel, [3] Clean biomass, [4] Solar, [5] Geothermal, [6] Wind, [7] Hydropower, [8] CHP' FROM indicadores WHERE codigo_indicador = 'EC3';

-- 2.6 y 2.7: Electricity Usage
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.6 Electricity usage per year (kWh)', 'kWh', 0, 'Total consumption in the last 12 months' FROM indicadores WHERE codigo_indicador = 'EC4';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.7 EC4 Total electricity usage divided by total campus population', 'kWh/p', 200, '[1] >= 2400, [2] 1500-2400, [3] 600-1500, [4] 250-600, [5] < 250' FROM indicadores WHERE codigo_indicador = 'EC4';

-- 2.8 EC5: Ratio of renewable energy production
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.8 EC5 Ratio of renewable energy production divided by total energy usage', '%', 200, '[1] <= 0.5%, [2] 0.5-1%, [3] 1-2%, [4] 2-25%, [5] > 25%' FROM indicadores WHERE codigo_indicador = 'EC5';

-- 2.9 EC6: Green Building Elements
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.9 EC6 Elements of green building implementation', 'Elementos', 200, '[1] None, [2] 1 element, [3] 2 elements, [4] 3 elements, [5] > 3 elements' FROM indicadores WHERE codigo_indicador = 'EC6';

-- 2.10 EC7: GHG Reduction Program
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.10 EC7 Greenhouse gas emission reduction program', 'Escala', 200, '[1] None, [2] Preparation, [3] Scope 1/2/3, [4] Two scopes, [5] All three scopes' FROM indicadores WHERE codigo_indicador = 'EC7';

-- 2.11 y 2.12: Carbon Footprint
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.11 Total carbon footprint (CO2 emission in metric tons)', 'tons', 0, 'Total footprint last 12 months' FROM indicadores WHERE codigo_indicador = 'EC8';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.12 EC8 Total carbon footprint divided by total population', 'tons/p', 200, '[1] >= 2.05, [2] 1.11-2.05, [3] 0.42-1.11, [4] 0.10-0.42, [5] < 0.10' FROM indicadores WHERE codigo_indicador = 'EC8';

-- 2.13 EC9: Innovative Programs
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.13 EC9 Number of innovative program(s) in energy and climate change', 'Programas', 100, '[1] None, [2] 1, [3] 2, [4] 3, [5] > 3 programs' FROM indicadores WHERE codigo_indicador = 'EC9';

-- 2.14 EC10: Impactful Programs
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.14 EC10 Impactful university program(s) on climate change', 'Impacto', 100, '[1] None, [2] Preparation, [3] Local, [4] National, [5] International' FROM indicadores WHERE codigo_indicador = 'EC10';

-- 2.15 EC11: ICT for Energy management
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.15 EC11 ICT for Energy and Climate Change management', 'Escala', 100, '[1] None, [2] Planning, [3] Implemented, [4] Evaluated, [5] Revised' FROM indicadores WHERE codigo_indicador = 'EC11';

-- 2.16 Impact on SDGs
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '2.16 Impact of EC programs in supporting the SDGs', 'Escala', 0, '[1] Low, [2] Moderate, [3] Significant, [4] High, [5] Very high' FROM indicadores WHERE codigo_indicador = 'EC11';

COMMIT;


/*******************************************************************************
SISTEMA INTEGRAL GREEN TECH METRICS - UTN
MODULO 3.3: CATEGORÍA WS (WASTE)
*******************************************************************************/

-- Limpieza preventiva para la categoría WS
DELETE FROM metricas 
WHERE id_indicador IN (SELECT id_indicador FROM indicadores WHERE codigo_indicador LIKE 'WS%');

-- 3.1 WS1: 3R Program
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.1 WS1 3R program for university waste', 'Escala', 200, '[1] None, [2] Preparation, [3] 1–50% implemented, [4] >50–75% implemented, [5] >75% implemented' 
FROM indicadores WHERE codigo_indicador = 'WS1';

-- 3.2, 3.3 y 3.4: WS2 Program to reduce paper and plastic
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.2 Total volume of paper and plastic produced this year', 'm3/ton', 0, 'Current year production' FROM indicadores WHERE codigo_indicador = 'WS2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.3 Total volume of paper and plastic produced last year', 'm3/ton', 0, 'Last year production' FROM indicadores WHERE codigo_indicador = 'WS2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.4 WS2 Program to reduce the use of paper and plastic', 'Programas', 300, '[1] None, [2] 1-3, [3] 4-6, [4] 7-10, [5] > 10 programs' FROM indicadores WHERE codigo_indicador = 'WS2';

-- 3.5, 3.6, 3.7 y 3.8: WS3 Organic waste treatment
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.5 Total volume organic waste produced this year', 'm3/ton', 0, 'Organic generated this year' FROM indicadores WHERE codigo_indicador = 'WS3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.6 Total volume organic waste produced last year', 'm3/ton', 0, 'Organic generated last year' FROM indicadores WHERE codigo_indicador = 'WS3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.7 Total volume organic waste treated this year', 'm3/ton', 0, 'Organic treated this year' FROM indicadores WHERE codigo_indicador = 'WS3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.8 WS3 Organic waste treatment', 'Escala', 300, '[1] Open dumping, [2] 1-35%, [3] >35-65%, [4] >65-85%, [5] >85% treated' FROM indicadores WHERE codigo_indicador = 'WS3';

-- 3.9, 3.10, 3.11 y 3.12: WS4 Inorganic waste treatment
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.9 Total volume inorganic waste produced this year', 'm3/ton', 0, 'Inorganic generated this year' FROM indicadores WHERE codigo_indicador = 'WS4';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.10 Total volume inorganic waste produced last year', 'm3/ton', 0, 'Inorganic generated last year' FROM indicadores WHERE codigo_indicador = 'WS4';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.11 Total volume inorganic waste treated this year', 'm3/ton', 0, 'Inorganic treated this year' FROM indicadores WHERE codigo_indicador = 'WS4';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.12 WS4 Inorganic waste treatment', 'Escala', 300, '[1] Burned, [2] 1-35%, [3] >35-65%, [4] >65-85%, [5] >85% treated' FROM indicadores WHERE codigo_indicador = 'WS4';

-- 3.13, 3.14, 3.15 y 3.16: WS5 Toxic waste treatment
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.13 Total volume toxic waste produced this year', 'm3/ton', 0, 'Toxic generated this year' FROM indicadores WHERE codigo_indicador = 'WS5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.14 Total volume toxic waste produced last year', 'm3/ton', 0, 'Toxic generated last year' FROM indicadores WHERE codigo_indicador = 'WS5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.15 Total volume toxic waste treated this year', 'm3/ton', 0, 'Toxic treated this year' FROM indicadores WHERE codigo_indicador = 'WS5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.16 WS5 Toxic waste treatment', 'Escala', 300, '[1] Not managed, [2] 1-35%, [3] >35-65%, [4] >65-85%, [5] >85% or minimum amount' FROM indicadores WHERE codigo_indicador = 'WS5';

-- 3.17 WS6: Sewage disposal
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.17 WS6 Sewage disposal', 'Escala', 300, '[1] Untreated, [2] Preliminary, [3] Primary, [4] Secondary, [5] Tertiary' FROM indicadores WHERE codigo_indicador = 'WS6';

-- 3.18 WS7: ICT for Waste management
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.18 WS7 ICT for Waste Management', 'Escala', 100, '[1] None, [2] Planning, [3] Implemented, [4] Evaluated, [5] Revised' FROM indicadores WHERE codigo_indicador = 'WS7';

-- 3.19 Impact on SDGs
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '3.19 Impact of Waste programs on SDGs', 'Escala', 0, '[1] Low (1-2), [2] Moderate (3-5), [3] Significant (6-9), [4] High (10-13), [5] Very high (14-17)' FROM indicadores WHERE codigo_indicador = 'WS8';

COMMIT;


/*******************************************************************************
SISTEMA INTEGRAL GREEN TECH METRICS - UTN
MODULO 3.4: CARGA COMPLETA SIN OMISIONES - CATEGORÍA WR (WATER)
*******************************************************************************/

-- 1. Limpieza preventiva (Asegurando que no existan duplicados antes de la carga)
DELETE FROM metricas 
WHERE id_indicador IN (SELECT id_indicador FROM indicadores WHERE codigo_indicador LIKE 'WR%');

-- 4.1 WR1: Water conservation program
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '4.1 WR1 Water conservation program and implementation', 'Escala', 150, 
'[1] None, [2] Program in preparation, [3] 1-25% water conserved, [4] >25-50% water conserved, [5] >50% water conserved'
FROM indicadores WHERE codigo_indicador = 'WR1';

-- 4.2 WR2: Water recycling program
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '4.2 WR2 Water recycling program implementation', 'Escala', 200, 
'[1] None, [2] Program in preparation, [3] 1-25% water recycled, [4] >25-50% water recycled, [5] >50% water recycled'
FROM indicadores WHERE codigo_indicador = 'WR2';

-- 4.3 WR3: Water efficient appliances
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '4.3 WR3 Water efficient appliances usage', 'Escala', 200, 
'[1] <20% installed, [2] 20-40%, [3] >40-60%, [4] >60-80%, [5] >80% installed'
FROM indicadores WHERE codigo_indicador = 'WR3';

-- 4.4 WR4: Consumption of treated water
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '4.4 WR4 Consumption of treated water', 'Escala', 200, 
'[1] None, [2] 1-25% consumed, [3] >25-50% consumed, [4] >50-75% consumed, [5] >75% consumed'
FROM indicadores WHERE codigo_indicador = 'WR4';

-- 4.5 WR5: Water pollution control
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '4.5 WR5 Water pollution control in the campus area', 'Escala', 200, 
'[1] Design stage, [2] Construction, [3] Early implementation, [4] Implemented/Monitored occasionally, [5] Implemented/Monitored regularly'
FROM indicadores WHERE codigo_indicador = 'WR5';

-- 4.6 WR6: ICT for Water management
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '4.6 WR6 ICT for Water Management', 'Escala', 50, 
'[1] None, [2] Planning stage, [3] Implemented, [4] Evaluated, [5] Revised'
FROM indicadores WHERE codigo_indicador = 'WR6';

-- 4.7 Impact on SDGs (Usando WR7 como indicador de cierre de categoría)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '4.7 Impact of Water Management programs in supporting the SDGs', 'Escala', 0, 
'[1] Low (1-2), [2] Moderate (3-5), [3] Significant (6-9), [4] High (10-13), [5] Very high (14-17 SDGs)'
FROM indicadores WHERE codigo_indicador = 'WR7';

COMMIT;


/*******************************************************************************
SISTEMA INTEGRAL GREEN TECH METRICS - UTN
MODULO 3.5: CARGA COMPLETA SIN OMISIONES - CATEGORÍA TR (TRANSPORTATION)
*******************************************************************************/

-- Limpieza preventiva para la categoría TR
DELETE FROM metricas 
WHERE id_indicador IN (SELECT id_indicador FROM indicadores WHERE codigo_indicador LIKE 'TR%');

-- 5.1 a 5.4: TR1 Vehículos de Combustión (Inputs y Ratio)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.1 Number of cars actively used and managed by the university', 'Vehículos', 0, 'University-owned fleet' FROM indicadores WHERE codigo_indicador = 'TR1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.2 Number of cars entering the university daily', 'Vehículos', 0, 'Private cars daily average' FROM indicadores WHERE codigo_indicador = 'TR1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.3 Number of motorcycles entering the university daily', 'Vehículos', 0, 'Motorcycles daily average' FROM indicadores WHERE codigo_indicador = 'TR1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.4 TR1 Ratio of vehicles (combustion) to total campus population', 'Ratio', 200, '[1] >= 1, [2] > 0.5 - 1, [3] > 0.125 - 0.5, [4] > 0.045 - 0.125, [5] < 0.045' FROM indicadores WHERE codigo_indicador = 'TR1';

-- 5.5 a 5.8: TR2 Shuttle Services (Gestión y Operación)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.5 TR2 Shuttle services', 'Escala', 250, '[1] None, [2] Regular but not free, [3] University contributes part of cost, [4] Regular and free, [5] Zero emission vehicle or NA' FROM indicadores WHERE codigo_indicador = 'TR2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.6 Number of shuttles operating in the university', 'Unidades', 0, 'Total shuttle fleet' FROM indicadores WHERE codigo_indicador = 'TR2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.7 Average number of passengers of each shuttle', 'Personas', 0, 'Average occupancy' FROM indicadores WHERE codigo_indicador = 'TR2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.8 Total trips of each shuttle services each day', 'Viajes', 0, 'Daily frequency' FROM indicadores WHERE codigo_indicador = 'TR2';

-- 5.9 a 5.11: TR3 y TR4 Zero Emission Vehicles (ZEV)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.9 TR3 Zero Emission Vehicles (ZEV) availability on campus', 'Escala', 200, '[1] Not available, [2] Not practical, [3] Available but not provided by university, [4] Provided by university and charged, [5] Provided by university for free' FROM indicadores WHERE codigo_indicador = 'TR3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.10 Average number of ZEV on campus per day', 'Vehículos', 0, 'Daily average of electric/manual vehicles' FROM indicadores WHERE codigo_indicador = 'TR4';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.11 TR4 Ratio of ZEV to total campus population', 'Ratio', 200, '[1] <= 0.002, [2] > 0.002 - 0.004, [3] > 0.004 - 0.008, [4] > 0.008 - 0.02, [5] > 0.02' FROM indicadores WHERE codigo_indicador = 'TR4';

-- 5.12 a 5.14: TR5 y TR6 Parking (Infraestructura y Reducción)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.12 Total ground parking area (m2)', 'm2', 0, 'Surface area' FROM indicadores WHERE codigo_indicador = 'TR5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.13 TR5 Ratio of ground parking area to total campus area', '%', 200, '[1] > 11%, [2] > 7 - 11%, [3] > 4 - 7%, [4] > 1 - 4%, [5] < 1%' FROM indicadores WHERE codigo_indicador = 'TR5';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.14 TR6 Program to limit or decrease the parking area (3 years)', 'Escala', 200, '[1] None, [2] In preparation, [3] < 10% decrease, [4] 10 - 30% decrease, [5] > 30% decrease' FROM indicadores WHERE codigo_indicador = 'TR6';

-- 5.15 a 5.16: TR7 Initiatives and TR8 Pedestrian Path
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.15 TR7 Initiatives to decrease private vehicles on campus', 'Iniciativas', 200, '[1] No initiative, [2] 1, [3] 2, [4] 3, [5] > 3 initiatives' FROM indicadores WHERE codigo_indicador = 'TR7';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.16 TR8 Pedestrian path on campus', 'Escala', 250, '[1] None, [2] Available, [3] Safe, [4] Safe and convenient, [5] Safe, convenient and disabled-friendly' FROM indicadores WHERE codigo_indicador = 'TR8';

-- 5.17, 5.18 y 5.19: TR9 Gestión, ICT e Impacto
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.17 Daily travel distance of a vehicle inside campus (Km)', 'Km', 0, 'Distance inside campus' FROM indicadores WHERE codigo_indicador = 'TR9';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.18 TR9 ICT for Transportation management', 'Escala', 100, '[1] None, [2] Planning, [3] Implemented, [4] Evaluated, [5] Revised' FROM indicadores WHERE codigo_indicador = 'TR9';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '5.19 Impact of Transportation programs on SDGs', 'Escala', 0, '[1] Low (1-2), [2] Moderate (3-5), [3] Significant (6-9), [4] High (10-13), [5] Very high (14-17 ODS)' FROM indicadores WHERE codigo_indicador = 'TR9';

COMMIT;

/*******************************************************************************
SISTEMA INTEGRAL GREEN TECH METRICS - UTN
MODULO 3.6: CARGA COMPLETA SIN OMISIONES - CATEGORÍA ED (EDUCATION)
*******************************************************************************/

-- 1. Limpieza preventiva para la categoría ED
DELETE FROM metricas 
WHERE id_indicador IN (SELECT id_indicador FROM indicadores WHERE codigo_indicador LIKE 'ED%');

-- 6.1 a 6.4: ED1 Cursos de Sostenibilidad (Insumos y Ratio)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.1 Number of courses/subjects related to sustainability', 'Cursos', 0, 'Total subjects with sustainability content' FROM indicadores WHERE codigo_indicador = 'ED1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.2 Total number of courses/subjects offered', 'Cursos', 0, 'Total subjects in university catalog' FROM indicadores WHERE codigo_indicador = 'ED1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.3 Total number of study programs related to sustainability', 'Programas', 0, 'Number of official study programs' FROM indicadores WHERE codigo_indicador = 'ED1';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.4 ED1 Ratio of sustainability courses to total courses', '%', 200, '[1] <= 1%, [2] > 1 - 5%, [3] > 5 - 10%, [4] > 10 - 20%, [5] > 20%' FROM indicadores WHERE codigo_indicador = 'ED1';

-- 6.5 a 6.7: ED2 Fondos de Investigación (Insumos y Ratio)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.5 Total research funds dedicated to sustainability', 'USD', 0, 'Funds in US Dollars' FROM indicadores WHERE codigo_indicador = 'ED2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.6 Total research funds', 'USD', 0, 'Total university research budget' FROM indicadores WHERE codigo_indicador = 'ED2';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.7 ED2 Ratio of sustainability research funding to total', '%', 200, '[1] <= 1%, [2] > 1 - 10%, [3] > 10 - 20%, [4] > 20 - 40%, [5] > 40%' FROM indicadores WHERE codigo_indicador = 'ED2';

-- 6.8 a 6.10: ED3 Publicaciones Académicas (Insumos y Ratio)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.8 Number of lecturers and researchers on campus', 'Personas', 0, 'Total academic staff' FROM indicadores WHERE codigo_indicador = 'ED3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.9 Number of scholarly publications on sustainability', 'Publicaciones', 0, 'Total papers in the last year' FROM indicadores WHERE codigo_indicador = 'ED3';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.10 ED3 Ratio of scholarly publications to lecturers', 'Ratio', 200, '[1] < 0.5, [2] 0.5 - 1, [3] > 1 - 2, [4] > 2 - 3, [5] > 3' FROM indicadores WHERE codigo_indicador = 'ED3';

-- 6.11 a 6.12: ED4 y ED5 Eventos y Organizaciones Estudiantiles
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.11 ED4 Number of events related to sustainability', 'Eventos', 150, '[1] 0, [2] 1 - 5, [3] 6 - 20, [4] 21 - 50, [5] > 50' FROM indicadores WHERE codigo_indicador = 'ED4';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.12 ED5 Number of activities by student organizations', 'Activ', 150, '[1] 0, [2] 1 - 5, [3] 6 - 10, [4] 11 - 20, [5] > 20' FROM indicadores WHERE codigo_indicador = 'ED5';

-- 6.13 a 6.16: ED6 y ED7 Presencia Digital y Transparencia
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.13 ED6 University-run sustainability website', 'Escala', 200, '[1] Not available, [2] In progress, [3] Available, [4] Updated occasionally, [5] Updated regularly' FROM indicadores WHERE codigo_indicador = 'ED6';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.14 Sustainability website address (URL)', 'URL', 0, 'Evidence: Official website link' FROM indicadores WHERE codigo_indicador = 'ED6';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.15 ED7 Sustainability report periodicity', 'Escala', 100, '[1] Not available, [2] Preparation, [3] Not public, [4] Occasionally, [5] Annually' FROM indicadores WHERE codigo_indicador = 'ED7';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.16 Sustainability report link (URL)', 'URL', 0, 'Evidence: Published report link' FROM indicadores WHERE codigo_indicador = 'ED7';

-- 6.17 a 6.20: ED8 a ED11 Cultura, Colaboración y Startups
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.17 ED8 Number of cultural activities on campus', 'Eventos', 100, '[1] None, [2] 1-3, [3] 4-6, [4] 7-10, [5] > 10' FROM indicadores WHERE codigo_indicador = 'ED8';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.18 ED9 International collaborations on sustainability', 'Prog', 100, '[1] None, [2] 1-3, [3] 4-6, [4] 7-10, [5] > 10' FROM indicadores WHERE codigo_indicador = 'ED9';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.19 ED10 Community services involving students', 'Proy', 100, '[1] None, [2] 1-3, [3] 4-6, [4] 7-10, [5] > 10' FROM indicadores WHERE codigo_indicador = 'ED10';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.20 ED11 Number of sustainability-related startups', 'Startups', 100, '[1] None, [2] 1-5, [3] 6-10, [4] 11-15, [5] > 15' FROM indicadores WHERE codigo_indicador = 'ED11';

-- 6.21 a 6.23: ED12 Empleos Verdes (Green Jobs)
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.21 Graduates with green jobs (last 3 years)', 'Graduados', 0, 'Total green jobs graduates' FROM indicadores WHERE codigo_indicador = 'ED12';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.22 Total number of graduates (last 3 years)', 'Personas', 0, 'Total graduates in period' FROM indicadores WHERE codigo_indicador = 'ED12';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.23 ED12 Percentage of graduates with green jobs', '%', 50, '[1] <= 1%, [2] > 1-5%, [3] > 5-10%, [4] > 10-20%, [5] > 20%' FROM indicadores WHERE codigo_indicador = 'ED12';

-- 6.24 a 6.26: ED13 a ED14 Gobernanza e Impacto
INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.24 ED13 Sustainability Office status', 'Escala', 50, '[1] Ad-hoc, [2] Preparation, [3] Decree, [4] Operational, [5] Leads implementation' FROM indicadores WHERE codigo_indicador = 'ED13';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.25 ED14 ICT for University Governance', 'Escala', 100, '[1] None, [2] Planning, [3] Implemented, [4] Evaluated, [5] Revised' FROM indicadores WHERE codigo_indicador = 'ED14';

INSERT INTO metricas (id_indicador, nombre_metrica, unidad_medida, puntaje_max_met, criterio_evaluacion)
SELECT id_indicador, '6.26 Impact of ED programs on SDGs', 'Escala', 0, '[1] 1-2, [2] 3-5, [3] 6-9, [4] 10-13, [5] 14-17 ODS' FROM indicadores WHERE codigo_indicador = 'ED14';

COMMIT;