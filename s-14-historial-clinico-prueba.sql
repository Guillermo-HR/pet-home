--@Autor(es): Aburto López Roberto
--@Fecha creación: 5/12/2024
--@Descripción: Creación de pruebas para la funcion historiales clinicos

SET SERVEROUTPUT ON;


PROMPT =============================================
PROMPT PRUEBAS s-14-historial-clinico-prueba.sql
PROMPT =============================================


PROMPT =============================================
PROMPT Prueba 1: Procedimiento con datos correctos
PROMPT =============================================
BEGIN
    guardar_historial_clinico(2,'historial_correcto.txt');
    DBMS_OUTPUT.PUT_LINE('Prueba 1: OK => Procedimiento ejecutado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Prueba 1: ERROR inesperado: ' || SQLERRM);
END;
/
SHOW ERRORS;


PROMPT =============================================
PROMPT Prueba 2: Archivo con extension erroneo
PROMPT =============================================
BEGIN
    guardar_historial_clinico(101,'archivo_invalido.pdf');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20006 THEN
            DBMS_OUTPUT.PUT_LINE('Prueba 2: OK => manejo de error de extension');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Prueba 2: ERROR => Excepción no esperada.');
        END IF;
END;
/
SHOW ERRORS;

PROMPT =============================================
PROMPT Prueba 3: ID de mascota inexistente
PROMPT =============================================
BEGIN
    guardar_historial_clinico(9999,'historial_inexistente.txt');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20013 THEN
            DBMS_OUTPUT.PUT_LINE('Prueba 3: OK => Validación de ID inexistente correcta.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Prueba 3: ERROR => Excepción no esperada.');
        END IF;
END;
/
SHOW ERRORS;


PROMPT =============================================
PROMPT Fin de las pruebas
PROMPT =============================================
