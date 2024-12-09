--@AUTOR(ES):       Aburto López Roberto
--@FECHA CREACIÓN:  07/12/2024
--@DESCRIPCIÓN:     Procedimiento para almacenar en disco las 
--fotos de la tabla monitoreo_cautiverio

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

PROMPT Creando el directorio /unam/bd/proyecto/descarga-centro en caso de que no exista
!mkdir -p /unam/bd/Proyecto/pet-home/descarga-centro

CREATE OR REPLACE DIRECTORY DESCARGA_LOGO_CENTRO AS '/unam/bd/Proyecto/pet-home/descarga-centro';
GRANT READ, WRITE ON DIRECTORY DESCARGA_LOGO_CENTRO TO &&p_usuario;

PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home/
!chmod 777 /unam/bd/Proyecto/pet-home/descarga-centro

CREATE OR REPLACE PROCEDURE guarda_disco_logo_centro (
    p_nombre_directorio IN VARCHAR2,
    p_nombre_archivo IN VARCHAR2,
    p_centro_refugio_id IN NUMBER,
    p_longitud OUT NUMBER
) IS 
v_blob BLOB;

v_file UTL_FILE.FILE_TYPE;
v_buffer_size NUMBER := 32767;
v_buffer RAW(32767);
v_position NUMBER := 1;

BEGIN 
    --EJECUTA CONSULTA PARA EXTRAER EL BLOB
    SELECT logo 
    INTO v_blob
    FROM AH_PROY_ADMIN.centro_refugio
    WHERE centro_refugio_id = p_centro_refugio_id;

    -- Abre el acrhivo para escribir
    v_file := UTL_FILE.FOPEN(upper(p_nombre_directorio),p_nombre_archivo, 'wb', v_buffer_size);
    p_longitud := DBMS_LOB.GETLENGTH(v_blob);

    --Escribe en el archivo hasta completar
    WHILE v_position < p_longitud LOOP 
        DBMS_LOB.READ(v_blob,v_buffer_size, v_position, v_buffer);
        UTL_FILE.PUT_RAW(v_file,v_buffer, true);
        v_position := v_position + v_buffer_size;
    END LOOP;
    UTL_FILE.FCLOSE(v_file);

    --CIERRA EL ARCHIVO EN CASO DE ERROR Y RELANZA LA EXCEPCION
    EXCEPTION 
        WHEN OTHERS THEN 
        -- CERRAR V_file EN CASO DE ERROR
        IF UTL_FILE.IS_OPEN(v_file) THEN 
            UTL_FILE.FCLOSE(v_file);
        END IF;
        -- MUESTRA DETALLE DEL ERROR
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        -- RELANZA LA EXCEPCION PARA QUE SEA MANEJADA POR EL 
        -- PROGRAMA QUE INVOQUE A ESTE PRICEDIMIENTO
        p_longitud := -1;
        RAISE;
END;
/
SHOW ERRORS; 





