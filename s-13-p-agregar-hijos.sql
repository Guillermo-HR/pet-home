--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Crear el procedimiento para agregar hijos

PROMPT ========================================================
PROMPT Definicion del procedimiento que registra mascotas nacidas en el refugio
PROMPT s-13-p-agregar-hijos.sql
PROMPT ========================================================

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE agregar_hijos(
  p_padre_id IN NUMBER,
  p_madre_id IN NUMBER,
  p_numero_hijos IN NUMBER,
  p_fecha_nacimiento IN DATE DEFAULT SYSDATE
  ) IS
  v_nombre mascota.nombre%TYPE;
  v_folio mascota.folio%TYPE;
  v_mascota_tipo_id mascota.mascota_tipo_id%TYPE;
  v_mascota_tipo mascota_tipo.tipo%TYPE;
  v_refugio_id mascota.refugio_id%TYPE;

  v_loop_counter NUMBER;
BEGIN
  SELECT mascota_tipo_id, refugio_id INTO v_mascota_tipo_id, v_refugio_id
  FROM mascota
  WHERE mascota_id = p_madre_id;

  SELECT tipo INTO v_mascota_tipo
  FROM mascota_tipo
  WHERE mascota_tipo_id = v_mascota_tipo_id;

  FOR v_loop_counter IN 1..p_numero_hijos LOOP
    IF v_mascota_tipo = 'Perro' THEN
      SELECT nombre INTO v_nombre
      FROM (SELECT * FROM nombre_perro ORDER BY DBMS_RANDOM.VALUE)
      WHERE ROWNUM = 1;
    ELSIF v_mascota_tipo = 'Gato' THEN
      SELECT nombre INTO v_nombre
      FROM (SELECT * FROM nombre_gato ORDER BY DBMS_RANDOM.VALUE)
      WHERE ROWNUM = 1;
    END IF;
    v_folio := generar_folio(v_mascota_tipo_id, v_refugio_id, 3);


    INSERT INTO mascota (mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id,
      padre_id, madre_id, refugio_id, refugio_nacimiento_id, origen_id)
    VALUES (mascota_seq.NEXTVAL, p_fecha_nacimiento, p_fecha_nacimiento, p_fecha_nacimiento, v_nombre, v_folio, 
      v_mascota_tipo_id, 1, p_padre_id, p_madre_id, v_refugio_id, v_refugio_id, 3);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Se registraron ' || p_numero_hijos || ' mascotas');
END agregar_hijos;
/
SHOW ERRORS;
