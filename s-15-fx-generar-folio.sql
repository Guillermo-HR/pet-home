--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Crear la funcion para generar los folios

PROMPT ========================================================
PROMPT Definicion de la funcion para generar folios
PROMPT s-15-fx-generar-folio.sql
PROMPT ========================================================
SET SERVEROUTPUT OFF

CREATE OR REPLACE FUNCTION generar_folio(
  p_mascota_tipo_id mascota_tipo.mascota_tipo_id%TYPE,
  p_centro_refugio_id NUMBER,
  p_origen_id origen.origen_id%TYPE
) RETURN VARCHAR2 IS
  n_refuios NUMBER;
  v_folio VARCHAR2(8) := '';
  v_tipo VARCHAR2(40);
  v_refugio_id_con_formato VARCHAR2(2);
  v_origen_id_con_formato VARCHAR2(1);
  v_numero_folio VARCHAR2(3);
  v_existe_tipo NUMBER;
  BEGIN
    SELECT COUNT(*) INTO n_refuios FROM centro_refugio WHERE centro_refugio_id = p_centro_refugio_id;
    IF n_refuios = 0 THEN
      RAISE_APPLICATION_ERROR(-20010, 'Centro de refugio no registrado');
    END IF;
    v_refugio_id_con_formato := SUBSTR(LPAD(p_centro_refugio_id, 2, '0'), -2);
    v_origen_id_con_formato := TO_CHAR(p_origen_id);

    IF p_origen_id NOT IN (1, 2, 3) THEN
      RAISE_APPLICATION_ERROR(-20011, 'Origen no registrado');
    END IF;

    SELECT COUNT(*) INTO v_existe_tipo FROM mascota_tipo WHERE mascota_tipo_id = p_mascota_tipo_id;
    IF v_existe_tipo = 0 THEN
      RAISE_APPLICATION_ERROR(-20012, 'Tipo de mascota no registrado');
    END IF;

    SELECT tipo INTO v_tipo FROM mascota_tipo WHERE mascota_tipo_id = p_mascota_tipo_id;
    IF v_tipo = 'Perro' THEN
      SELECT SUBSTR(LPAD(folio_perro_seq.nextval, 3, '0'), -3) INTO v_numero_folio FROM dual;
      v_folio := 'PR' || v_refugio_id_con_formato || v_origen_id_con_formato || v_numero_folio;
    ELSIF v_tipo = 'Gato' THEN
      SELECT SUBSTR(LPAD(folio_gato_seq.nextval, 3, '0'), -3) INTO v_numero_folio FROM dual;
      v_folio := 'GA' || v_refugio_id_con_formato || v_origen_id_con_formato || v_numero_folio;
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Prefijo de mascota no registrado');
    END IF;
    RETURN v_folio;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
END generar_folio;
/   
SHOW ERRORS;