--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Crear la funcion para generar los folios

PROMPT ========================================================
PROMPT Definicion de la funcion para generar folios
PROMPT s-15-fx-generar-folio.sql
PROMPT ========================================================

CREATE OR REPLACE FUNCTION generar_folio(
  p_mascota_tipo_id mascota_tipo.mascota_tipo_id%TYPE,
  p_centro_refugio_id NUMBER,
  p_origen_id origen.origen_id%TYPE
) RETURN VARCHAR2 IS
  v_folio VARCHAR2(8) := '';
  v_tipo VARCHAR2(40);
  v_refugio_id_con_formato VARCHAR2(2);
  v_origen_id_con_formato VARCHAR2(1);
  v_numero_folio VARCHAR2(3);
  BEGIN
    v_refugio_id_con_formato := SUBSTR(LPAD(p_centro_refugio_id, 2, '0'), -2);
    v_origen_id_con_formato := TO_CHAR(p_origen_id);

    SELECT tipo INTO v_tipo FROM mascota_tipo WHERE mascota_tipo_id = p_mascota_tipo_id;
    IF v_tipo = 'Perro' THEN
      SELECT SUBSTR(LPAD(folio_perro_seq.nextval, 3, '0'), -3) INTO v_numero_folio FROM dual;
      v_folio := 'PR' || TO_CHAR(v_refugio_id_con_formato) || TO_CHAR(v_origen_id_con_formato) || TO_CHAR(v_numero_folio);
    ELSIF v_tipo = 'Gato' THEN
      SELECT SUBSTR(LPAD(folio_gato_seq.nextval, 3, '0'), -3) INTO v_numero_folio FROM dual;
      v_folio := 'GA' || TO_CHAR(v_refugio_id_con_formato) || TO_CHAR(v_origen_id_con_formato) || TO_CHAR(v_numero_folio);
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Tipo de mascota no registrado');
    END IF;
    RETURN v_folio;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
END generar_folio;
/   
SHOW ERRORS;