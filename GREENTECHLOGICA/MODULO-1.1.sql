-- =========================================================
-- DATOS SEMILLA
-- =========================================================

-- ROLES
INSERT INTO roles (nombre, descripcion)
SELECT 'ADMIN', 'Administrador total del sistema'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'ADMIN');

INSERT INTO roles (nombre, descripcion)
SELECT 'EDITOR', 'Gestión y carga de métricas y evidencias'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'EDITOR');

INSERT INTO roles (nombre, descripcion)
SELECT 'VISOR', 'Acceso de solo lectura a reportes y dashboards'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'VISOR');

-- PERMISOS
INSERT INTO permisos (clave, nombre, area_funcional)
SELECT 'USR_CONTROL', 'Gestión de usuarios y roles', 'SEGURIDAD'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM permisos WHERE clave = 'USR_CONTROL');

INSERT INTO permisos (clave, nombre, area_funcional)
SELECT 'DAT_FULL_CONTROL', 'CRUD de categorías e indicadores', 'GESTION_DATOS'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM permisos WHERE clave = 'DAT_FULL_CONTROL');

INSERT INTO permisos (clave, nombre, area_funcional)
SELECT 'MET_FULL_CONTROL', 'CRUD de métricas técnicas', 'GESTION_DATOS'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM permisos WHERE clave = 'MET_FULL_CONTROL');

INSERT INTO permisos (clave, nombre, area_funcional)
SELECT 'EVI_UPLOAD', 'Subida de evidencias', 'AUDITORIA'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM permisos WHERE clave = 'EVI_UPLOAD');

INSERT INTO permisos (clave, nombre, area_funcional)
SELECT 'EVI_VALIDATE', 'Validación de evidencias', 'AUDITORIA'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM permisos WHERE clave = 'EVI_VALIDATE');

INSERT INTO permisos (clave, nombre, area_funcional)
SELECT 'VIEW_REPORTS', 'Visualización de reportes', 'REPORTES'
FROM dual WHERE NOT EXISTS (SELECT 1 FROM permisos WHERE clave = 'VIEW_REPORTS');

-- =========================================================
-- ASIGNACIÓN DE PERMISOS A ROLES
-- =========================================================

-- ADMIN → todos los permisos
INSERT INTO rol_permisos (id_rol, id_permiso)
SELECT r.id_rol, p.id_permiso
FROM roles r
CROSS JOIN permisos p
WHERE r.nombre = 'ADMIN'
AND NOT EXISTS (
    SELECT 1 FROM rol_permisos rp
    WHERE rp.id_rol = r.id_rol AND rp.id_permiso = p.id_permiso
);

-- EDITOR
INSERT INTO rol_permisos (id_rol, id_permiso)
SELECT r.id_rol, p.id_permiso
FROM roles r
JOIN permisos p
ON p.clave IN ('DAT_FULL_CONTROL', 'MET_FULL_CONTROL', 'EVI_UPLOAD')
WHERE r.nombre = 'EDITOR'
AND NOT EXISTS (
    SELECT 1 FROM rol_permisos rp
    WHERE rp.id_rol = r.id_rol AND rp.id_permiso = p.id_permiso
);

-- VISOR
INSERT INTO rol_permisos (id_rol, id_permiso)
SELECT r.id_rol, p.id_permiso
FROM roles r
JOIN permisos p
ON p.clave = 'VIEW_REPORTS'
WHERE r.nombre = 'VISOR'
AND NOT EXISTS (
    SELECT 1 FROM rol_permisos rp
    WHERE rp.id_rol = r.id_rol AND rp.id_permiso = p.id_permiso
);

COMMIT;