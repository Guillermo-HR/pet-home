--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de trigger para gestion de solicitudes de adopcion
PROMPT ========================================================
PROMPT Creación del triger para la gestion de solicitudes de adopcion
PROMPT s-11-gestion-solicitud-mascota-trigger.sql
PROMPT ========================================================

CREATE OR REPLACE TRIGGER solicitud_mascota_trigger
  BEFORE INSERT OR UPDATE OF status_solicitud_id ON cliente_mascota_solicitud
  FOR EACH ROW
  DECLARE
  v_n_mascotas_actuales NUMBER;
  v_mascota_id mascota.mascota_id%type;
  v_status_mascota mascota.status_mascota_id%type;
  v_status_solicitud cliente_mascota_solicitud.status_solicitud_id%type;
  v_count_solicitudes NUMBER;
  v_fecha_primera_solicitud DATE;

  v_codigo NUMBER;

  BEGIN
    v_mascota_id := :new.mascota_id;
    v_status_solicitud := :new.status_solicitud_id;

    SELECT COUNT(*) INTO v_n_mascotas_actuales
    FROM mascota m, cliente_mascota_solicitud cms
    WHERE m.mascota_id = cms.mascota_id AND
      cms.cliente_id = :new.cliente_id AND
      cms.status_solicitud_id = 2 AND
      m.status_mascota_id = 4;

    CASE
      WHEN inserting THEN
        SELECT COUNT(*) INTO v_count_solicitudes
        FROM cliente_mascota_solicitud
        WHERE mascota_id = v_mascota_id AND
          status_solicitud_id = 1;

        IF v_count_solicitudes = 1 THEN
          RAISE_APPLICATION_ERROR(-20006, 'Ya existe una solicitud de adopcion para la mascota');
        END IF;
        
        IF v_n_mascotas_actuales = 5 THEN
          RAISE_APPLICATION_ERROR(-20002, 'No se pueden realizar la solicitud de adopcion');
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
          SET status_mascota_id = 3
          WHERE mascota_id = v_mascota_id;
        ELSIF v_status_mascota = 3 THEN
          SELECT fecha_status INTO v_fecha_primera_solicitud
          FROM cliente_mascota_solicitud
          WHERE mascota_id = v_mascota_id AND
            status_solicitud_id = 1 AND
            ROWNUM = 1
          ORDER BY fecha_status ASC;

          IF :new.fecha_status > v_fecha_primera_solicitud + 15 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Solicitud de adopcion fuera de tiempo');
          END IF;
        END IF;

        :new.comentario := 'Se registro la solicitud de adopcion';
        DBMS_OUTPUT.PUT_LINE('Se registro la solicitud de adopcion (' || :new.cliente_mascota_solicitud_id || ') para la mascota: ' 
          || v_mascota_id);

      WHEN updating('status_solicitud_id') THEN
        IF v_n_mascotas_actuales > 4 THEN
          UPDATE cliente_mascota_solicitud 
          SET status_solicitud_id = 3,
            comentario = 'El cliente ha alcanzado el limite de mascotas permitidas'
          WHERE cliente_id = :new.cliente_id AND
            status_solicitud_id = 1;
          v_status_solicitud := 3;
          :new.status_solicitud_id := 3;
        END IF;

        IF v_status_solicitud = 2 THEN
          UPDATE cliente_mascota_solicitud
          SET status_solicitud_id = 3,
            comentario = 'La mascota ha sido adoptada por otro cliente. Más adelante se le notificará el motivo'
          WHERE mascota_id = v_mascota_id AND
            status_solicitud_id = 1 AND
            cliente_id != :new.cliente_id;

          :new.comentario := 'Se aprobo la solicitud de adopcion';
          DBMS_OUTPUT.PUT_LINE('Se aprobo la solicitud de adopcion (' || :new.cliente_mascota_solicitud_id || ') para la mascota: ' 
          || v_mascota_id);
        ELSIF v_status_solicitud = 3 THEN
          DBMS_OUTPUT.PUT_LINE('Se rechazo la solicitud de adopcion (' || :new.cliente_mascota_solicitud_id || ') para la mascota: ' 
            || v_mascota_id);
        END IF;
    END CASE;
  EXCEPTION
    WHEN OTHERS THEN
      IF v_codigo NOT IN (-20002, -20003, -20004, -20005, -20006) THEN
        RAISE;
      END IF;
  END;
/
SHOW ERRORS;