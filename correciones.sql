

ALTER TABLE
    usuarios DROP COLUMN id_rol;

ALTER TABLE usuarios_roles
ADD CONSTRAINT fk_ur_asignado_por
FOREIGN KEY (asignado_por)
REFERENCES usuarios(id_usuario);

CREATE INDEX idx_ur_usuario_activo 
ON usuarios_roles (id_usuario, activo);

CREATE INDEX idx_rp_rol 
ON rol_permisos (id_rol);

CREATE INDEX idx_rp_permiso 
ON rol_permisos (id_permiso);



-- 1) Columna ACTIVO
ALTER TABLE categorias
ADD activo CHAR(1) DEFAULT 'S' NOT NULL
    CHECK (activo IN ('S','N'));

-- 2) Validaciones de peso y puntaje máximo
ALTER TABLE categorias
ADD CONSTRAINT ck_cat_peso
CHECK (peso_porcentaje > 0 AND peso_porcentaje <= 100);

ALTER TABLE categorias
ADD CONSTRAINT ck_cat_pmax
CHECK (puntaje_maximo >= 0);

-- 3) Validación de códigos GreenMetric (los 6 oficiales)
ALTER TABLE categorias
ADD CONSTRAINT ck_cat_codigo_ref
CHECK (codigo_ref IN ('SI','EC','WS','WR','TR','ED'));

-- 4) Validación simple de color HEX (#RRGGBB) (opcional pero útil)
ALTER TABLE categorias
ADD CONSTRAINT ck_cat_color_hex
CHECK (color_hex IS NULL OR REGEXP_LIKE(color_hex, '^#[0-9A-Fa-f]{6}$'));


ALTER TABLE periodos
ADD CONSTRAINT ck_periodo_fechas
CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio);


ALTER TABLE metricas
ADD orden_visual NUMBER(4);