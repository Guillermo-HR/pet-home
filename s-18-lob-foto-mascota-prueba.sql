--@Autor(es):       Aburto López Roberto
--@Fecha creación:  08/12/2024
--@Descripción:     scripts de pruabas para almacenar fotos en tabla monitoreo_cautiverio


-- Prueba 1: Procedimiento con datos correctos
PROMPT =============================================
PROMPT Prueba 1.
PROMPT Procedimiento con datos correctos
PROMPT =============================================
BEGIN
  SAVEPOINT prueba_1; -- Definir el punto de guardado dentro del mismo bloque
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
      DBMS_OUTPUT.PUT_LINE('Tamanio del archivo: ' || LENGTH(v_blob));
    ELSE
      RAISE_APPLICATION_ERROR(-20000, 'ERROR: No se supero la prueba');
    END IF;
  END; -- Fin del bloque de pruebas
  ROLLBACK TO prueba_1; -- Revertir los cambios aquí
END;
/
SHOW ERRORS;


-- Prueba 2: Procedimiento con monitoreo no existente
PROMPT =============================================
PROMPT Prueba 2.
PROMPT Procedimiento con monitoreo no existente
PROMPT =============================================
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN
  SAVEPOINT prueba_2;
  BEGIN
    carga_foto_monitoreo_cautiverio(1000,'perro2.jpg');;
  EXCEPTION
    WHEN OTHERS THEN 
      v_codigo := SQLCODE;
      v_mensaje := SQLERRM;
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || v_mensaje);
      IF v_codigo = -20007 THEN
        DBMS_OUTPUT.PUT_LINE('OK => Prueba 2');
      ELSE 
        DBMS_OUTPUT.PUT_LINE('Error: excepcion no esperada');
        RAISE;
      END IF;
  END;
  ROLLBACK TO prueba_2; -- Revertimos cambios
END;
/
SHOW ERRORS;


- Prueba 3: Procedimiento con extensión incorrecta
PROMPT =============================================
PROMPT Prueba 3.
PROMPT Procedimiento con extensión incorrecta
PROMPT =============================================
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN 
  SAVEPOINT prueba_3;
  BEGIN
    carga_foto_monitoreo_cautiverio(2,'perro2.zip');
  EXCEPTION 
    WHEN OTHERS THEN 
      v_codigo := SQLCODE;
      v_mensaje := SQLERRM;
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || v_mensaje);
      IF v_codigo = -20006 THEN
        DBMS_OUTPUT.PUT_LINE('OK => Prueba 3');
      ELSE 
        DBMS_OUTPUT.PUT_LINE('Error: excepcion no esperada');
        RAISE;
      END IF;
  END;
  ROLLBACK TO prueba_3; -- Revertimos cambios
END;
/
SHOW ERRORS;

-- Prueba 4: Procedimiento con archivo inexistente
PROMPT =============================================
PROMPT Prueba 4.
PROMPT Procedimiento con archivo inexistente
PROMPT =============================================
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN
  SAVEPOINT prueba_4;
  BEGIN
    carga_foto_monitoreo_cautiverio(2,'esteArchivoNoExiste.jpg');
  EXCEPTION 
    WHEN OTHERS THEN 
      v_codigo := SQLCODE;
      v_mensaje := SQLERRM;
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || v_mensaje);
      IF v_codigo = -20008 THEN
        DBMS_OUTPUT.PUT_LINE('OK => Prueba 4');
      ELSE 
        DBMS_OUTPUT.PUT_LINE('Error: excepcion no esperada');
        RAISE;
      END IF;
  END;
  ROLLBACK TO prueba_4; -- Revertimos cambios
END;
/
SHOW ERRORS;

PROMPT =============================================
PROMPT Fin de pruebas
PROMPT =============================================

