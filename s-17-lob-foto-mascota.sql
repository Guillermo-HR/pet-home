--@AUTOR(ES):       Aburto López Roberto
--@FECHA CREACIÓN:  07/12/2024
--@DESCRIPCIÓN:     Procedimiento para almacenar fotos en la tabla monitoreo_cautiverio

define p_usuario='ah_proy_admin'
define p_usuario_pass='contrasena'
define p_sys_password='system1'
define p_pdb='ralbd_s1'

PROMPT ========================================================
PROMPT Procedimiento para almacenar fotos en la tabla monitoreo_cautiverio
PROMPT s-17-lob-foto_mascota.sql
PROMPT ======================================

PROMPT Conectando como sys
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA 

CREATE OR REPLACE DIRECTORY FOTOS_MONITOREO AS '/unam/bd/Proyecto/pet-home/tabla-externa';
GRANT READ, WRITE ON DIRECTORY FOTOS_MONITOREO TO &&p_usuario;

PROMPT Conectando con usuario admin para crear la tabla externa
CONNECT &&p_usuario/&&p_usuario_pass@&&p_pdb

PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home/
!chmod 777 /unam/bd/Proyecto/pet-home/fotos

CREATE OR REPLACE PROCEDURE insertar_foto_monitoreo(
  p_monitoreo_cautiverio_id IN NUMBER, 
  p_nombre_archivo IN VARCHAR2 
)
IS 
  v_bfile BFILE;
  v_blob BLOB;
  v_count NUMBER;
BEGIN
  -- VERIFICANDO EXISTENCIA DEL REGISTRO DE MONITOREO
  SELECT COUNT(*) INTO v_count
  FROM monitoreo_cautiverio
  WHERE monitoreo_cautiverio_id = p_monitoreo_cautiverio_id;

  IF v_count = 0 THEN 
    RAISE_APPLICATION_ERROR(-20001, 'ERROR: REGISTRO DE MONITOREO NO EXISTE');
  
  -- VERIFICANDO QUE LA EXTENSIÓN SEA .PNG
  ELSIF LOWER(SUBSTR(p_nombre_archivo, -4)) != '.png' THEN
    RAISE_APPLICATION_ERROR(-20002, 'ERROR: NO ES EXTENSIÓN .PNG');
  ELSE
    -- INICIALIZANDO EL BFILE, QUE UBICA DE MANERA FÍSICA EL ARCHIVO
    v_bfile := BFILENAME('FOTOS_MONITOREO', p_nombre_archivo);

    -- VALIDANDO QUE EL ARCHIVO EXISTA EN EL DIRECTORIO FOTOS_MONITOREO
    IF DBMS_LOB.FILEEXISTS(v_bfile) != 1 THEN
      RAISE_APPLICATION_ERROR(-20003, 'EL ARCHIVO NO EXISTE EN EL DIRECTORIO FOTOS_MONITOREO');
    
    -- VALIDANDO QUE EL ARCHIVO ESTÉ CERRADO
    ELSIF DBMS_LOB.ISOPEN(v_bfile) = 1 THEN
      RAISE_APPLICATION_ERROR(-20004, 'EL ARCHIVO ESTÁ ABIERTO');
    ELSE
      -- OBTENIENDO EL EMPTY_BLOB Y GUARDÁNDOLO EN v_blob CON UN BLOQUEO
      SELECT foto INTO v_blob
      FROM monitoreo_cautiverio
      WHERE monitoreo_cautiverio_id = p_monitoreo_cautiverio_id
      FOR UPDATE;

      -- LEYENDO EL ARCHIVO
      DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY);

      -- CARGANDO EL ARCHIVO EN LA BASE
      DBMS_LOB.LOADFROMFILE(v_blob, v_bfile, DBMS_LOB.GETLENGTH(v_bfile));

      -- CERRANDO EL ARCHIVO
      DBMS_LOB.CLOSE(v_bfile);  

      COMMIT; 
    END IF;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20099, 'ERROR DESCONOCIDO: ' || SQLERRM);
END;
/
SHOW ERRORS;
