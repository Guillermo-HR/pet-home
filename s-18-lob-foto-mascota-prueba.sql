--@AUTOR(ES):       Jaime Manuel Miranda Serrano y Diego Adrian Del Razo Sanchez
--@FECHA CREACIÓN:  07/12/2024
--@DESCRIPCIÓN:     Prueba procedimiento para almacenar fotos en la tabla monitoreo_cautiverio

SET SERVEROUTPUT ON;

PROMPT PRUEBAS PROCEDIMIENTO insertar_foto_monitoreo
PROMPT =======================================
PROMPT PRUEBA 1.
PROMPT PROCEDIMIENTO CON DATOS CORRECTOS
PROMPT ========================================
DECLARE
  v_blob BLOB;
BEGIN
  insertar_foto_monitoreo(1, 'foto1.png');
  SELECT foto INTO v_blob
  FROM monitoreo_cautiverio
  WHERE monitoreo_cautiverio_id = 1;
  
  IF LENGTH(v_blob) > 0 THEN
    DBMS_OUTPUT.PUT_LINE('OK, PRUEBA 1 EXITOSA');
    DBMS_OUTPUT.PUT_LINE('TAMAÑO DEL ARCHIVO: ' || LENGTH(v_blob));
  ELSE
    RAISE_APPLICATION_ERROR(-20005, 'ERROR: EL PROCEDIMIENTO PRESENTA PROBLEMAS');
  END IF;
END;
/

PROMPT =======================================
PROMPT PRUEBA 2.
PROMPT PROCEDIMIENTO CON MONITOREO NO EXISTENTE
PROMPT ========================================
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN
  insertar_foto_monitoreo(101, 'foto_inexistente.png');
EXCEPTION 
  WHEN OTHERS THEN 
    v_codigo := SQLCODE;
    v_mensaje := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || v_codigo);
    DBMS_OUTPUT.PUT_LINE('MENSAJE: ' || v_mensaje);
    IF v_codigo = -20001 THEN
      DBMS_OUTPUT.PUT_LINE('OK, PRUEBA 2 EXITOSA');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('ERROR: EXCEPCIÓN NO ESPERADA');
      RAISE;
    END IF;
END;
/

PROMPT =======================================
PROMPT PRUEBA 3.
PROMPT PROCEDIMIENTO CON EXTENSIÓN INCORRECTA
PROMPT ========================================
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN
  insertar_foto_monitoreo(1, 'foto_incorrecta.pdf');
EXCEPTION 
  WHEN OTHERS THEN 
    v_codigo := SQLCODE;
    v_mensaje := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || v_codigo);
    DBMS_OUTPUT.PUT_LINE('MENSAJE: ' || v_mensaje);
    IF v_codigo = -20002 THEN
      DBMS_OUTPUT.PUT_LINE('OK, PRUEBA 3 EXITOSA');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('ERROR: EXCEPCIÓN NO ESPERADA');
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
  insertar_foto_monitoreo(1, 'archivo_no_encontrado.png');
EXCEPTION 
  WHEN OTHERS THEN 
    v_codigo := SQLCODE;
    v_mensaje := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || v_codigo);
    DBMS_OUTPUT.PUT_LINE('MENSAJE: ' || v_mensaje);
    IF v_codigo = -20003 THEN
      DBMS_OUTPUT.PUT_LINE('OK, PRUEBA 4 EXITOSA');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('ERROR: EXCEPCIÓN NO ESPERADA');
      RAISE;
    END IF;
END;
/
