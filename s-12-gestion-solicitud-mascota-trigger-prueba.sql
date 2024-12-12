PROMPT ========================================================
PROMPT PRUEBAS s-12-gestion-solicitud-mascota-trigger-prueba
PROMPT ========================================================
SET SERVEROUTPUT ON;

-- Caso 1: Insertar una nueva solicitud con una mascota válida y un cliente válido
PROMPT ========================================================
PROMPT Prueba 1: Insertar solicitud válida
PROMPT ========================================================
SAVEPOINT sp_1;
DECLARE
  v_codigo NUMBER;
BEGIN
  INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
  VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota1', '000001', 1, 2, 1, 2);

  INSERT INTO cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, ocupacion, username, password)
  VALUES (cliente_seq.NEXTVAL, 'Cliente1', 'Apellido1', 'Apellido2', 'Direccion1', 'Ocupacion1', 'cliente1', 'contraseña');

  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status, comentario)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1, SYSDATE, NULL);

  DBMS_OUTPUT.PUT_LINE('OK => Prueba 1: Solicitud válida insertada exitosamente');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    DBMS_OUTPUT.PUT_LINE('ERROR => Prueba 1 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
END;
/
ROLLBACK to sp_1;


PROMPT ========================================================
PROMPT Prueba 2 "La mascota no puede ser adoptada"
PROMPT ========================================================
SAVEPOINT sp_2;
DECLARE
  v_codigo NUMBER;
BEGIN
  INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
  VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota1', '000001', 1, 1, 1, 2);

  INSERT INTO cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, ocupacion, username, password)
  VALUES (cliente_seq.NEXTVAL, 'Cliente1', 'Apellido1', 'Apellido2', 'Direccion1', 'Ocupacion1', 'cliente1', 'contraseña');

  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status, comentario)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1, SYSDATE, NULL);
  EXCEPTION
    WHEN OTHERS THEN
      v_codigo := SQLCODE;
      IF v_codigo = -20003 THEN
        DBMS_OUTPUT.PUT_LINE('ok => Prueba 2 exitosa: La mascota no puede ser adoptada.');
      ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR => Prueba 2 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
      END IF;
END;
/
ROLLBACK TO sp_2;

PROMPT ========================================================
PROMPT Prueba 3 Status inválido para registro de solicitud
PROMPT ========================================================
SAVEPOINT sp_3;
DECLARE
  v_codigo NUMBER;
BEGIN
  INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
  VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota1', '000001', 1, 2, 1, 2);

  INSERT INTO cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, ocupacion, username, password)
  VALUES (cliente_seq.NEXTVAL, 'Cliente1', 'Apellido1', 'Apellido2', 'Direccion1', 'Ocupacion1', 'cliente1', 'contraseña');

  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 5, SYSDATE);

  EXCEPTION
    WHEN OTHERS THEN
      v_codigo := SQLCODE;
      IF v_codigo = -20004 THEN
        DBMS_OUTPUT.PUT_LINE('ok => Prueba 3 exitosa: Status inválido para registro de solicitud.');
      ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR => Prueba 2 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
      END IF;
END;
/
ROLLBACK to sp_3;
/*
PROMPT ========================================================
PROMPT Prueba para error -20005: "Solicitud de adopción fuera de tiempo"
PROMPT ========================================================
SAVEPOINT sp_4;
DECLARE
  v_codigo NUMBER;
BEGIN
  INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
  VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota1', '000001', 1, 2, 1, 2);

  INSERT INTO cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, ocupacion, username, password)
  VALUES (cliente_seq.NEXTVAL, 'Cliente1', 'Apellido1', 'Apellido2', 'Direccion1', 'Ocupacion1', 'cliente1', 'contraseña');
  -- Insertar una solicitud vieja para esta mascota
  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1, SYSDATE -20);

  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 2, SYSDATE);

  EXCEPTION
      WHEN OTHERS THEN
        v_codigo := SQLCODE;
        IF v_codigo = -20005 THEN
          DBMS_OUTPUT.PUT_LINE('ok => Prueba 4 exitosa: solicitud de adopcion fuera de tiempo');
        ELSE
          DBMS_OUTPUT.PUT_LINE('ERROR => Prueba 4 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
        END IF;
END;
/

ROLLBACK to sp_4;
*/
PROMPT ========================================================
PROMPT Fin de pruebas 
PROMPT ========================================================
