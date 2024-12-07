--@Autor: Aburto López Roberto
--@Fecha: 04/10/2024
--@Descripción: Programa PL/SQL que carga fotos de monitoreo cautiverio desde un directorio y las almacena en la base de datos.

PROMPT ========================================================
PROMPT Manejo de BLOBs para MONITOREO_CAUTIVERIO
PROMPT ========================================================

PROMPT Conectando como sys
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA

PROMPT Creando directorio para fotos de monitoreo cautiverio
CREATE OR REPLACE DIRECTORY monitoreo_foto_dir AS '/unam/bd/Proyecto/pet-home/fotos';
GRANT READ, WRITE ON DIRECTORY monitoreo_foto_dir TO &&p_usuario;

PROMPT Cambiando permisos
!mkdir -p /unam/bd/Proyecto/pet-home/fotos
!chmod 755 /unam/bd/Proyecto/pet-home
!chmod 777 /unam/bd/Proyecto/pet-home/fotos

PROMPT Conectando con usuario admin
CONNECT &&p_usuario/&&p_usuario_pass@&&p_pdb

PROMPT Creando función para leer archivos como BLOB
CREATE OR REPLACE FUNCTION lee_foto(p_nombre_archivo IN VARCHAR2) RETURN BLOB IS
    v_blob BLOB;
BEGIN
    -- Inicializar el BLOB
    DBMS_LOB.CREATETEMPORARY(v_blob, TRUE);

    -- Cargar el archivo del directorio
    DBMS_LOB.LOADFROMFILE(
        v_blob,
        BFILENAME('MONITOREO_FOTO_DIR', p_nombre_archivo),
        DBMS_LOB.GETLENGTH(BFILENAME('MONITOREO_FOTO_DIR', p_nombre_archivo))
    );

    RETURN v_blob;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al leer el archivo: ' || SQLERRM);
        RETURN NULL;
END;
/

PROMPT Insertando o actualizando fotos en MONITOREO_CAUTIVERIO
DECLARE
    v_nombre_archivo VARCHAR2(100);
BEGIN
    FOR v_reg IN (
        SELECT MONITOREO_CAUTIVERIO_ID AS id, 
               TO_CHAR(MONITOREO_CAUTIVERIO_ID) || '.jpg' AS archivo_foto
        FROM MONITOREO_CAUTIVERIO
    ) LOOP
        BEGIN
            -- Intentar leer la foto correspondiente
            v_nombre_archivo := v_reg.archivo_foto;

            UPDATE MONITOREO_CAUTIVERIO
            SET FOTO = lee_foto(v_nombre_archivo)
            WHERE MONITOREO_CAUTIVERIO_ID = v_reg.id;

            DBMS_OUTPUT.PUT_LINE('Foto actualizada para MONITOREO_CAUTIVERIO_ID: ' || v_reg.id);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error al procesar MONITOREO_CAUTIVERIO_ID: ' || v_reg.id || ' - ' || SQLERRM);
        END;
    END LOOP;
END;
/

PROMPT Consulta de datos para verificar longitud de las fotos
SELECT DBMS_LOB.GETLENGTH(FOTO) AS LONGITUD_FOTO
FROM MONITOREO_CAUTIVERIO;
