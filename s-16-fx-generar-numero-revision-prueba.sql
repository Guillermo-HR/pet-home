--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de pruebas para la funcion que genera numeros de revision
PROMPT ========================================================
PROMPT Creación de pruebas para la funcion que genera numeros de revision
PROMPT s-16-fx-generar-numero-revision-prueba.sql
PROMPT ========================================================
SET SERVEROUTPUT ON

-- Prueba positiva
PROMPT ========================================================
PROMPT Prueba positiva
PROMPT ========================================================

SAVEPOINT sp_1;

INSERT INTO mascota(mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
VALUES(mascota_seq.NEXTVAL, SYSDATE, SYSDATE, SYSDATE, 'Mascota 1', '0000001', 1, 1, 1, 2);

UPDATE mascota
SET status_mascota_id = 4
WHERE folio = '0000001';

DECLARE
  v_mascota_id mascota.mascota_id%TYPE;
  v_numero_correcto NUMBER;
  v_numero_generado NUMBER;

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 1 positiva');
  SELECT mascota_id INTO v_mascota_id FROM mascota WHERE folio = '0000001';
  v_numero_correcto := 1;
  v_numero_generado := generar_n_revision(v_mascota_id);
  IF v_numero_generado = v_numero_correcto THEN
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

-- Prueba negativa
PROMPT ========================================================
PROMPT Prueba negativa
PROMPT ========================================================

SAVEPOINT sp_2;

DECLARE
  v_n_mascotas NUMBER;
  v_numero_consulta NUMBER;

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 1 negativa');
    v_n_mascotas := mascota_seq.CURRVAL + 1;
    v_numero_consulta := generar_n_revision(v_n_mascotas);
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20013 THEN
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

ROLLBACK TO sp_2;

SAVEPOINT sp_3;

INSERT INTO mascota(mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
VALUES(mascota_seq.NEXTVAL, SYSDATE, SYSDATE, SYSDATE, 'Mascota 2', '0000002', 1, 1, 1, 2);

DECLARE
  v_n_mascotas NUMBER;
  v_numero_consulta NUMBER;

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 1 negativa');
    v_n_mascotas := mascota_seq.CURRVAL + 1;
    v_numero_consulta := generar_n_revision(v_n_mascotas);
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20013 THEN
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