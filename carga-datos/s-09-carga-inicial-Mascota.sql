--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos mascota
PROMPT ========================================================

CREATE TABLE nombres_perros(
  id NUMBER,
  nombre VARCHAR2(15)
);

CREATE TABLE nombres_gatos(
  id NUMBER,
  nombre VARCHAR2(15)
);

INSERT INTO nombres_perros VALUES (1, 'Firulais');
INSERT INTO nombres_perros VALUES (2, 'Rex');
INSERT INTO nombres_perros VALUES (3, 'Boby');
INSERT INTO nombres_perros VALUES (4, 'Max');
INSERT INTO nombres_perros VALUES (5, 'Rocky');
INSERT INTO nombres_perros VALUES (6, 'Bruno');
INSERT INTO nombres_perros VALUES (7, 'Lucky');
INSERT INTO nombres_perros VALUES (8, 'Sultan');
INSERT INTO nombres_perros VALUES (9, 'Duke');
INSERT INTO nombres_perros VALUES (10, 'Ringo');
INSERT INTO nombres_perros VALUES (11, 'Rusty');
INSERT INTO nombres_perros VALUES (12, 'Rufus');
INSERT INTO nombres_perros VALUES (13, 'Rocco');
INSERT INTO nombres_perros VALUES (14, 'Bonnie');
INSERT INTO nombres_perros VALUES (15, 'Bella');

INSERT INTO nombres_gatos VALUES (1, 'Mishifu');
INSERT INTO nombres_gatos VALUES (2, 'Garfield');
INSERT INTO nombres_gatos VALUES (3, 'Tom');
INSERT INTO nombres_gatos VALUES (4, 'Felix');
INSERT INTO nombres_gatos VALUES (5, 'Whiskers');
INSERT INTO nombres_gatos VALUES (6, 'Salem');
INSERT INTO nombres_gatos VALUES (7, 'Simba');
INSERT INTO nombres_gatos VALUES (8, 'Nala');
INSERT INTO nombres_gatos VALUES (9, 'Luna');
INSERT INTO nombres_gatos VALUES (10, 'Milo');
INSERT INTO nombres_gatos VALUES (11, 'Oliver');
INSERT INTO nombres_gatos VALUES (12, 'Charlie');
INSERT INTO nombres_gatos VALUES (13, 'Lucy');
INSERT INTO nombres_gatos VALUES (14, 'Chloe');
INSERT INTO nombres_gatos VALUES (15, 'Ginger');

DECLARE
  v_n_perros_donados NUMBER := 25;
  v_n_perros_abandonados NUMBER := 15;
  v_n_perros_nacidos NUMBER := 10;
  v_n_gatos_donados NUMBER := 10;
  v_n_gatos_abandonados NUMBER := 15;
  v_n_gatos_nacidos NUMBER := 5;
  
  v_index_loop NUMBER;
  v_id_contador NUMBER := 1;
  
  v_fecha_ingreso DATE;
  v_fecha_nacimiento DATE;
  v_nombre VARCHAR2(15);
  v_mascota_tipo_id NUMBER;
  v_refugio_id NUMBER;
  v_cliente_donador_id NUMBER;
  v_padre_id NUMBER;
  v_madre_id NUMBER;
  v_refugio_nacimiento_id NUMBER;
  v_folio VARCHAR2(8);
  
  v_sql VARCHAR2(4000);

