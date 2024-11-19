/*
create sequence <sequence_name>
maxvalue 100
nocycle
nocache
order;
*/

-- Creación de secuencias para las PK de las tablas
CREATE SEQUENCE cliente_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE donativo_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;


CREATE SEQUENCE centro_operativo_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE cliente_mascota_solicitud_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE monitoreo_cautiverio_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE empleado_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE empleado_grado_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE centro_refugio_web_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE historico_status_mascota_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE revision_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;

CREATE SEQUENCE mascota_id_seq
  MAXVALUE 100
  NOCYCLE
  NOCACHE
  ORDER;


