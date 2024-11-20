CREATE OR REPLACE TRIGGER historico_status_macota_trigger
  AFTER INSERT OR UPDATE OF status_mascota_id ON mascota
  FOR EACH ROW
  DECLARE
  v_status_mascota_id NUMBER;
  v_status_descripcion VARCHAR2;
  v_mascota_id NUMBER;
  v_mascota_nombre VARCHAR2;
  v_mascota_folio VARCHAR2;
  v_fecha_status DATE;
  BEGIN
    v_status_mascota_id := :new.status_mascota_id;
    SELECT descripcion INTO v_status_descripcion FROM status_mascota WHERE status_mascota_id = :new.status_mascota_id;
    v_mascota_id := :new.mascota_id;
    v_mascota_nombre := :new.nombre;
    v_mascota_folio := :new.folio;
    v_fecha_status := :new.fecha_status;

    DBMS_OUTPUT.PUT_LINE(v_fecha_status || '.- Status actualizado de ' || v_mascota_nombre || '('|| 
    v_mascota_folio|| '): ' || v_status_descripcion);
    DBMS_OUTPUT.PUT_LINE('Agregando a historico');

    INSERT INTO historico_status_mascota(status_mascota_id, mascota_id, fecha_status)
      VALUES(v_status_mascota_id, v_mascota_id, v_fecha_status);
    
    -- Si la mascota fallecio se rechazan las solicitudes pendientes de esa mascota
    IF v_status_mascota_id = 6 OR v_status_mascota_id = 7 THEN
      UPDATE cliente_mascota_solicitud SET 
        status_solicitud_id = 3,
        descripcion_no_ganador = 'Fallecio la mascota'
      WHERE mascota_id = v_mascota_id AND
      status_solicitud_id = 1;
    END IF;
  END;

      