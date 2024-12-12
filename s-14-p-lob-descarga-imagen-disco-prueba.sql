
--@AUTOR(ES):       Aburto López Roberto
--@FECHA CREACIÓN:  07/12/2024
--@DESCRIPCIÓN:     Pruebas de Procedimiento para almacenar en disco lob (dinamico)

-- Prueba 1: Procedimiento con datos correctos
PROMPT ====================================================
PROMPT Pruebas s-14-p-lob-descarga-imagen-disco-prueba.sql
PROMPT ====================================================

SET SERVEROUTPUT ON;

exec carga_foto_dinamico('centro_refugio','logo','centro_refugio_id',1,'LOGO_REFUGIO','refugio1.jpg');
COMMIT;
select * from CENTRO_REFUGIO;

-- Prueba 1: Procedimiento con datos correctos
PROMPT =============================================
PROMPT Prueba 1: Procedimiento con datos correctos
PROMPT =============================================
DECLARE
    v_longitud NUMBER;
BEGIN
    guarda_disco_blob(
        'DESCARGA_LOGO_CENTRO',     -- Nombre del directorio lógico
        'refugio1.jpg',             -- Nombre del archivo a exportar
        'centro_refugio',           -- Nombre de la tabla
        'logo',                     -- Nombre de la columna BLOB
        'centro_refugio_id',        -- Nombre de la columna ID
        1,                          -- Valor del ID (registro a exportar)
        v_longitud                  -- Variable para recibir la longitud del archivo exportado
    );
    DBMS_OUTPUT.PUT_LINE('Prueba 1: Archivo exportado correctamente con longitud: ' || v_longitud || ' bytes.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Prueba 1: Error inesperado: ' || SQLERRM);
END;
/
SHOW ERRORS;

-- Prueba 2: Registro no existente
PROMPT =============================================
PROMPT Prueba 2: Registro no existente
PROMPT =============================================
DECLARE
    v_longitud NUMBER;
BEGIN
    guarda_disco_blob(
        'DESCARGA_LOGO_CENTRO',     -- Nombre del directorio lógico
        'refugio1.jpg',             -- Nombre del archivo a exportar
        'centro_refugio',           -- Nombre de la tabla
        'logo',                     -- Nombre de la columna BLOB
        'centro_refugio_id',        -- Nombre de la columna ID
        9999,                       -- Valor del ID (no existe)
        v_longitud                  -- Variable para recibir la longitud del archivo exportado
    );
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20007 THEN
            DBMS_OUTPUT.PUT_LINE('Prueba 2: OK => Registro no existente manejado correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Prueba 2: ERROR => Excepción no esperada.');
        END IF;
END;
/
SHOW ERRORS;

-- Prueba 3: BLOB vacío
PROMPT =============================================
PROMPT Prueba 3: BLOB vacío
PROMPT =============================================
DECLARE
    v_longitud NUMBER;
BEGIN
    guarda_disco_blob(
            'DESCARGA_LOGO_CENTRO',     -- Nombre del directorio lógico
            'refugio1.jpg',             -- Nombre del archivo a exportar
            'centro_refugio',           -- Nombre de la tabla
            'logo',                     -- Nombre de la columna BLOB
            'centro_refugio_id',        -- Nombre de la columna ID
            3,                          -- Valor del ID (empty_blob)
            v_longitud                  -- Variable para recibir la longitud del archivo exportado
        );
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20010 THEN
            DBMS_OUTPUT.PUT_LINE('Prueba 3: OK => BLOB vacío manejado correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Prueba 3: ERROR => Excepción no esperada.');
        END IF;
END;
/
SHOW ERRORS;


PROMPT =============================================
PROMPT Fin de las pruebas
PROMPT =============================================
