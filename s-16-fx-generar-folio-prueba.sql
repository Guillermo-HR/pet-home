--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de pruebas para la funcion que genera folios
PROMPT ========================================================
PROMPT Creación de pruebas para la funcion que genera folios
PROMPT s-16-fx-generar-folio-prueba.sql
PROMPT ========================================================
SET SERVEROUTPUT ON

-- Prueba positiva
PROMPT ========================================================
PROMPT Prueba positiva
PROMPT ========================================================

SAVEPOINT sp_1;

DECLARE
  v_n_perros_registrados NUMBER;
  v_folio_correcto VARCHAR2(8);
  v_folio_generado VARCHAR2(8);

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 1 positiva');
  v_n_perros_registrados := folio_perro_seq.CURRVAL;
  v_folio_correcto := 'PR011' || SUBSTR(LPAD(v_n_perros_registrados + 1, 3, '0'), -3);
  v_folio_generado := generar_folio(1, 1, 1);
  IF v_folio_generado = v_folio_correcto THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (1/1) prueba 1 positiva exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;
  DBMS_OUTPUT.PUT_LINE('Prueba 1 positiva terminada');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Prueba 1 positiva terminada (con errores)');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba 1 positiva terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_1;

SAVEPOINT sp_2;

DECLARE
  v_n_gatos_registrados NUMBER;
  v_folio_correcto VARCHAR2(8);
  v_folio_generado VARCHAR2(8);

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 2 positiva');
  v_n_gatos_registrados := folio_gato_seq.CURRVAL;
  v_folio_correcto := 'GA023' || SUBSTR(LPAD(v_n_gatos_registrados + 1, 3, '0'), -3);
  v_folio_generado := generar_folio(29, 2, 3);
  IF v_folio_generado = v_folio_correcto THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (1/1) prueba 2 positiva exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;
  DBMS_OUTPUT.PUT_LINE('Prueba 2 positiva terminada');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Prueba 2 positiva terminada (con errores)');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba 2 positiva terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_2;


-- Prueba negativa
PROMPT ========================================================
PROMPT Prueba negativa
PROMPT ========================================================

SAVEPOINT sp_3;

DECLARE
  v_n_perros_registrados NUMBER;
  v_folio_generado VARCHAR2(8);

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 1 negativa');
  v_folio_generado := generar_folio(1, 20, 1);
  RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20010 THEN
      DBMS_OUTPUT.PUT_LINE(' -> Parte (1/1) prueba 1 negativa exitosa');
      DBMS_OUTPUT.PUT_LINE('Prueba 1 negativa terminada');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba 1 negativa terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_3;

SAVEPOINT sp_4;

DECLARE
  v_n_perros_registrados NUMBER;
  v_folio_generado VARCHAR2(8);

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 2 negativa');
  v_folio_generado := generar_folio(50, 1, 1);
  RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20012 THEN
      DBMS_OUTPUT.PUT_LINE(' -> Parte (1/1) prueba 2 negativa exitosa');
      DBMS_OUTPUT.PUT_LINE('Prueba 2 negativa terminada');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba 2 negativa terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_4;

SAVEPOINT sp_5;

DECLARE
  v_n_perros_registrados NUMBER;
  v_folio_generado VARCHAR2(8);

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 3 negativa');
  v_folio_generado := generar_folio(1, 1, 4);
  RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20011 THEN
      DBMS_OUTPUT.PUT_LINE(' -> Parte (1/1) prueba 3 negativa exitosa');
      DBMS_OUTPUT.PUT_LINE('Prueba 3 negativa terminada');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba 3 negativa terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_5;