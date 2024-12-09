--@AUTOR(ES):       Aburto López Roberto
--@FECHA CREACIÓN:  07/12/2024
--@DESCRIPCIÓN:     Procedimiento para almacenar fotos en la tabla centro_refugio

define p_usuario='ah_proy_admin'
define p_usuario_pass='contrasena'
define p_sys_password='system1'
define p_pdb='ralbd_s1'

PROMPT ========================================================
PROMPT Procedimiento para almacenar fotos en la tabla centro_refugio
PROMPT s-17-lob-foto-mascota.sql
PROMPT ======================================

PROMPT Conectando como sys
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA 

CREATE OR REPLACE DIRECTORY LOGO_REFUGIO AS '/unam/bd/Proyecto/pet-home/logo_centro';
GRANT READ, WRITE ON DIRECTORY LOGO_REFUGIO TO &&p_usuario;

PROMPT Conectando con usuario admin
CONNECT &&p_usuario/&&p_usuario_pass@&&p_pdb

PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home/
!chmod 777 /unam/bd/Proyecto/pet-home/fotos

PROMPT Creando procedimiento carga_foto_centro_refugio 
CREATE OR REPLACE PROCEDURE carga_foto_centro_refugio(
  p_centro_refugio number, 
  p_nombre_archivo in varchar2 
)
IS
v_bfile bfile;
v_blob blob;
v_count number;
BEGIN
 --Verificando existencia del servicio
  SELECT COUNT(*)
  INTO v_count
  FROM centro_refugio
  WHERE centro_refugio_id = p_centro_refugio;

  if v_count = 0 then 
     RAISE_APPLICATION_ERROR(-20007, 'ERROR: Monitoreo no existe');
  --verificando que la extension sea .jpg
  elsif LOWER(SUBSTR(p_nombre_archivo, -4)) != '.jpg' then
    raise_application_error(-20006, 'ERROR: No es extension .jpg');
  else
    --Inicializando el bfile, que ubica de manera fisica el archivo
    v_bfile := BFILENAME('LOGO_REFUGIO',p_nombre_archivo);

    --Validando que el archivo exista en el directorio ICONOS
    if dbms_lob.fileexists(v_bfile) != 1 then
      raise_application_error(-20008, 'EL ARCHIVO NO EXISTE EN EL DIRECTORIO');
    --Validando que el archivo este cerrado
    elsif dbms_lob.isopen(v_bfile) = 1 then
      raise_application_error(-20009, 'EL ARCHIVO SE ENCUENTRA ABIERTO');
    else
      --Obteniendo el empty_blob y guardandolo en v_blob con un bloqueo
      SELECT logo 
      INTO v_blob
      FROM centro_refugio
      WHERE centro_refugio_id = p_centro_refugio
      FOR UPDATE;
      --leyendo el archivo
      DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY); 
      --cargando el archivo en la base
      DBMS_LOB.LOADFROMFILE(v_blob,v_bfile,DBMS_LOB.GETLENGTH(v_bfile));
      --cerrando el archivo
      DBMS_LOB.CLOSE(v_bfile);  
      commit; 
    end if;
  end if;

end;
/
show errors;