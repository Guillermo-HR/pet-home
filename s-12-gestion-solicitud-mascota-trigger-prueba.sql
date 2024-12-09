SET SERVEROUTPUT ON;

PROMPT ========================================================
PROMPT Pruebas para el trigger de gestión de solicitudes de adopción
PROMPT ========================================================

-- Crear un SAVEPOINT inicial para rollback
SAVEPOINT inicial;

-- Caso 1: Insertar una nueva solicitud con una mascota válida y un cliente válido
PROMPT ========================================================
PROMPT Prueba 1: Insertar solicitud válida
PROMPT ========================================================

DECLARE
  v_codigo NUMBER;
BEGIN
  INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
  VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota1', '000001', 1, 2, 1, 1);

  INSERT INTO cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, ocupacion, username, password)
  VALUES (cliente_seq.NEXTVAL, 'Cliente1', 'Apellido1', 'Apellido2', 'Direccion1', 'Ocupacion1', 'cliente1', 'contraseña');

  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status, comentario)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1, SYSDATE, NULL);

  DBMS_OUTPUT.PUT_LINE('-- Prueba 1: Solicitud válida insertada exitosamente');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    DBMS_OUTPUT.PUT_LINE('-- Prueba 1 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
    ROLLBACK TO inicial;
END;
/

-- Caso 2: Insertar una solicitud que exceda el límite de mascotas permitidas
PROMPT ========================================================
PROMPT Prueba 2: Límite de mascotas excedido
PROMPT ========================================================

DECLARE
  v_codigo NUMBER;
BEGIN
  -- Crear 5 mascotas adoptadas previamente
  FOR i IN 1..5 LOOP
    INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
    VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota' || i, '00000' || i, 1, 4, 1, 1);

    INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status, comentario)
    VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 2, SYSDATE - 10, 'Aprobada');
  END LOOP;

  -- Intentar insertar una nueva solicitud
  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status, comentario)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1, SYSDATE, NULL);

EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    IF v_codigo = -20002 THEN
      DBMS_OUTPUT.PUT_LINE('-- Prueba 2 exitosa: Límite de mascotas detectado.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('-- Prueba 2 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
    END IF;
    ROLLBACK TO inicial;
END;
/

-- Caso 3: Actualizar el estado de una solicitud aprobada
PROMPT ========================================================
PROMPT Prueba 3: Actualizar solicitud a "Aprobada"
PROMPT ========================================================

DECLARE
  v_codigo NUMBER;
BEGIN
  INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
  VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota2', '000002', 1, 3, 1, 1);

  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status, comentario)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1, SYSDATE - 5, NULL);

  -- Aprobar la solicitud
  UPDATE cliente_mascota_solicitud
  SET status_solicitud_id = 2
  WHERE cliente_mascota_solicitud_id = cliente_mascota_solicitud_seq.CURRVAL;

  DBMS_OUTPUT.PUT_LINE('-- Prueba 3 exitosa: Solicitud aprobada correctamente');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    DBMS_OUTPUT.PUT_LINE('-- Prueba 3 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
    ROLLBACK TO inicial;
END;
/

-- Caso 4: Rechazar una solicitud
PROMPT ========================================================
PROMPT Prueba 4: Rechazar solicitud
PROMPT ========================================================

DECLARE
  v_codigo NUMBER;
BEGIN
  INSERT INTO mascota (mascota_id, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)
  VALUES (mascota_seq.NEXTVAL, SYSDATE - 360, 'Mascota3', '000003', 1, 3, 1, 1);

  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, mascota_id, cliente_id, status_solicitud_id, fecha_status, comentario)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, mascota_seq.CURRVAL, cliente_seq.CURRVAL, 1, SYSDATE, NULL);

  -- Rechazar la solicitud
  UPDATE cliente_mascota_solicitud
  SET status_solicitud_id = 3
  WHERE cliente_mascota_solicitud_id = cliente_mascota_solicitud_seq.CURRVAL;

  DBMS_OUTPUT.PUT_LINE('-- Prueba 4 exitosa: Solicitud rechazada correctamente');
EXCEPTION
  WHEN OTHERS THEN
    v_codigo := SQLCODE;
    DBMS_OUTPUT.PUT_LINE('-- Prueba 4 fallida. Código: ' || v_codigo || ' Mensaje: ' || SQLERRM);
    ROLLBACK TO inicial;
END;
/

-- Revertir cambios para mantener la base de datos limpia
ROLLBACK TO inicial;
