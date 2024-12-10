--@AUTOR(ES):       Aburto López Roberto
--@FECHA CREACIÓN:  07/12/2024
--@DESCRIPCIÓN:     Procedimiento para almacenar fotos en la tabla monitoreo_cautiverio

define p_usuario='ah_proy_admin'
define p_usuario_pass='contrasena'
define p_sys_password='system1'
define p_pdb='ghrbd_s1'

PROMPT ========================================================
PROMPT Procedimiento para almacenar fotos en la tabla monitoreo_cautiverio
PROMPT s-13-p-lob-carga-foto.sql
PROMPT ======================================

PROMPT Conectando como sys
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA 

CREATE OR REPLACE DIRECTORY FOTOS_MONITOREO AS '/unam/bd/Proyecto/pet-home/fotos_mascota';
GRANT READ, WRITE ON DIRECTORY FOTOS_MONITOREO TO &&p_usuario;

CREATE OR REPLACE DIRECTORY LOGO_REFUGIO AS '/unam/bd/Proyecto/pet-home/logo_centro';
GRANT READ, WRITE ON DIRECTORY LOGO_REFUGIO TO &&p_usuario;


PROMPT Conectando con usuario admin
CONNECT &&p_usuario/&&p_usuario_pass@&&p_pdb

PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home/
!chmod 777 /unam/bd/Proyecto/pet-home/fotos_mascota
!chmod 777 /unam/bd/Proyecto/pet-home/logo_centro



CREATE OR REPLACE PROCEDURE carga_foto_dinamico(
    p_tabla               IN VARCHAR2,    -- Nombre de la tabla
    p_columna_blob        IN VARCHAR2,    -- Nombre de la columna BLOB
    p_columna_id          IN VARCHAR2,    -- Nombre de la columna ID
    p_id_valor            IN NUMBER,      -- Valor del ID
    p_directorio_logico   IN VARCHAR2,    -- Nombre del directorio lógico
    p_nombre_archivo      IN VARCHAR2     -- Nombre del archivo a cargar
) IS
    v_bfile  BFILE;
    v_blob   BLOB;
    v_count  NUMBER;
    v_query  VARCHAR2(4000);
BEGIN
    -- Verificar si el registro con el ID proporcionado existe
    v_query := 'SELECT COUNT(*) FROM ' || p_tabla || ' WHERE ' || p_columna_id || ' = :1';
    EXECUTE IMMEDIATE v_query INTO v_count USING p_id_valor;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'ERROR: El registro no existe.');
    END IF;

    -- Verificar que la extensión del archivo sea .jpg
    IF LOWER(SUBSTR(p_nombre_archivo, -4)) != '.jpg' THEN
        RAISE_APPLICATION_ERROR(-20006, 'ERROR: No es extensión .jpg.');
    END IF;

    -- Inicializar el BFILE
    v_bfile := BFILENAME(p_directorio_logico, p_nombre_archivo);

    -- Validar que el archivo exista en el directorio
    IF DBMS_LOB.FILEEXISTS(v_bfile) != 1 THEN
        RAISE_APPLICATION_ERROR(-20008, 'ERROR: El archivo no existe en el directorio.');
    END IF;

    -- Validar que el archivo no esté abierto
    IF DBMS_LOB.ISOPEN(v_bfile) = 1 THEN
        RAISE_APPLICATION_ERROR(-20009, 'ERROR: El archivo ya está abierto.');
    END IF;

    -- Leer el archivo y cargarlo en la tabla
    v_query := 'SELECT ' || p_columna_blob || ' FROM ' || p_tabla || ' WHERE ' || p_columna_id || ' = :1 FOR UPDATE';
    EXECUTE IMMEDIATE v_query INTO v_blob USING p_id_valor;

    DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_blob, v_bfile, DBMS_LOB.GETLENGTH(v_bfile));
    DBMS_LOB.CLOSE(v_bfile);
    DBMS_OUTPUT.PUT_LINE('Archivo cargado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/
SHOW ERRORS;
