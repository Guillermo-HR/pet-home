--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de pruebas para el triger historico de status mascota
PROMPT ========================================================
PROMPT Creación de pruebas para el triger historico de status mascota
PROMPT s-12-historico-status-mascota-trigger-prueba.sql
PROMPT ========================================================

SET SERVEROUTPUT ON

-- Probar caso insert
PROMPT ========================================================
PROMPT Probar caso insert
PROMPT ========================================================
SAVEPOINT sp_insert;

INSERT INTO mascota(mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
VALUES(mascota_seq.NEXTVAL, SYSDATE - 360, 'Prueba1', '0000000', 1, 1, 1, 2);

DECLARE
  v_count NUMBER;
  v_mascota_id mascota.mascota_id%TYPE;

  v_codigo NUMBER;
BEGIN
  v_mascota_id := mascota_seq.CURRVAL;

  SELECT COUNT(*) INTO v_count
  FROM historico_status_mascota
  WHERE mascota_id = v_mascota_id;

  IF v_count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('-- Prueba insert exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, '-- Prueba fallida');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo != -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      RAISE;
    END IF;
END;
/
SHOW ERRORS;

ROLLBACK TO sp_insert;
  
-- Probar casos update
PROMPT ========================================================
PROMPT Probar caso update simple
PROMPT ========================================================
SAVEPOINT sp_update_1;

INSERT INTO mascota(mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
VALUES(mascota_seq.NEXTVAL, SYSDATE - 360, 'Prueba2', '0000001', 1, 1, 1, 2);

UPDATE mascota
SET status_mascota_id = 2
WHERE folio = '0000001';

DECLARE
  v_count NUMBER;
  v_fecha_status mascota.fecha_status%TYPE;
  v_status_id mascota.status_mascota_id%TYPE;
  v_mascota_id mascota.mascota_id%TYPE;

  v_codigo NUMBER;
BEGIN
  v_mascota_id := mascota_seq.CURRVAL;

  SELECT fecha_status, status_mascota_id INTO v_fecha_status, v_status_id
  FROM mascota
  WHERE mascota_id = v_mascota_id;

  SELECT COUNT(*) INTO v_count
  FROM historico_status_mascota
  WHERE fecha_status = v_fecha_status AND
  status_mascota_id = v_status_id AND
  mascota_id = v_mascota_id;

  IF v_count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('-- Prueba update 1 exitosa');
  ELSE
    RAISE_APPLICATION_ERROR(-20000, '-- Prueba fallida');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo != -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      RAISE;
    END IF;
END;
/
SHOW ERRORS;

ROLLBACK TO sp_update_1;

PROMPT ========================================================
PROMPT Probar caso update con nuevo status: 5
PROMPT ========================================================
SAVEPOINT sp_update_1;

INSERT INTO mascota(mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
VALUES(mascota_seq.NEXTVAL, SYSDATE - 360, 'Prueba3', '0000002', 1, 1, 1, 2);

UPDATE mascota
SET status_mascota_id = 2
WHERE folio = '0000002';

INSERT INTO cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, ocupacion, username, password)
VALUES (cliente_seq.NEXTVAL, 'Cliente1P3', 'Cliente1P3', 'Cliente1P3', 'Cliente1P3', 'Cliente1P3', 'Cliente1P3', 'contraseña');

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id)
VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1);

INSERT INTO cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, ocupacion, username, password)
VALUES (cliente_seq.NEXTVAL, 'Cliente2P3', 'Cliente2P3', 'Cliente2P3', 'Cliente2P3', 'Cliente2P3', 'Cliente2P3', 'contraseña');

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id)
VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1);

UPDATE mascota
SET status_mascota_id = 5
WHERE folio = '0000002';

DECLARE
  CURSOR cur_solicitud IS
    SELECT status_solicitud_id
    FROM cliente_mascota_solicitud
    WHERE mascota_id = (SELECT mascota_id FROM mascota WHERE folio = '0000002');

  v_count NUMBER;
  v_fecha_status mascota.fecha_status%TYPE;
  v_status_id mascota.status_mascota_id%TYPE;
  v_mascota_id mascota.mascota_id%TYPE;

  v_codigo NUMBER;
BEGIN
  v_mascota_id := mascota_seq.CURRVAL;

  SELECT fecha_status, status_mascota_id INTO v_fecha_status, v_status_id
  FROM mascota
  WHERE mascota_id = v_mascota_id;

  SELECT COUNT(*) INTO v_count
  FROM historico_status_mascota
  WHERE fecha_status = v_fecha_status AND
  status_mascota_id = v_status_id AND
  mascota_id = v_mascota_id;

  IF v_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20000, '-- Prueba fallida');
  END IF;

  FOR c in cur_solicitud LOOP
    IF c.status_solicitud_id != 3 THEN
      RAISE_APPLICATION_ERROR(-20000, '-- Prueba fallida');
    END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('-- Prueba update 2 exitosa');


EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo != -20000 THEN
      DBMS_OUTPUT.PUT_LINE('Ocurrio un error inesperado');
      DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
      DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
      RAISE;
    END IF;
END;
/
SHOW ERRORS;

ROLLBACK TO sp_update_1;