--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Creación de secuencias para las tablas

PROMPT ========================================================
PROMPT Creación de secuencias
PROMPT s-05-secuencias.sql
PROMPT ========================================================

CREATE SEQUENCE folio_perro_seq
  MAXVALUE 999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE folio_gato_seq
  MAXVALUE 999
  NOCYCLE
  NOCACHE
  ORDER;