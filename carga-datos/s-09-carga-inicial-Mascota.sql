--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos mascota
PROMPT ========================================================

SET SERVEROUTPUT ON

DECLARE
  v_n_perros_donados NUMBER := 25;
  v_n_perros_abandonados NUMBER := 15;
  v_n_gatos_donados NUMBER := 10;
  v_n_gatos_abandonados NUMBER := 15;
  
  v_index_loop NUMBER;
  v_id_contador NUMBER := 1;
  
  v_mascota_id NUMBER;
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
    v_mascota_id := mascota_seq.NEXTVAL;
    v_fecha_ingreso := TO_DATE('01-01-2021', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2021', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM nombre_perro ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(1, 23));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 4));
    v_cliente_donador_id := TRUNC(DBMS_RANDOM.VALUE(1, 27));
    v_folio := generar_folio(v_mascota_tipo_id, v_refugio_id, 1);
    
    v_sql := 'INSERT INTO mascota (mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id, cliente_donador_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11)';

    EXECUTE IMMEDIATE v_sql USING v_mascota_id, v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, v_folio, v_mascota_tipo_id, 1, v_refugio_id, 1, v_cliente_donador_id;
  END LOOP;

  -- Perros abandonados
  FOR v_index_loop IN 1 .. v_n_perros_abandonados LOOP
    v_mascota_id := mascota_seq.NEXTVAL;
    v_fecha_ingreso := TO_DATE('01-01-2021', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2021', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM nombre_perro ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(1, 23));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 4));
    v_folio := generar_folio(v_mascota_tipo_id, v_refugio_id, 1);

    v_sql := 'INSERT INTO mascota (mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10)';

    EXECUTE IMMEDIATE v_sql USING v_mascota_id, v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, v_folio, v_mascota_tipo_id, 1, v_refugio_id, 2;
  END LOOP;

  -- Gatos donados
  FOR v_index_loop IN 1 .. v_n_gatos_donados LOOP
    v_mascota_id := mascota_seq.NEXTVAL;
    v_fecha_ingreso := TO_DATE('01-01-2021', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2021', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM nombre_gato ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(24, 29));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 4));
    v_cliente_donador_id := TRUNC(DBMS_RANDOM.VALUE(1, 27));
    v_folio := generar_folio(v_mascota_tipo_id, v_refugio_id, 1);

    v_sql := 'INSERT INTO mascota (mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id, cliente_donador_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11)';
    
    EXECUTE IMMEDIATE v_sql USING v_mascota_id, v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, v_folio, v_mascota_tipo_id, 1, v_refugio_id, 1, v_cliente_donador_id;
  END LOOP;

  -- Gatos abandonados
  FOR v_index_loop IN 1 .. v_n_gatos_abandonados LOOP
    v_mascota_id := mascota_seq.NEXTVAL;
    v_fecha_ingreso := TO_DATE('01-01-2021', 'DD-MM-YYYY') + DBMS_RANDOM.VALUE(1, 2.4*365);
    v_fecha_nacimiento := TO_DATE('01-01-2021', 'DD-MM-YYYY') - DBMS_RANDOM.VALUE(15, 5*365);
    SELECT nombre INTO v_nombre FROM (SELECT * FROM nombre_gato ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_mascota_tipo_id := TRUNC(DBMS_RANDOM.VALUE(24, 29));
    v_refugio_id := TRUNC(DBMS_RANDOM.VALUE(1, 4));
    v_folio := generar_folio(v_mascota_tipo_id, v_refugio_id, 1);

    v_sql := 'INSERT INTO mascota (mascota_id, fecha_status, fecha_ingreso, fecha_nacimiento, nombre, folio, mascota_tipo_id, status_mascota_id, refugio_id, origen_id)' ||
    'VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10)';

    EXECUTE IMMEDIATE v_sql USING v_mascota_id, v_fecha_ingreso, v_fecha_ingreso, v_fecha_nacimiento, v_nombre, v_folio, v_mascota_tipo_id, 1, v_refugio_id, 2;
  END LOOP;
END;
/

COMMIT;