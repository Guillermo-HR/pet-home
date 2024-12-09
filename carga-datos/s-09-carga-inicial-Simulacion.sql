--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Simular cambio de status, revisiones, consultas, solicitudes
PROMPT ========================================================

SET SERVEROUTPUT ON
CREATE OR REPLACE VIEW simulacion_mascota (
  mascota_id, fecha_status, status_mascota_id, fecha_monitoreo, fecha_revision
) AS
  SELECT m.mascota_id mascota_id, m.fecha_status, m.status_mascota_id, MAX(mc.fecha) fecha_monitoreo, MAX(r.fecha) fecha_revision
  FROM mascota m, monitoreo_cautiverio mc, revision r
  WHERE m.mascota_id = mc.mascota_id AND
    m.mascota_id = r.mascota_id(+) AND
    m.status_mascota_id IN (1, 2, 3, 4, 5)
  GROUP BY m.mascota_id, m.fecha_status, m.status_mascota_id
  ORDER BY m.mascota_id;

CREATE OR REPLACE VIEW simulacion_solicitudes (
  mascota_id, fecha
) AS
  SELECT mascota_id, MIN(fecha_status) fecha
  FROM cliente_mascota_solicitud 
  WHERE status_solicitud_id = 1
  GROUP BY mascota_id;


DECLARE
v_fecha_actual_simulacion DATE;

