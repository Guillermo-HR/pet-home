--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos

PROMPT ========================================================
PROMPT Creación de indices
PROMPT s-06-indices.sql
PROMPT ========================================================
SET SERVEROUTPUT OFF

DROP INDEX IF EXISTS mascota_tipo_id_ix;
CREATE INDEX mascota_tipo_id_ix 
  ON mascota(mascota_tipo_id);

DROP INDEX IF EXISTS cliente_username_iuk;
CREATE UNIQUE INDEX cliente_username_iuk 
  ON cliente(username);

DROP INDEX IF EXISTS centro_refugio_estado_idfx;
CREATE INDEX centro_refugio_estado_idfx ON centro_refugio (
  SUBSTR(numero_registro, 1, 2) -- Extraer las primeras dos letras (estado)
);

DROP INDEX IF EXISTS centro_refugio_municipio_idfx;
CREATE INDEX centro_refugio_municipio_idfx ON centro_refugio (
  SUBSTR(numero_registro, 3, 3) -- Extraer los tres caracteres siguientes (municipio/delegación)
);
