--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de pruebas para el triger historico de status mascota
PROMPT ========================================================
PROMPT Creación de pruebas para el triger historico de status mascota
PROMPT s-12-historico-status-mascota-trigger-prueba.sql
PROMPT ========================================================

SET SERVEROUTPUT ON

-- Probar insert
PROMPT ========================================================
PROMPT Probar insert
PROMPT ========================================================
SAVEPOINT sp_insert;

INSERT INTO mascota(mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
VALUES(mascota_seq.NEXTVAL, SYSDATE -30, SYSDATE -30, SYSDATE - 360, 'Mascota 1', '0000001', 1, 1, 1, 2);

-- Prueba 1 positiva

DECLARE
  v_count_historico NUMBER;
  v_ultimo_status_historico NUMBER;
  v_count_monitoreo NUMBER;
  v_mascota_id mascota.mascota_id%TYPE;

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 1 insert');

  v_mascota_id := mascota_seq.CURRVAL;

  -- Verificar que se inserto en historico_status_mascota
  SELECT COUNT(*) INTO v_count_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id;

  IF v_count_historico = 1 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (1/3) prueba insert exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  -- Verificar que el status en historico sea el correcto
  SELECT status_mascota_id INTO v_ultimo_status_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id
  ORDER BY historico_status_mascota_id DESC
  FETCH FIRST 1 ROWS ONLY;

  IF v_ultimo_status_historico = 1 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (2/3) prueba insert exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  -- Verificar que se inserto en monitoreo_cautiverio
  SELECT COUNT(*) INTO v_count_monitoreo
  FROM monitoreo_cautiverio
  WHERE mascota_id = v_mascota_id;

  IF v_count_monitoreo = 1 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (3/3) prueba insert exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  DBMS_OUTPUT.PUT_LINE('Prueba insert 1 exitosa');
  DBMS_OUTPUT.PUT_LINE('Prueba insert 1 terminada');
  
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Prueba insert 1 terminada (con errores)');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba insert 1 terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_insert;

-- Probar update
PROMPT ========================================================
PROMPT Probar update
PROMPT ========================================================
SAVEPOINT sp_update;

INSERT INTO mascota(mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
VALUES(mascota_seq.NEXTVAL, SYSDATE -30, SYSDATE -30, SYSDATE - 360, 'Mascota 2', '0000002', 1, 1, 1, 2);

-- Prueba 1 positiva
SAVEPOINT sp_update_1;
UPDATE mascota
SET status_mascota_id = 2,
  fecha_status = SYSDATE - 20
WHERE mascota_id = (SELECT MAX(mascota_id) FROM mascota);

DECLARE 
  v_mascota_id mascota.mascota_id%TYPE;
  v_count_historico NUMBER;
  v_ultimo_status_historico NUMBER;

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 1 update (positiva)');

  v_mascota_id := mascota_seq.CURRVAL;

  -- Verificar que se inserto en historico_status_mascota
  
  SELECT COUNT(*) INTO v_count_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id;

  IF v_count_historico = 2 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (1/2) prueba update 1 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  -- Verificar que el status en historico sea el correcto
  SELECT status_mascota_id INTO v_ultimo_status_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id
  ORDER BY fecha_status DESC
  FETCH FIRST 1 ROWS ONLY;

  IF v_ultimo_status_historico = 2 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (2/2) prueba update 1 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('Prueba update 1 exitosa');
  DBMS_OUTPUT.PUT_LINE('Prueba update 1 terminada');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Prueba update 1 terminada (con errores)');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba update 1 terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_update_1;

-- Prueba 2 positiva
SAVEPOINT sp_update_2;
UPDATE mascota
SET status_mascota_id = 2,
  fecha_status = SYSDATE - 20
WHERE mascota_id = (SELECT MAX(mascota_id) FROM mascota);

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, fecha_status, mascota_id, cliente_id, status_solicitud_id)
VALUES(cliente_mascota_solicitud_seq.NEXTVAL, SYSDATE - 10, mascota_seq.CURRVAL, 1, 1);

UPDATE mascota
SET status_mascota_id = 5,
  fecha_status = SYSDATE - 5
WHERE mascota_id = (SELECT MAX(mascota_id) FROM mascota);
DECLARE 
  v_mascota_id mascota.mascota_id%TYPE;
  v_count_historico NUMBER;
  v_ultimo_status_historico NUMBER;
  v_status_solicitud NUMBER;

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 2 update (positiva)');

  v_mascota_id := mascota_seq.CURRVAL;

  -- Verificar que se inserto en historico_status_mascota
  
  SELECT COUNT(*) INTO v_count_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id
  ORDER BY historico_status_mascota_id DESC;
  
  IF v_count_historico = 4 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (1/3) prueba update 2 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  -- Verificar que el status en historico sea el correcto
  SELECT status_mascota_id INTO v_ultimo_status_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id
  ORDER BY historico_status_mascota_id DESC
  FETCH FIRST 1 ROWS ONLY;

  IF v_ultimo_status_historico = 5 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (2/3) prueba update 2 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  -- Verificar que se actualizo la solicitud
  SELECT status_solicitud_id INTO v_status_solicitud
  FROM cliente_mascota_solicitud
  WHERE cliente_mascota_solicitud_id = (SELECT MAX(cliente_mascota_solicitud_id) FROM cliente_mascota_solicitud);

  IF v_status_solicitud = 3 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (3/3) prueba update 2 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  DBMS_OUTPUT.PUT_LINE('Prueba update 2 exitosa');
  DBMS_OUTPUT.PUT_LINE('Prueba update 2 terminada');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Prueba update 2 terminada (con errores)');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba update 2 terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_update_2;

-- Prueba 3 positiva
SAVEPOINT sp_update_3;
UPDATE mascota
SET status_mascota_id = 2,
  fecha_status = SYSDATE - 20
WHERE mascota_id = (SELECT MAX(mascota_id) FROM mascota);

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, fecha_status, mascota_id, cliente_id, status_solicitud_id)
VALUES(cliente_mascota_solicitud_seq.NEXTVAL, SYSDATE - 10, mascota_seq.CURRVAL, 1, 1);

