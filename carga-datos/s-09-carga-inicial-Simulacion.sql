--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Simular cambio de status, revisiones, consultas, solicitudes
PROMPT ========================================================

SET SERVEROUTPUT OFF

DECLARE
v_fecha_actual_simulacion DATE;

BEGIN
  SELECT (MIN(fecha_status) + 10) INTO v_fecha_actual_simulacion
  FROM mascota;

  WHILE v_fecha_actual_simulacion < SYSDATE LOOP
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Fecha simulación: ' || v_fecha_actual_simulacion);


    -- Hacer monitoreos periodicos a las mascotas (la mascota esta en el refugio)
    DECLARE
      CURSOR cur_revision IS
        SELECT mc.mascota_id, MAX(mc.fecha) fecha_monitoreo
        FROM mascota m, monitoreo_cautiverio mc
        WHERE m.mascota_id = mc.mascota_id AND
          m.status_mascota_id IN (1, 2, 3, 5)
        GROUP BY mc.mascota_id
        HAVING (fecha_monitoreo + 30 * 6) <= v_fecha_actual_simulacion;
      v_veterinario_id monitoreo_cautiverio.veterinario_id%TYPE;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('--> Monitoreo: ');
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
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!!!!Error en monitoreo');
        DBMS_OUTPUT.PUT_LINE('Codigo de error: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Mensaje de error: ' || SQLERRM);
    END;

    -- Hacer revisiones a las mascotas (la mascota ya fue adoptada)
    DECLARE
      CURSOR cur_revision IS
        SELECT r.mascota_id
        FROM revision r, mascota m
        WHERE r.mascota_id = m.mascota_id AND
          m.status_mascota_id = 4
        GROUP BY r.mascota_id
        HAVING (MAX(r.fecha) + 30 * 6) <= v_fecha_actual_simulacion;
      v_clinica_id revision.clinica_id%TYPE;
      v_costo revision.costo%TYPE;
      v_calificacion revision.calificacion%TYPE;
      v_n_revisione revision.numero_revision%TYPE;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('--> Revision: ');
      FOR c_r IN cur_revision LOOP
        DBMS_OUTPUT.PUT_LINE('Revision a mascota: ' || c_r.mascota_id);
        SELECT clinica_id INTO v_clinica_id
        FROM clinica
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 1 ROWS ONLY;

        v_costo := ROUND(DBMS_RANDOM.VALUE(100, 1000), 2);
        v_calificacion := TRUNC(DBMS_RANDOM.VALUE(1, 11));
        v_n_revisione := generar_n_revision(c_r.mascota_id);

        INSERT INTO revision (mascota_id, numero_revision, costo, observacion, fecha, calificacion, clinica_id)
        VALUES (c_r.mascota_id, v_n_revisione, v_costo, 'Ok', v_fecha_actual_simulacion, v_calificacion, v_clinica_id);
      END LOOP;
    EXCEPTION
      WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('!!!!!Error en revision');
        DBMS_OUTPUT.PUT_LINE('Codigo de error: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Mensaje de error: ' || SQLERRM);
    END;

    -- Aprobar/Rechazar solicitudes
    DECLARE
      CURSOR cur_mascota IS
        SELECT mascota_id
        FROM cliente_mascota_solicitud
        WHERE status_solicitud_id = 1
        GROUP BY mascota_id
        HAVING (MIN(fecha_status) + 15) < v_fecha_actual_simulacion;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('--> Acepar/Rechazar solicitudes: ');
      FOR c_s IN cur_mascota LOOP
        DBMS_OUTPUT.PUT_LINE('Solicitudes para la mascota: ' || c_s.mascota_id);
        DECLARE
          CURSOR cur_solicitud IS
            SELECT cliente_mascota_solicitud_id
            FROM cliente_mascota_solicitud
            WHERE mascota_id = c_s.mascota_id AND
              status_solicitud_id = 1
            ORDER BY DBMS_RANDOM.VALUE;
          v_aceptar NUMBER;
        BEGIN
          FOR c_s IN cur_solicitud LOOP
            v_aceptar := DBMS_RANDOM.VALUE(0, 1) * 100;
            IF v_aceptar < 35 THEN
              UPDATE cliente_mascota_solicitud
              SET status_solicitud_id = 2,
                fecha_status = v_fecha_actual_simulacion
              WHERE cliente_mascota_solicitud_id = c_s.cliente_mascota_solicitud_id;
              EXIT;
            ELSE 
              UPDATE cliente_mascota_solicitud
              SET status_solicitud_id = 3,
                fecha_status = v_fecha_actual_simulacion
              WHERE cliente_mascota_solicitud_id = c_s.cliente_mascota_solicitud_id;
            END IF;
          END LOOP;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
      END LOOP;
    EXCEPTION
     WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!!!!Error en aceptar/rechazar solicitud');
        DBMS_OUTPUT.PUT_LINE('Codigo de error: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Mensaje de error: ' || SQLERRM);
    END;

    -- Realizar solicitud
    DECLARE
      CURSOR cur_mascota IS
        SELECT mascota_id 
        FROM mascota
        WHERE status_mascota_id IN (2, 3)
        ORDER BY DBMS_RANDOM.VALUE;

      v_solicitar NUMBER;
      v_n_solicitudes NUMBER;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('--> Solicitar mascotas: ');
      FOR c_m in cur_mascota LOOP
        v_solicitar := DBMS_RANDOM.VALUE(0, 1) * 100;
        IF v_solicitar < 70 THEN
          v_n_solicitudes := TRUNC(DBMS_RANDOM.VALUE(3, 5));
          DBMS_OUTPUT.PUT_LINE('Se hicieron: ' || v_n_solicitudes || ' solicitudes para la mascota: ' || c_m.mascota_id);
          DECLARE
            CURSOR cur_clientes IS
              SELECT cliente_id
              FROM cliente
              ORDER BY DBMS_RANDOM.VALUE
              FETCH FIRST v_n_solicitudes ROWS ONLY;
      
              v_cliente_id cliente_mascota_solicitud.cliente_id%TYPE;
          BEGIN
            FOR c_c IN cur_clientes LOOP
              v_cliente_id := c_c.cliente_id;
              INSERT INTO cliente_mascota_solicitud (cliente_mascota_solicitud_id, fecha_status, mascota_id, cliente_id, status_solicitud_id)
              VALUES (cliente_mascota_solicitud_seq.NEXTVAL, v_fecha_actual_simulacion, c_m.mascota_id, c_c.cliente_id, 1);
            END LOOP;
          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;
        END IF;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!!!!Error en solicitud');
        DBMS_OUTPUT.PUT_LINE('Codigo de error: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Mensaje de error: ' || SQLERRM);
    END;

    -- Registrar hijos
    DECLARE
      CURSOR cur_mascota IS
        SELECT mascota_id
        FROM mascota
        WHERE status_mascota_id IN (1)
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 1 ROWS ONLY;
      v_n_hijos NUMBER;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('--> Registrar hijos: ');
      FOR c_m IN cur_mascota LOOP
        v_n_hijos := TRUNC(DBMS_RANDOM.VALUE(0, 3));
        DBMS_OUTPUT.PUT_LINE('Se registraron: ' || v_n_hijos || ' hijos para la mascota: ' || c_m.mascota_id);
        agregar_hijos(null, c_m.mascota_id, v_n_hijos, v_fecha_actual_simulacion);
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!!!!Error en registro de hijos');
        DBMS_OUTPUT.PUT_LINE('Codigo de error: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Mensaje de error: ' || SQLERRM);
    END;

    -- Cambiar status de mascotas
    DECLARE
      CURSOR cur_mascota IS
        SELECT mascota_id, status_mascota_id
        FROM mascota
        WHERE status_mascota_id IN (1, 2, 3, 4, 5) AND
          fecha_status < v_fecha_actual_simulacion
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 25 ROWS ONLY;
      v_status NUMBER;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('--> Cambiar status de mascotas: ');
      FOR c_m iN cur_mascota LOOP
        v_status := DBMS_RANDOM.VALUE(0, 1) * 100;
          IF c_m.status_mascota_id = 1 THEN
            IF v_status < 40 THEN
              UPDATE mascota
              SET status_mascota_id = 2,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSIF v_status < 50 THEN
              UPDATE mascota
              SET status_mascota_id = 5,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSIF v_status < 52 THEN
              UPDATE mascota
              SET status_mascota_id = 6,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSE
              DBMS_OUTPUT.PUT_LINE('No se cambió el status de la mascota: ' || c_m.mascota_id);
            END IF;
          ELSIF c_m.status_mascota_id = 2 THEN
            IF v_status < 10 THEN
              UPDATE mascota
              SET status_mascota_id = 5,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSIF v_status < 12 THEN
              UPDATE mascota
              SET status_mascota_id = 6,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSE
              DBMS_OUTPUT.PUT_LINE('No se cambió el status de la mascota: ' || c_m.mascota_id);
            END IF;
          ELSIF c_m.status_mascota_id = 3 THEN
            IF v_status < 10 THEN
              UPDATE mascota
              SET status_mascota_id = 5,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSIF v_status < 12 THEN
              UPDATE mascota
              SET status_mascota_id = 6,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSE
              DBMS_OUTPUT.PUT_LINE('No se cambió el status de la mascota: ' || c_m.mascota_id);
            END IF;
          ELSIF c_m.status_mascota_id = 4 THEN
            IF v_status < 2 THEN
              UPDATE mascota
              SET status_mascota_id = 7,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSE
              DBMS_OUTPUT.PUT_LINE('No se cambió el status de la mascota: ' || c_m.mascota_id);
            END IF;
          ELSIF c_m.status_mascota_id = 5 THEN
            IF v_status < 70 THEN
              UPDATE mascota
              SET status_mascota_id = 1,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSIF v_status < 75 THEN
              UPDATE mascota
              SET status_mascota_id = 6,
                fecha_status = v_fecha_actual_simulacion
              WHERE mascota_id = c_m.mascota_id;
            ELSE
              DBMS_OUTPUT.PUT_LINE('No se cambió el status de la mascota: ' || c_m.mascota_id);
            END IF;
          END IF;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    v_fecha_actual_simulacion := v_fecha_actual_simulacion + DBMS_RANDOM.VALUE(20, 40);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Se terminó la simulación');
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

COMMIT;
SET SERVEROUTPUT ON