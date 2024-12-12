--@AUTOR(ES):       Aburto López Roberto
--@FECHA CREACIÓN:  06/12/2024
--@DESCRIPCIÓN:     Procedimiento para guardar historial clínico en archivo .txt

PROMPT ========================================================
PROMPT Procedimiento para guardar historial clínico
PROMPT s-13-p-historial-clinico.sql
PROMPT ========================================================
SET SERVEROUTPUT OFF

DEFINE p_usuario='ah_proy_admin'
DEFINE p_usuario_pass='contrasena'
DEFINE p_sys_password='system1'
DEFINE p_pdb='ralbd_s1'


PROMPT Conectando como sys
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA

!mkdir -p /unam/bd/Proyecto/pet-home/historial-clinico

CREATE OR REPLACE DIRECTORY HISTORIAL_CLINICO_DIR AS '/unam/bd/Proyecto/pet-home/historial-clinico';
GRANT READ, WRITE ON DIRECTORY HISTORIAL_CLINICO_DIR TO &&p_usuario;

PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home/
!chmod 777 /unam/bd/Proyecto/pet-home/historial-clinico

PROMPT Conectando con usuario admin
CONNECT &&p_usuario/&&p_usuario_pass@&&p_pdb



CREATE OR REPLACE PROCEDURE guardar_historial_clinico(
    p_mascota_id          IN NUMBER,      -- id de la mascota
    p_nombre_archivo      IN VARCHAR2     -- nombre del archivo a generar
) IS
    v_file UTL_FILE.FILE_TYPE;
    v_tipo VARCHAR2(40);
    v_subcategoria VARCHAR2(40);
    v_nombre_mascota VARCHAR2(40);
    v_refugio VARCHAR2(100);

    CURSOR c_diagnosticos IS
        SELECT TO_CHAR(mc.fecha, 'DD-MM-YYYY') AS fecha,
               mc.diagnostico
        FROM monitoreo_cautiverio mc
        WHERE mc.mascota_id = p_mascota_id
        ORDER BY mc.fecha;

    e_invalid_file EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_invalid_file, -20006);

    e_invalid_mascota_id EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_invalid_mascota_id, -20013);

BEGIN
    -- Validar que el nombre del archivo termine en '.txt'
    IF NOT p_nombre_archivo LIKE '%.txt' THEN
        RAISE e_invalid_file;
    END IF;

    -- Recuperar datos básicos de la mascota
    BEGIN
        SELECT m.nombre AS nombre_mascota, 
               mt.tipo, 
               mt.subcategoria AS raza_mascota, 
               co.nombre AS nombre_refugio
        INTO v_nombre_mascota, v_tipo, v_subcategoria, v_refugio
        FROM mascota m
        JOIN mascota_tipo mt ON mt.mascota_tipo_id = m.mascota_tipo_id
        JOIN centro_refugio cf ON m.refugio_id = cf.centro_refugio_id
        JOIN centro_operativo co ON co.centro_operativo_id = cf.centro_refugio_id
        WHERE m.mascota_id = p_mascota_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE e_invalid_mascota_id;
    END;

    -- Abrir archivo para escritura
    v_file := UTL_FILE.FOPEN('HISTORIAL_CLINICO_DIR', p_nombre_archivo, 'W');

    -- Escribir cabecera
    UTL_FILE.PUT_LINE(v_file, 'Mascota id: ' || p_mascota_id);
    UTL_FILE.PUT_LINE(v_file, 'Nombre: ' || v_nombre_mascota);
    UTL_FILE.PUT_LINE(v_file, 'Tipo: ' || v_tipo);
    UTL_FILE.PUT_LINE(v_file, 'Subcategoría: ' || v_subcategoria);
    UTL_FILE.PUT_LINE(v_file, 'Refugio: ' || v_refugio);
    UTL_FILE.PUT_LINE(v_file, '-------------------------------------------------------------');

    -- Iterar sobre los diagnósticos
    FOR r_diag IN c_diagnosticos LOOP
        UTL_FILE.PUT_LINE(v_file, 'Fecha: ' || r_diag.fecha);
        UTL_FILE.PUT_LINE(v_file, 'Diagnóstico: ' || r_diag.diagnostico);
        UTL_FILE.PUT_LINE(v_file, '-------------------------------------------------------------');
    END LOOP;

    -- Cerrar archivo
    UTL_FILE.FCLOSE(v_file);

    DBMS_OUTPUT.PUT_LINE('Historial clínico guardado exitosamente en el archivo ' || p_nombre_archivo);

EXCEPTION
    WHEN e_invalid_file THEN
        DBMS_OUTPUT.PUT_LINE('Error: El nombre del archivo debe terminar en .txt (Código -20006).');
        RAISE_APPLICATION_ERROR(-20006, 'El nombre del archivo debe terminar en .txt');
    WHEN e_invalid_mascota_id THEN
        DBMS_OUTPUT.PUT_LINE('Error: Mascota no registrada (Código -20013).');
        RAISE_APPLICATION_ERROR(-20013, 'Mascota no registrada');
    WHEN OTHERS THEN
        IF UTL_FILE.IS_OPEN(v_file) THEN
            UTL_FILE.FCLOSE(v_file);
        END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
        RAISE;
END guardar_historial_clinico;
/
show errors;