BEGIN
  SELECT (MIN(fecha_status) - 1) INTO v_fecha_actual_simulacion
  FROM simulacion_mascota;
  WHILE v_fecha_actual_simulacion < SYSDATE LOOP
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Fecha simulación: ' || v_fecha_actual_simulacion);

    -- Hacer monitoreos periodicos a las mascotas (la mascota esta en el refugio)
    DECLARE
      CURSOR cur_revision IS
        SELECT mascota_id
        FROM simulacion_mascota
        WHERE (fecha_monitoreo + 30 * 6) <= v_fecha_actual_simulacion AND
          status_mascota_id NOT IN (4);
      v_veterinario_id monitoreo_cautiverio.veterinario_id%TYPE;
    BEGIN
      SELECT empleado_id INTO v_veterinario_id
      FROM empleado
      WHERE es_veterinario = 1
      ORDER BY DBMS_RANDOM.VALUE
      FETCH FIRST 1 ROWS ONLY;
      FOR c in cur_revision LOOP
        DBMS_OUTPUT.PUT_LINE('Monitoreo a mascota: ' || c.mascota_id);
        INSERT INTO monitoreo_cautiverio (monitoreo_cautiverio_id, fecha, diagnostico, foto, mascota_id, veterinario_id)
        VALUES (monitoreo_cautiverio_seq.NEXTVAL, v_fecha_actual_simulacion, 'Ok', EMPTY_BLOB(), c.mascota_id, v_veterinario_id);
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    -- Hacer revisiones periodicos a las mascotas (la mascota ya fue adoptada)
    DECLARE
      CURSOR cur_revision IS
        SELECT mascota_id
        FROM simulacion_mascota
        WHERE (fecha_revision + 30 * 6) <= v_fecha_actual_simulacion AND
          status_mascota_id = 4;
      v_clinica_id revision.clinica_id%TYPE;
      v_costo revision.costo%TYPE;
      v_calificacion revision.calificacion%TYPE;
    BEGIN
      SELECT clinica_id INTO v_clinica_id
      FROM clinica
      ORDER BY DBMS_RANDOM.VALUE
      FETCH FIRST 1 ROWS ONLY;
      v_costo := ROUND(DBMS_RANDOM.VALUE(100, 1000), 2);
      v_calificacion := TRUNC(DBMS_RANDOM.VALUE(1, 11));
      FOR c in cur_revision LOOP
        INSERT INTO revision (mascota_id, numero_revision, costo, observacion, fecha, calificacion, clinica_id)
        VALUES (c.mascota_id, generar_n_revision(c.mascota_id), v_costo, 'Ok', v_fecha_actual_simulacion, v_calificacion, v_clinica_id);
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    -- Aprobar/Rechazar solicitudes
    DECLARE
      CURSOR cur_mascotas IS
        SELECT mascota_id
        FROM simulacion_solicitudes
        WHERE (fecha + 15) < v_fecha_actual_simulacion;
    BEGIN
      FOR c_m IN cur_mascotas LOOP
        DECLARE
          CURSOR cur_clientes IS
            SELECT cliente_id
            FROM cliente_mascota_solicitud
            WHERE mascota_id = c_m.mascota_id AND
              status_solicitud_id = 1
            ORDER BY DBMS_RANDOM.VALUE;
          v_aceptado NUMBER;
        BEGIN
          FOR c_c IN cur_clientes LOOP
            v_aceptado := DBMS_RANDOM.VALUE(0, 1) * 100;
            IF v_aceptado < 35 THEN
              UPDATE cliente_mascota_solicitud
              SET status_solicitud_id = 2
              WHERE mascota_id = c_m.mascota_id AND
                cliente_id = c_c.cliente_id;
              EXIT;
            END IF;
          END LOOP;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    -- Realizar solicitud
    DECLARE
      CURSOR cur_mascota IS
        SELECT mascota_id
        FROM simulacion_mascota
        WHERE status_mascota_id = 2;
      v_cliente_id cliente_mascota_solicitud.cliente_id%TYPE;
      v_solicitar NUMBER;
    BEGIN
      FOR c in cur_mascota LOOP
        v_solicitar := DBMS_RANDOM.VALUE(0, 1) * 100;
        IF v_solicitar < 40 THEN
          SELECT cliente_id INTO v_cliente_id
          FROM cliente
          ORDER BY DBMS_RANDOM.VALUE
          FETCH FIRST 1 ROWS ONLY;
          INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, fecha_status, mascota_id, cliente_id, status_solicitud_id)
          VALUES (cliente_mascota_solicitud_seq.NEXTVAL, v_fecha_actual_simulacion, c.mascota_id, v_cliente_id, 1);
        END IF;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    -- Cambiar status de las mascotas
    DECLARE 
      CURSOR cur_mascota IS
        SELECT mascota_id, status_mascota_id
        FROM simulacion_mascota;
      v_status NUMBER;
    BEGIN
      FOR c iN cur_mascota LOOP
        v_status := DBMS_RANDOM.VALUE(0, 1) * 100;
          IF c.status_mascota_id = 1 THEN
            IF v_status < 55 THEN
              UPDATE mascota
              SET status_mascota_id = 2
              WHERE mascota_id = c.mascota_id;
            ELSIF v_status < 65 THEN
              UPDATE mascota
              SET status_mascota_id = 1
              WHERE mascota_id = c.mascota_id;
            ELSIF v_status < 70 THEN
              UPDATE mascota
              SET status_mascota_id = 1
              WHERE mascota_id = c.mascota_id;
            END IF;
          ELSIF c.status_mascota_id = 2 THEN
            IF v_status < 10 THEN
              UPDATE mascota
              SET status_mascota_id = 2
              WHERE mascota_id = c.mascota_id;
            ELSIF v_status < 15 THEN
              UPDATE mascota
              SET status_mascota_id = 2
              WHERE mascota_id = c.mascota_id;
            END IF;
          ELSIF c.status_mascota_id = 3 THEN
            IF v_status < 20 THEN
              UPDATE mascota
              SET status_mascota_id = 3
              WHERE mascota_id = c.mascota_id;
            ELSIF v_status < 25 THEN
              UPDATE mascota
              SET status_mascota_id = 3
              WHERE mascota_id = c.mascota_id;
            END IF;
          ELSIF c.status_mascota_id = 4 THEN
            IF v_status < 5 THEN
              UPDATE mascota
              SET status_mascota_id = 4
              WHERE mascota_id = c.mascota_id;
            END IF;
          ELSIF c.status_mascota_id = 5 THEN
            IF v_status < 75 THEN
              UPDATE mascota
              SET status_mascota_id = 1
              WHERE mascota_id = c.mascota_id;
            ELSIF v_status < 80 THEN
              UPDATE mascota
              SET status_mascota_id = 5
              WHERE mascota_id = c.mascota_id;
            END IF;
          END IF;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    
    v_fecha_actual_simulacion := v_fecha_actual_simulacion + DBMS_RANDOM.VALUE(20, 40);
    COMMIT;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Se terminó la simulación');
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

-- Elimitar vistas
--DROP VIEW simulacion_mascota;
--DROP VIEW simulacion_solicitudes;
--COMMIT;