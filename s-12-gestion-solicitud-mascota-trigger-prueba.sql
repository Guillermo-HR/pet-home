PROMPT ========================================================
PROMPT Pruebas para el trigger de la gestión de solicitudes de adopción
PROMPT s-11-gestion-solicitud-mascota-trigger-prueba.sql
PROMPT ========================================================

SET SERVEROUTPUT ON;

PROMPT ========================================================
PROMPT Probar caso: Insertar solicitud de adopción válida
PROMPT ========================================================
SAVEPOINT sp_insert_valida;

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, cliente_id, mascota_id, status_solicitud_id, fecha_status, comentario)
VALUES (cliente_mascota_solicitud_seq.NEXTVAL, 1, 101, 1, SYSDATE, NULL);

ROLLBACK TO sp_insert_valida;

PROMPT ========================================================
PROMPT Probar caso: Exceder el límite de mascotas permitidas
PROMPT ========================================================
SAVEPOINT sp_limite_mascotas;

DECLARE
  i NUMBER;
BEGIN
  FOR i IN 1..5 LOOP
    INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, cliente_id, mascota_id, status_solicitud_id, fecha_status, comentario)
    VALUES (cliente_mascota_solicitud_seq.NEXTVAL, 1, i + 100, 2, SYSDATE, NULL);
  END LOOP;
  
  INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, cliente_id, mascota_id, status_solicitud_id, fecha_status, comentario)
  VALUES (cliente_mascota_solicitud_seq.NEXTVAL, 1, 106, 1, SYSDATE, NULL);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Excepción capturada: ' || SQLERRM);
    ROLLBACK TO sp_limite_mascotas;
END;

PROMPT ========================================================
PROMPT Probar caso: Mascota no disponible para adopción
PROMPT ========================================================
SAVEPOINT sp_mascota_no_disponible;

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, cliente_id, mascota_id, status_solicitud_id, fecha_status, comentario)
VALUES (cliente_mascota_solicitud_seq.NEXTVAL, 2, 102, 1, SYSDATE, NULL);

ROLLBACK TO sp_mascota_no_disponible;

PROMPT ========================================================
PROMPT Probar caso: Aprobación de solicitud de adopción
PROMPT ========================================================
SAVEPOINT sp_aprobacion;

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, cliente_id, mascota_id, status_solicitud_id, fecha_status, comentario)
VALUES (cliente_mascota_solicitud_seq.NEXTVAL, 3, 103, 2, SYSDATE, NULL);

ROLLBACK TO sp_aprobacion;

PROMPT ========================================================
PROMPT Probar caso: Rechazo de solicitud de adopción
PROMPT ========================================================
SAVEPOINT sp_rechazo;

INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, cliente_id, mascota_id, status_solicitud_id, fecha_status, comentario)
VALUES (cliente_mascota_solicitud_seq.NEXTVAL, 3, 104, 3, SYSDATE, NULL);

ROLLBACK TO sp_rechazo;

PROMPT ========================================================
PROMPT Finalización de las pruebas para el trigger de solicitudes de adopción
PROMPT ========================================================
