--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de trigger para gestion de solicitudes de adopcion
PROMPT ========================================================
PROMPT Creación del triger para la gestion de solicitudes de adopcion
PROMPT s-11-gestion-solicitud-mascota-trigger.sql
PROMPT ========================================================
SET SERVEROUTPUT OFF

CREATE OR REPLACE TRIGGER solicitud_mascota_trigger
  FOR INSERT OR UPDATE ON cliente_mascota_solicitud
  COMPOUND TRIGGER
  v_mascota_id NUMBER;
  v_status_mascota NUMBER;
  v_status_solicitud NUMBER;
  v_count_solicitudes NUMBER;
  v_fecha_primera_solicitud DATE;
  v_fecha_status DATE;
  v_solicitud_aprobada BOOLEAN:= FALSE;

  v_codigo NUMBER;

  BEFORE EACH ROW IS
  BEGIN
    v_mascota_id := :new.mascota_id;
    v_fecha_status := :new.fecha_status;
    v_status_solicitud := :new.status_solicitud_id;
    CASE
      WHEN inserting THEN
        SELECT COUNT(*) INTO v_count_solicitudes
        FROM cliente_mascota_solicitud
        WHERE mascota_id = v_mascota_id AND
          status_solicitud_id = 1 AND
          cliente_id = :new.cliente_id;
          
        IF v_count_solicitudes > 0 THEN
          RAISE_APPLICATION_ERROR(-20006, 'Ya existe una solicitud de adopcion para la mascota');
        END IF;

        SELECT status_mascota_id INTO v_status_mascota
        FROM mascota
        WHERE mascota_id = v_mascota_id;

        IF v_status_mascota NOT IN (2, 3) THEN
          RAISE_APPLICATION_ERROR(-20003, 'La mascota no puede ser adoptada');
        END IF;

        IF v_status_solicitud != 1 THEN
          RAISE_APPLICATION_ERROR(-20004, 'Status invalido para registro de solicitud');
        END IF;

        IF v_status_mascota = 2 THEN
          UPDATE mascota
          SET status_mascota_id = 3,
            fecha_status = :new.fecha_status
          WHERE mascota_id = v_mascota_id;
        ELSIF v_status_mascota = 3 THEN
          SELECT fecha_status INTO v_fecha_primera_solicitud
          FROM cliente_mascota_solicitud
          WHERE mascota_id = v_mascota_id AND
            status_solicitud_id = 1
          ORDER BY fecha_status ASC
          FETCH FIRST 1 ROWS ONLY;

          IF :new.fecha_status > v_fecha_primera_solicitud + 15 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Solicitud de adopcion fuera de tiempo');
          END IF;
        END IF;

        :new.comentario := 'Se registro la solicitud de adopcion';
        DBMS_OUTPUT.PUT_LINE('Se registro la solicitud de adopcion (' || :new.cliente_mascota_solicitud_id || ') para la mascota: ' 
          || v_mascota_id);

      WHEN updating THEN
        IF v_status_solicitud = 2 THEN
          :new.comentario := 'Se aprobo la solicitud de adopcion';
          DBMS_OUTPUT.PUT_LINE('Se aprobo la solicitud de adopcion (' || :new.cliente_mascota_solicitud_id || ') para la mascota (' 
          || v_mascota_id || ') del cliente: ' || :new.cliente_id);

          UPDATE mascota
          SET status_mascota_id = 4,
            fecha_status = :new.fecha_status
          WHERE mascota_id = v_mascota_id;
          v_solicitud_aprobada := TRUE;
        ELSIF v_status_solicitud = 3 THEN
          IF :new.comentario IS NULL THEN
            :new.comentario := 'La mascota ha sido adoptada por otro cliente. Más adelante se le notificará el motivo';
          END IF;
          DBMS_OUTPUT.PUT_LINE('Se rechazo la solicitud de adopcion (' || :new.cliente_mascota_solicitud_id || ') para la mascota (' 
            || v_mascota_id || ') del cliente: ' || :new.cliente_id);
        END IF;

    END CASE;
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
    v_clinica_id NUMBER;

    v_count_solicitudes_activas NUMBER;
  BEGIN
    IF v_solicitud_aprobada THEN
      -- primera revision
      SELECT clinica_id INTO v_clinica_id
      FROM clinica
      ORDER BY DBMS_RANDOM.VALUE
      FETCH FIRST 1 ROWS ONLY;

      INSERT INTO revision (mascota_id, numero_revision, costo, observacion, fecha, calificacion, clinica_id)
      VALUES (v_mascota_id, 1, 0, 'Primera revision', v_fecha_status, 10, v_clinica_id);

      UPDATE cliente_mascota_solicitud
      SET status_solicitud_id = 3,
        comentario = 'La mascota ha sido adoptada por otro cliente. Más adelante se le notificará el motivo',
        fecha_status = v_fecha_status
      WHERE mascota_id = v_mascota_id AND
        status_solicitud_id = 1;
    END IF;

    SELECT COUNT(*) INTO v_count_solicitudes_activas
    FROM cliente_mascota_solicitud
    WHERE mascota_id = v_mascota_id AND
      status_solicitud_id IN (1, 2);

    IF v_count_solicitudes_activas = 0 THEN
      UPDATE mascota
      SET status_mascota_id = 2,
        fecha_status = v_fecha_status
      WHERE mascota_id = v_mascota_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END AFTER STATEMENT;
END solicitud_mascota_trigger;
/
SHOW ERRORS;