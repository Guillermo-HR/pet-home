--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Crear la funcion para generar los numeros de consulta

PROMPT ========================================================
PROMPT Definicion de la funcion para generar numeros de revisiones
PROMPT s-15-fx-generar-numero-revision.sql
PROMPT ========================================================

CREATE OR REPLACE FUNCTION generar_n_revision(
  p_mascota_id mascota.mascota_id%TYPE
) RETURN NUMBER IS
  v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count 
    FROM revision
    WHERE mascota_id = p_mascota_id;
    RETURN v_count + 1;
  END generar_n_revision;
/