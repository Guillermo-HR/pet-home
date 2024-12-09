--@Autor(es):       Aburto López Roberto
--@Fecha creación:  08/12/2024
--@Descripción:     scripts de pruabas para almacenar fotos en tabla monitoreo_cautiverio


SET SERVEROUTPUT ON 
Prompt Pruebas procedimiento insertar_icono_servicio 
Prompt =============================================
Prompt Prueba 1.
prompt Procedimiento con datos correctos
Prompt =============================================
DECLARE
v_blob BLOB;
BEGIN
  carga_foto_monitoreo_cautiverio(1,'perro1.jpg');
    SELECT foto 
    INTO v_blob
    FROM monitoreo_cautiverio
    WHERE monitoreo_cautiverio_id = 1;
  IF LENGTH(v_blob) > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Ok => prueba 1 ');
    DBMS_OUTPUT.PUT_LINE('Tamanio del archivo: '|| LENGTH(v_blob));
  else
    RAISE_APPLICATION_ERROR(-20000, 'ERROR: No se supero la prueba');
  end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Procedimiento con monitoreo no existente
Prompt ========================================
DECLARE
v_codigo NUMBER;
v_mensaje VARCHAR2(200);
BEGIN
  carga_foto_monitoreo_cautiverio(1000,'perro2.jpg');
EXCEPTION
  WHEN OTHERS THEN 
  v_codigo := SQLCODE;
  v_mensaje := SQLERRM;
  DBMS_OUTPUT.PUT_LINE('Codigo: '|| v_codigo);
  DBMS_OUTPUT.PUT_LINE('Mensaje: ' || v_mensaje);
  IF v_codigo = -20007 then
    dbms_output.put_line('OK => Prueba 2');
  else 
    dbms_output.put_line('Error: excepcion no esperada');
    raise;
  end if;
end;
/

PROMPT =======================================
PROMPT PRUEBA 3.
PROMPT PROCEDIMIENTO CON EXTENSION INCORRECTA 
PROMPT ========================================
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN
  carga_foto_monitoreo_cautiverio(2,'perro2.zip');
EXCEPTION 
  WHEN OTHERS THEN 
    v_codigo := SQLCODE;
    v_mensaje := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('CODIGO: ' || v_codigo);
    DBMS_OUTPUT.PUT_LINE('MENSAJE: ' || v_mensaje);
    IF v_codigo = -20006 THEN
      DBMS_OUTPUT.PUT_LINE('OK => PRUEBA 3');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('ERROR: EXCEPCION NO ESPERADA');
      RAISE;
    END IF;
END;
/

PROMPT =======================================
PROMPT PRUEBA 4.
PROMPT PROCEDIMIENTO CON ARCHIVO INEXISTENTE
PROMPT ========================================
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN
  carga_foto_monitoreo_cautiverio(2,'esteArchivoNoExiste.jpg');
EXCEPTION 
  WHEN OTHERS THEN 
    v_codigo := SQLCODE;
    v_mensaje := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('CODIGO: ' || v_codigo);
    DBMS_OUTPUT.PUT_LINE('MENSAJE: ' || v_mensaje);
    IF v_codigo = -20003 THEN
      DBMS_OUTPUT.PUT_LINE('OK => PRUEBA 4');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('ERROR: EXCEPCION NO ESPERADA');
      RAISE;
    END IF;
END;
/
