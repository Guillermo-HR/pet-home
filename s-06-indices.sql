--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos

PROMPT ========================================================
PROMPT Creación de indices
PROMPT s-06-indices.sql
PROMPT ========================================================

DROP INDEX IF EXISTS mascota_tipo_id_ix;
CREATE INDEX mascota_tipo_id_ix 
  ON mascota(mascota_tipo_id);

DROP INDEX IF EXISTS cliente_username_iuk;
CREATE UNIQUE INDEX cliente_username_iuk 
  ON cliente(username);
