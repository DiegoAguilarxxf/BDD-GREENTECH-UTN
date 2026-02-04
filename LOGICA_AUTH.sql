/*******************************************************************************
  GREEN TECH METRICS - UTN
  AUTENTICACIÓN + RBAC PARA ORACLE APEX (ajustado a tu LOGS_ACCESO existente)
*******************************************************************************/

-------------------------------------------------------------------------------
-- 1) FUNCIÓN DE HASH CENTRALIZADA
--    Cambia el SALT por uno tuyo (no lo publiques).
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_hash_password(
    p_password IN VARCHAR2
) RETURN VARCHAR2
IS
    v_salt CONSTANT VARCHAR2(80) := 'UTN_GTM_SALT_2026_CAMBIA_ESTE_VALOR';
BEGIN
    RETURN STANDARD_HASH(p_password || v_salt, 'SHA256');
END;
/
-------------------------------------------------------------------------------
-- 2) PROCEDIMIENTO PARA ASIGNAR/ACTUALIZAR PASSWORD A UN USUARIO
--    (sirve para cargar usuarios sin guardar contraseñas en texto plano)
-------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE pr_set_password_usuario(
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
)
IS
BEGIN
    UPDATE usuarios
       SET password_hash = fn_hash_password(p_password)
     WHERE UPPER(username) = UPPER(p_username);

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Usuario no existe: ' || p_username);
    END IF;

    COMMIT;
END;
/
-------------------------------------------------------------------------------
-- 3) LOGIN (FUNCIÓN BOOLEAN PARA APEX)
--    - Verifica estado ACTIVO
--    - Compara hash
--    - Setea sesión APEX (P0_USER_ID / P0_USERNAME)
--    - Actualiza ultimo_login
--    - Inserta log en tu logs_acceso
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_login_greenmetrics(
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
) RETURN BOOLEAN
IS
    v_user_id   usuarios.id_usuario%TYPE;
    v_hash_db   usuarios.password_hash%TYPE;
    v_estado    usuarios.estado%TYPE;
    v_hash_in   VARCHAR2(255);
BEGIN
    SELECT id_usuario, password_hash, estado
      INTO v_user_id, v_hash_db, v_estado
      FROM usuarios
     WHERE UPPER(username) = UPPER(p_username);

    IF v_estado <> 'ACTIVO' THEN
        -- Log de intento con usuario existente pero no activo
        INSERT INTO logs_acceso(id_usuario, evento, ip_address, user_agent)
        VALUES (
          v_user_id,
          'LOGIN_BLOQUEADO_O_INACTIVO',
          SYS_CONTEXT('USERENV','IP_ADDRESS'),
          SYS_CONTEXT('USERENV','USER_AGENT')
        );
        COMMIT;
        RETURN FALSE;
    END IF;

    v_hash_in := fn_hash_password(p_password);

    IF v_hash_in = v_hash_db THEN
        -- Variables de sesión (Application Items en APEX)
        APEX_UTIL.SET_SESSION_STATE('P0_USER_ID', v_user_id);
        APEX_UTIL.SET_SESSION_STATE('P0_USERNAME', p_username);

        UPDATE usuarios
           SET ultimo_login = SYSTIMESTAMP
         WHERE id_usuario = v_user_id;

        INSERT INTO logs_acceso(id_usuario, evento, ip_address, user_agent)
        VALUES (
          v_user_id,
          'LOGIN_EXITOSO',
          SYS_CONTEXT('USERENV','IP_ADDRESS'),
          SYS_CONTEXT('USERENV','USER_AGENT')
        );

        COMMIT;
        RETURN TRUE;
    ELSE
        INSERT INTO logs_acceso(id_usuario, evento, ip_address, user_agent)
        VALUES (
          v_user_id,
          'LOGIN_FALLIDO',
          SYS_CONTEXT('USERENV','IP_ADDRESS'),
          SYS_CONTEXT('USERENV','USER_AGENT')
        );
        COMMIT;

        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Usuario no existe => no podemos insertar id_usuario por tu FK (correcto)
        RETURN FALSE;
END;
/
-------------------------------------------------------------------------------
-- 4) FUNCIÓN: ¿TIENE ROL? (ADMIN/EDITOR/VISOR)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_tiene_rol(
    p_usuario_id IN NUMBER,
    p_rol_nombre IN VARCHAR2
) RETURN BOOLEAN
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO v_count
      FROM usuarios_roles ur
      JOIN roles r ON r.id_rol = ur.id_rol
     WHERE ur.id_usuario = p_usuario_id
       AND ur.activo = 'S'
       AND UPPER(r.nombre) = UPPER(p_rol_nombre);

    RETURN v_count > 0;
END;
/
-------------------------------------------------------------------------------
-- 5) FUNCIÓN: ¿TIENE PERMISO? (BOOLEAN)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_tiene_permiso_bool(
    p_usuario_id IN NUMBER,
    p_permiso    IN VARCHAR2
) RETURN BOOLEAN
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO v_count
      FROM usuarios_roles ur
      JOIN rol_permisos rp ON ur.id_rol = rp.id_rol
      JOIN permisos p      ON rp.id_permiso = p.id_permiso
     WHERE ur.id_usuario = p_usuario_id
       AND ur.activo = 'S'
       AND p.clave = p_permiso;

    RETURN v_count > 0;
END;
/
-------------------------------------------------------------------------------
-- 6) FUNCIÓN: ¿TIENE PERMISO? (NUMBER) - útil para SQL (0=no, >0=sí)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_tiene_permiso_num(
    p_usuario_id IN NUMBER,
    p_permiso    IN VARCHAR2
) RETURN NUMBER
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO v_count
      FROM usuarios_roles ur
      JOIN rol_permisos rp ON ur.id_rol = rp.id_rol
      JOIN permisos p      ON rp.id_permiso = p.id_permiso
     WHERE ur.id_usuario = p_usuario_id
       AND ur.activo = 'S'
       AND p.clave = p_permiso;

    RETURN v_count;
END;
/
-------------------------------------------------------------------------------
-- 7) VISTA ÚTIL: USUARIOS + ROLES ACTIVOS (opcional)
-------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_usuarios_roles_activos AS
SELECT
    u.id_usuario,
    u.username,
    u.email,
    u.estado,
    r.id_rol,
    r.nombre AS rol,
    ur.activo,
    ur.fecha_asignacion
FROM usuarios u
JOIN usuarios_roles ur ON ur.id_usuario = u.id_usuario
JOIN roles r          ON r.id_rol = ur.id_rol;
/
COMMIT;