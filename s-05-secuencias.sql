--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Creación de secuencias para las tablas

PROMPT ========================================================
PROMPT Creación de secuencias
PROMPT s-05-secuencias.sql
PROMPT ========================================================

-- Secuencias para las tablas
 
CREATE SEQUENCE empleado_seq
  START WITH 1
  MAXVALUE 999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE mascota_tipo_seq
  START WITH 1
  MAXVALUE 99
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE cliente_seq
  START WITH 1
  MAXVALUE 999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE nombre_perro_seq
  START WITH 1
  MAXVALUE 99
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE nombre_gato_seq
  START WITH 1
  MAXVALUE 99
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE empleado_grado_seq
  START WITH 1
  MAXVALUE 999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE centro_operativo_seq
  START WITH 1
  MAXVALUE 99
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE centro_refugio_web_seq
  START WITH 1
  MAXVALUE 99
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE donativo_seq
  START WITH 1
  MAXVALUE 9999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE mascota_seq
  START WITH 1
  MAXVALUE 9999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE historico_status_mascota_seq
  START WITH 1
  MAXVALUE 99999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE cliente_mascota_solicitud_seq
  START WITH 1
  MAXVALUE 99999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE monitoreo_cautiverio_seq
  START WITH 1
  MAXVALUE 99999
  NOCYCLE
  NOCACHE
  ORDER;

-- Secuencias para los folios de mascotas
CREATE SEQUENCE folio_perro_seq
  START WITH 1
  MAXVALUE 999
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE folio_gato_seq
  START WITH 1
  MAXVALUE 999
  NOCYCLE
  NOCACHE
  ORDER;