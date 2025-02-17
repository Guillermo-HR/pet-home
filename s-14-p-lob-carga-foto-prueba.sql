-- @Autor(es):       Aburto López Roberto
-- @Fecha creación:  08/12/2024
-- @Descripción:     Scripts de pruebas para almacenar fotos en tabla centro_refugio con manejo de rollbacks

PROMPT =============================================
PROMPT PRUEBAS s-14-p-lob-carga-foto.sql
PROMPT =============================================
SET SERVEROUTPUT ON 

-- Prueba 1: Procedimiento con datos correctos
PROMPT =============================================
PROMPT Prueba 1.
PROMPT Procedimiento con datos correctos
PROMPT =============================================
SAVEPOINT sp_1;

DECLARE
    v_blob BLOB;
  BEGIN
    carga_foto_dinamico(
        'centro_refugio',         -- Tabla
        'logo',                   -- Columna BLOB
        'centro_refugio_id',      -- Columna ID
        1,                        -- ID del registro
        'LOGO_REFUGIO',           -- Directorio lógico
        'refugio1.jpg'            -- Archivo a cargar
    );
    SELECT logo 
    INTO v_blob
    FROM centro_refugio
    WHERE centro_refugio_id = 1;
    
    IF LENGTH(v_blob) > 0 THEN
      DBMS_OUTPUT.PUT_LINE('Ok => prueba 1 ');
      DBMS_OUTPUT.PUT_LINE('Tamanio del archivo: ' || LENGTH(v_blob));
    ELSE
      RAISE_APPLICATION_ERROR(-20000, 'ERROR: No se supero la prueba');
    END IF;
END;
/
ROLLBACK sp_1;


-- Prueba 2: Procedimiento con monitoreo no existente
PROMPT =============================================
PROMPT Prueba 2.
PROMPT Procedimiento con monitoreo no existente
PROMPT =============================================

SAVEPOINT sp_2;
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
  BEGIN
    carga_foto_dinamico(
        'centro_refugio',         -- Tabla
        'logo',                   -- Columna BLOB
        'centro_refugio_id',      -- Columna ID
        999,                      -- ID del registro incorrecto
        'LOGO_REFUGIO',           -- Directorio lógico
        'refugio1.jpg'            -- Archivo a cargar
    );
  EXCEPTION
    WHEN OTHERS THEN 
      v_codigo := SQLCODE;
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
      IF v_codigo = -20007 THEN
        DBMS_OUTPUT.PUT_LINE('OK => Prueba 2');
      ELSE 
        DBMS_OUTPUT.PUT_LINE('Error: excepcion no esperada');
        RAISE;
      END IF;
END;
/
ROLLBACK sp_2;


-- Prueba 3: Procedimiento con extensión incorrecta
PROMPT =============================================
PROMPT Prueba 3.
PROMPT Procedimiento con extensión incorrecta
PROMPT =============================================

SAVEPOINT sp_3;
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
BEGIN 
    carga_foto_dinamico(
        'centro_refugio',         -- Tabla
        'logo',                   -- Columna BLOB
        'centro_refugio_id',      -- Columna ID
        1,                      -- ID del registro incorrecto
        'LOGO_REFUGIO',           -- Directorio lógico
        'refugio1.zip'            -- Archivo a cargar
    );
  EXCEPTION 
    WHEN OTHERS THEN 
      v_codigo := SQLCODE;
      IF v_codigo = -20006 THEN
        DBMS_OUTPUT.PUT_LINE('OK => Prueba 3');
      ELSE 
        DBMS_OUTPUT.PUT_LINE('Error: excepcion no esperada');
        RAISE;
      END IF;
END;
/
ROLLBACK sp_3;


-- Prueba 4: Procedimiento con archivo inexistente
PROMPT =============================================
PROMPT Prueba 4.
PROMPT Procedimiento con archivo inexistente
PROMPT =============================================

SAVEPOINT sp_4;
DECLARE
  v_codigo NUMBER;
  v_mensaje VARCHAR2(200);
  BEGIN
        carga_foto_dinamico(
        'centro_refugio',         -- Tabla
        'logo',                   -- Columna BLOB
        'centro_refugio_id',      -- Columna ID
        1,                        -- ID del registro incorrecto
        'LOGO_REFUGIO',           -- Directorio lógico
        'esteArchivoNoExiste.jpg' -- Archivo a cargar incorrecto
    );
  EXCEPTION 
    WHEN OTHERS THEN 
      v_codigo := SQLCODE;
      IF v_codigo = -20008 THEN
        DBMS_OUTPUT.PUT_LINE('OK => Prueba 4');
      ELSE 
        DBMS_OUTPUT.PUT_LINE('Error: excepcion no esperada');
        RAISE;
      END IF;
END;
/

ROLLBACK sp_4;



PROMPT =============================================
PROMPT Fin de pruebas
PROMPT =============================================
