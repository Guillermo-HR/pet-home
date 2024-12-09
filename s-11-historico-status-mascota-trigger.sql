--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de trigger para el historico de status mascota
PROMPT ========================================================
PROMPT Creación del triger para el historico de status mascota
PROMPT s-11-historico-status-mascota-trigger.sql
PROMPT ========================================================

CREATE OR REPLACE TRIGGER historico_status_macota_trigger
  AFTER INSERT OR UPDATE OF status_mascota_id ON mascota
  FOR EACH ROW
  DECLARE
  v_fecha_status     mascota.fecha_status%type;
  v_status_id  mascota.status_mascota_id%type;
  v_mascota_id       mascota.mascota_id%type;
  v_folio            mascota.folio%type;
  v_veterinario_id   monitoreo_cautiverio.veterinario_id%type;

  BEGIN
    v_fecha_status := :new.fecha_status;
    v_status_id := :new.status_mascota_id;
    v_mascota_id := :new.mascota_id;
    v_folio := :new.folio;

    CASE
      WHEN inserting THEN
          DBMS_OUTPUT.PUT_LINE('Se registro la mascota con mascota_id: ' || v_mascota_id);

          SELECT empleado_id INTO v_veterinario_id
          FROM empleado
          WHERE es_veterinario = 1
          ORDER BY dbms_random.value
          FETCH FIRST 1 ROWS ONLY;

          INSERT INTO monitoreo_cautiverio (monitoreo_cautiverio_id, fecha, diagnostico, foto, mascota_id, veterinario_id)
          VALUES (monitoreo_cautiverio_seq.NEXTVAL, v_fecha_status, 'Mascota recibida en el centro de adopcion', 
            EMPTY_BLOB(), v_mascota_id, v_veterinario_id);
      WHEN updating('status_mascota_id') THEN
        IF v_status_id = :old.status_mascota_id THEN
          RAISE_APPLICATION_ERROR(-20007, 'El status de la mascota no ha cambiado');
        END IF;

        IF :old.status_mascota_id IN (6, 7) THEN
          RAISE_APPLICATION_ERROR(-20008, 'No se puede cambiar el status de la mascota');
        END IF;
        IF v_status_id = 5 THEN
          UPDATE cliente_mascota_solicitud
          SET comentario = 'La mascota esta enferma, se cancela el proceso de adopcion'
          WHERE mascota_id = v_mascota_id AND
          status_solicitud_id = 1;

          UPDATE cliente_mascota_solicitud
          SET status_solicitud_id = 3
          WHERE mascota_id = v_mascota_id AND
          status_solicitud_id = 1;
        END IF;
        IF v_status_id = 6 THEN
          UPDATE cliente_mascota_solicitud
          SET comentario = 'La mascota fallecio, se cancela el proceso de adopcion'
          WHERE mascota_id = v_mascota_id AND
          status_solicitud_id = 1;

          UPDATE cliente_mascota_solicitud
          SET status_solicitud_id = 3
          WHERE mascota_id = v_mascota_id AND
          status_solicitud_id = 1;
        END IF;
    END CASE;
    
    INSERT INTO historico_status_mascota (historico_status_mascota_id, fecha_status, status_mascota_id, mascota_id)
    VALUES (historico_status_mascota_seq.NEXTVAL, v_fecha_status, v_status_id, v_mascota_id);
    DBMS_OUTPUT.PUT_LINE('Se registro el status (' || v_status_id || ') con historico_status_mascota_id: ' || 
      historico_status_mascota_seq.CURrval || ' para la mascota: ' || v_mascota_id);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END;
/
SHOW ERRORS;