BEGIN
  -- Perros donados
  FOR v_index_loop IN 1 .. v_n_perros_donados LOOP
    v_fecha_ingreso := TO_DATE('01-01-2002', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2022', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM NOMBRES_PERROS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(1, 23));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    v_cliente_donador_id := TRUNC(DBMS_RANDOM.VALUE(1, 27));
    SELECT generar_folio(v_mascota_tipo_id, v_refugio_id, 1) INTO v_folio FROM dual;
    
    v_sql := 'INSERT INTO mascota (fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, ' ||
    'mascota_tipo_id, status_mascota_id, refugio_id, origen_id, cliente_donador_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10)';

    EXECUTE IMMEDIATE v_sql USING v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, 
      v_folio, v_mascota_tipo_id, 1, v_refugio_id, 1, v_cliente_donador_id;
  END LOOP;

  -- Perros abandonados
  FOR v_index_loop IN 1 .. v_n_perros_abandonados LOOP
    v_fecha_ingreso := TO_DATE('01-01-2002', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2022', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM NOMBRES_PERROS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(1, 23));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    SELECT generar_folio(v_mascota_tipo_id, v_refugio_id, 1) INTO v_folio FROM dual;

    v_sql := 'INSERT INTO mascota (fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio' ||
    'mascota_tipo_id, status_mascota_id, refugio_id, origen_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9)';

    EXECUTE IMMEDIATE v_sql USING v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, 
      v_folio, v_mascota_tipo_id, 1, v_refugio_id, 2;
  END LOOP;

  -- Perros nacidos en el refugio
  FOR v_index_loop IN 1 .. v_n_perros_nacidos LOOP
    v_fecha_ingreso := TO_DATE('01-01-2002', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2022', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM NOMBRES_PERROS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(1, 23));
    v_padre_id := TRUNC(DBMS_RANDOM.VALUE(1, (v_n_perros_donados + v_n_perros_abandonados)));
    v_madre_id := TRUNC(DBMS_RANDOM.VALUE(1, (v_n_perros_donados + v_n_perros_abandonados)));
    WHILE v_padre_id = v_madre_id LOOP
      v_madre_id := TRUNC(DBMS_RANDOM.VALUE(1, (v_n_perros_donados + v_n_perros_abandonados)));
    END LOOP;
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    v_refugio_nacimiento_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    SELECT generar_folio(v_mascota_tipo_id, v_refugio_id, 1) INTO v_folio FROM dual;

    v_sql := 'INSERT INTO mascota (fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, ' ||
    'mascota_tipo_id, status_mascota_id, padre_id, madre_id, refugio_id, refugio_nacimiento_id, origen_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12)';

    EXECUTE IMMEDIATE v_sql USING v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, 
      v_folio, v_mascota_tipo_id, 1, v_padre_id, v_madre_id, v_refugio_id, v_refugio_nacimiento_id, 3;
  END LOOP;

  -- Gatos donados
  FOR v_index_loop IN 1 .. v_n_gatos_donados LOOP
    v_fecha_ingreso := TO_DATE('01-01-2002', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2022', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM NOMBRES_GATOS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(24, 29));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    v_cliente_donador_id := TRUNC(DBMS_RANDOM.VALUE(1, 27));
    SELECT generar_folio(v_mascota_tipo_id, v_refugio_id, 1) INTO v_folio FROM dual;

    v_sql := 'INSERT INTO mascota (fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, ' ||
    'mascota_tipo_id, status_mascota_id, refugio_id, origen_id, cliente_donador_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10)';
    
    EXECUTE IMMEDIATE v_sql USING v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, 
      folio, v_mascota_tipo_id, 1, v_refugio_id, 1, v_cliente_donador_id;
  END LOOP;

  -- Gatos abandonados
  FOR v_index_loop IN 1 .. v_n_gatos_abandonados LOOP
    v_fecha_ingreso := TO_DATE('01-01-2002', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2022', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM NOMBRES_GATOS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(24, 29));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    SELECT generar_folio(v_mascota_tipo_id, v_refugio_id, 1) INTO v_folio FROM dual;

    v_sql := 'INSERT INTO mascota (fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, ' ||
    'mascota_tipo_id, status_mascota_id, refugio_id, origen_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9)';

    EXECUTE IMMEDIATE v_sql USING v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, 
      v_folio, v_mascota_tipo_id, 1, v_refugio_id, 2;
  END LOOP;

  -- Gatos nacidos en el refugio
  FOR v_index_loop IN 1 .. v_n_gatos_nacidos LOOP
    v_fecha_ingreso := TO_DATE('01-01-2002', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2022', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM NOMBRES_GATOS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(24, 29));
    v_padre_id := TRUNC(DBMS_RANDOM.VALUE((v_n_perros_donados + v_n_perros_abandonados + v_n_perros_nacidos + 1), 
      v_n_gatos_donados + v_n_gatos_abandonados));
    v_madre_id := TRUNC(DBMS_RANDOM.VALUE((v_n_perros_donados + v_n_perros_abandonados + v_n_perros_nacidos + 1), 
      v_n_gatos_donados + v_n_gatos_abandonados));
    WHILE v_padre_id = v_madre_id LOOP
      v_madre_id := TRUNC(DBMS_RANDOM.VALUE((v_n_perros_donados + v_n_perros_abandonados + v_n_perros_nacidos + 1), 
        v_n_gatos_donados + v_n_gatos_abandonados));
    END LOOP;
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    v_refugio_nacimiento_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
    SELECT generar_folio(v_mascota_tipo_id, v_refugio_id, 1) INTO v_folio FROM dual;

    v_sql := 'INSERT INTO mascota (fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, ' ||
    'mascota_tipo_id, status_mascota_id, padre_id, madre_id, refugio_id, refugio_nacimiento_id, origen_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11)';

    EXECUTE IMMEDIATE v_sql USING v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, 
      v_folio, v_mascota_tipo_id, 1, v_padre_id, v_madre_id, v_refugio_id, v_refugio_nacimiento_id, 3;
  END LOOP;
END;
/

DROP TABLE nombres_perros;
DROP TABLE nombres_gatos;

COMMIT;