UPDATE mascota
SET status_mascota_id = 6,
  fecha_status = SYSDATE - 5
WHERE mascota_id = (SELECT MAX(mascota_id) FROM mascota);

DECLARE 
  v_mascota_id mascota.mascota_id%TYPE;
  v_count_historico NUMBER;
  v_ultimo_status_historico NUMBER;
  v_status_solicitud NUMBER;

  v_codigo NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Iniciando prueba 3 update (positiva)');

  v_mascota_id := mascota_seq.CURRVAL;

  -- Verificar que se inserto en historico_status_mascota
  
  SELECT COUNT(*) INTO v_count_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id;
  
  IF v_count_historico = 4 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (1/3) prueba update 3 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  -- Verificar que el status en historico sea el correcto
  SELECT status_mascota_id INTO v_ultimo_status_historico
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id
  ORDER BY fecha_status DESC
  FETCH FIRST 1 ROWS ONLY;

  IF v_ultimo_status_historico = 6 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (2/3) prueba update 3 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  -- Verificar que se actualizo la solicitud
  SELECT status_solicitud_id INTO v_status_solicitud
  FROM cliente_mascota_solicitud
  WHERE cliente_mascota_solicitud_id = (SELECT MAX(cliente_mascota_solicitud_id) FROM cliente_mascota_solicitud);

  IF v_status_solicitud = 3 THEN
    DBMS_OUTPUT.PUT_LINE(' -> Parte (3/3) prueba update 3 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, ' -> Prueba fallida');
  END IF;

  DBMS_OUTPUT.PUT_LINE('Prueba update 3 exitosa');
  DBMS_OUTPUT.PUT_LINE('Prueba update 3 terminada');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Prueba update 3 terminada (con errores)');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Prueba update 3 terminada (con errores)');
      RAISE;
    END IF;
END;
/

ROLLBACK TO sp_update_3;

ROLLBACK TO sp_update;