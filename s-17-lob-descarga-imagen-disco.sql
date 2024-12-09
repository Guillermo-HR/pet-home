--@AUTOR(ES):       Aburto López Roberto
--@FECHA CREACIÓN:  07/12/2024
--@DESCRIPCIÓN:     Procedimiento para almacenar en disco las fotos de la base

define p_usuario='ah_proy_admin'
define p_usuario_pass='contrasena'
define p_sys_password='system1'
define p_pdb='ralbd_s1'

PROMPT ========================================================
PROMPT Procedimiento para almacenar en disco las fotos de la tabla monitoreo_cautiverio
PROMPT s-17-lob-foto_mascota.sql
PROMPT ========================================================

PROMPT Conectando como sys
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA

!mkdir -p /unam/bd/Proyecto/pet-home/descarga-centro
!mkdir -p /unam/bd/Proyecto/pet-home/descarga-mascota

CREATE OR REPLACE DIRECTORY DESCARGA_LOGO_CENTRO AS '/unam/bd/Proyecto/pet-home/descarga-centro';
GRANT READ, WRITE ON DIRECTORY DESCARGA_LOGO_CENTRO TO &&p_usuario;

CREATE OR REPLACE DIRECTORY DESCARGA_FOTO_MASCOTA AS '/unam/bd/Proyecto/pet-home/descarga-mascota';
GRANT READ, WRITE ON DIRECTORY DESCARGA_FOTO_MASCOTA TO &&p_usuario;

PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home/
!chmod 777 /unam/bd/Proyecto/pet-home/descarga-centro
!chmod 777 /unam/bd/Proyecto/pet-home/descarga-mascota


PROMPT Conectando con usuario admin para crear la tabla externa
CONNECT &&p_usuario/&&p_usuario_pass@&&p_pdb

CREATE OR REPLACE PROCEDURE guarda_disco_blob (
    p_nombre_directorio IN VARCHAR2,
    p_nombre_archivo IN VARCHAR2,
    p_tabla IN VARCHAR2,            -- Nombre de la tabla
    p_columna IN VARCHAR2,          -- Nombre de la columna BLOB
    p_id_columna IN VARCHAR2,       -- Nombre de la columna ID
    p_id_valor IN NUMBER,           -- Valor del ID
    p_longitud OUT NUMBER
) IS
    v_blob BLOB;
    v_query VARCHAR2(4000);
    v_count NUMBER;                 -- Contador para verificar existencia
    v_file UTL_FILE.FILE_TYPE;
    v_buffer_size NUMBER := 32767;
    v_buffer RAW(32767);
    v_position NUMBER := 1;
BEGIN
    -- Verificar si el registro con el ID proporcionado existe
    v_query := 'SELECT COUNT(*) FROM ' || p_tabla || ' WHERE ' || p_id_columna || ' = :1';
    EXECUTE IMMEDIATE v_query INTO v_count USING p_id_valor;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'ERROR: El registro con el ID especificado no existe.');
    END IF;

    -- Construir la consulta para obtener el BLOB
    v_query := 'SELECT ' || p_columna || 
               ' FROM ' || p_tabla || 
               ' WHERE ' || p_id_columna || ' = :1';
    
    -- Ejecutar la consulta para obtener el BLOB
    EXECUTE IMMEDIATE v_query INTO v_blob USING p_id_valor;

    -- Validar si el BLOB existe y no está vacío
    IF v_blob IS NULL OR DBMS_LOB.GETLENGTH(v_blob) = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'ERROR: El BLOB especificado no existe o está vacío.');
    END IF;
    
    -- Abrir el archivo para escribir
    v_file := UTL_FILE.FOPEN(UPPER(p_nombre_directorio), p_nombre_archivo, 'wb', v_buffer_size);
    p_longitud := DBMS_LOB.GETLENGTH(v_blob);

    -- Escribir en el archivo hasta completar
    WHILE v_position < p_longitud LOOP
        DBMS_LOB.READ(v_blob, v_buffer_size, v_position, v_buffer);
        UTL_FILE.PUT_RAW(v_file, v_buffer, TRUE);
        v_position := v_position + v_buffer_size;
    END LOOP;
    UTL_FILE.FCLOSE(v_file);

EXCEPTION
    WHEN OTHERS THEN
        -- Cerrar el archivo en caso de error
        IF UTL_FILE.IS_OPEN(v_file) THEN
            UTL_FILE.FCLOSE(v_file);
        END IF;
        -- Mostrar detalles del error
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        -- Relanzar la excepción
        p_longitud := -1;
        RAISE;
END;
/
SHOW ERRORS;
