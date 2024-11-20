--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Creación de tablas

-- Conectarse a la base de datos
PROMPT ========================================================
PROMPT Conectando a la PDB
CONNECT ah_admin_rol/contrasena@ghrbd_s1
PROMPT s-02-entidades.sql
PROMPT ========================================================

-- Eliminación y creación de la tabla cliente
DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
  cliente_id       GENERATED ALWAYS AS (cliente_id_seq.nextval) VIRTUAL,
  nombre           VARCHAR2(40) NOT NULL,
  apellido_paterno VARCHAR2(40) NOT NULL, 
  apellido_materno VARCHAR2(40) NOT NULL,
  direccion        VARCHAR2(40) NOT NULL,
  ocupacion        VARCHAR2(40) NOT NULL, 
  username         VARCHAR2(40) NOT NULL,
  password         VARCHAR2(40) NOT NULL,
  CONSTRAINT cliente_pk PRIMARY KEY (cliente_id),
  CONSTRAINTcliente_password_chk CHECK (LENGTH(password) >= 8)
);

-- Eliminación y creación de la tabla donativo
DROP TABLE IF EXISTS donativo;
CREATE TABLE donativo (
  donativo_id GENERATED ALWAYS AS (donativo_id_seq.nextval) VIRTUAL,
  fecha       DATE DEFAULT ON NULL SYSDATE,
  monto       NUMERIC(6,0) NOT NULL,
  CONSTRAINT donativo_pk PRIMARY KEY (donativo_id)
);

-- Eliminación y creación de la tabla mascota_tipo
DROP TABLE IF EXISTS mascota_tipo;
CREATE TABLE mascota_tipo (
  mascota_tipo_id GENERATED ALWAYS AS (mascota_tipo_seq.nextval) VIRTUAL,
  tipo            VARCHAR2(40) NOT NULL,
  subcadena       VARCHAR2(40) NOT NULL,
  nivel_cuidado   CHAR(1) NOT NULL,
  CONSTRAINT mascota_tipo_pk PRIMARY KEY (mascota_tipo_id)
);

-- Eliminación y creación de la tabla origen
DROP TABLE IF EXISTS origen;
CREATE TABLE origen (
  origen_id   NUMERIC(10,0),
  descripcion VARCHAR2(40) NOT NULL, 
  clave       NUMBER(1,0) NOT NULL, 
  CONSTRAINT origen_pk PRIMARY KEY (origen_id)
);

-- Eliminación y creación de la tabla centro_operativo
DROP TABLE IF EXISTS centro_operativo;
CREATE TABLE centro_operativo (
  centro_operativo_id GENERATED ALWAYS AS (centro_operativo_id_seq.nextval) VIRTUAL,
  gerente_id,
  es_refugio          CHAR(1) NOT NULL,
  es_clinica          CHAR(1) NOT NULL,
  es_oficina          CHAR(1) NOT NULL,
  codigo              VARCHAR2(5) NOT NULL,
  nombre              VARCHAR2(40) NOT NULL,
  direccion           VARCHAR2(100) NOT NULL,
  latitud             VARCHAR2(10) NOT NULL,
  longitud            VARCHAR2(10) NOT NULL,
  CONSTRAINT centro_operativo_pk PRIMARY KEY (centro_operativo_id),
  CONSTRAINT centro_operativo_gerente_id_fk FOREIGN KEY (gerente_id)
    REFERENCES empleado(gerente_id),
  CONSTRAINT centro_operativo_codigo_uk UNIQUE(codigo),
  CONSTRAINT centro_operativo_gerente_id_uk UNIQUE(gerente_id),
  CONSTRAINT centro_operativo_es_refugio_es_clinica_es_oficina_chk CHECK (
    (es_refugio = '1' AND es_clinica = '0' AND es_oficina = '0') OR
    (es_refugio = '0' AND es_clinica = '1' AND es_oficina = '0') OR
    (es_refugio = '0' AND es_clinica = '0' AND es_oficina = '1') OR
    (es_refugio = '1' AND es_clinica = '1' AND es_oficina = '0')
  )
);

-- Eliminación y creación de la tabla status_mascota
DROP TABLE IF EXISTS status_mascota;
CREATE TABLE status_mascota (
  status_mascota_id NUMERIC(10,0), 
  descripcion       VARCHAR2(40) NOT NULL, 
  clave             NUMBER(1,0) NOT NULL, 
  CONSTRAINT status_mascota_pk PRIMARY KEY (status_mascota_id)
);


-- Eliminación y creación de la tabla cliente_mascota_solicitud
DROP TABLE IF EXISTS cliente_mascota_solicitud;
CREATE TABLE cliente_mascota_solicitud (
  cliente_mascota_solicitud_id GENERATED ALWAYS AS (cliente_mascota_solicitud_id_seq.nextval) VIRTUAL,
  fecha                        DATE DEFAULT ON NULL SYSDATE,
  ganador                      CHAR(1) NOT NULL,
  descripcion_no_ganador       VARCHAR2(40),
  mascota_id,
  cliente_id,
  constraint cliente_mascota_solicitud_pk primary key ( cliente_mascota_solicitud_id ),
  constraint cliente_mascota_solicitud_mascota_id_fk foreign key ( mascota_id )
    references mascota(mascota_id),
  constraint cliente_mascota_solicitud_cliente_id_fk foreign key ( cliente_id )
    references cliente(cliente_id),
  CONSTRAINT cliente_mascota_solicitud_ganador_chk CHECK (ganador in (1,0))
);

-- Eliminación y creación de la tabla monitoreo_cautiverio
DROP TABLE IF EXISTS monitoreo_cautiverio;
CREATE TABLE monitoreo_cautiverio (
  monitoreo_cautiverio_id GENERATED ALWAYS AS (monitoreo_cautiverio_id_id_seq.nextval) VIRTUAL,
  fecha                   DATE DEFAULT ON NULL SYSDATE,
  diagnostico             VARCHAR2(40) NOT NULL, 
  foto                    BLOB NOT NULL,
  mascota_id,
  CONSTRAINT monitoreo_cautiverio_pk PRIMARY KEY ( monitoreo_cautiverio_id ),
  CONSTRAINT monitoreo_cautiverio_mascota_id_fk FOREIGN KEY ( mascota_id )
    REFERENCES mascota ( mascota_id )
);

-- Eliminación y creación de la tabla empleado
DROP TABLE IF EXISTS empleado;
CREATE TABLE empleado (
   empleado_id       GENERATED ALWAYS AS (empleado_id_seq.nextval) VIRTUAL,
   es_gerente        CHAR(1) NOT NULL,
   es_veterinaro     CHAR(1) NOT NULL,
   es_administrativo CHAR(1) NOT NULL,
   fecha_ingreso     DATE DEFAULT ON NULL SYSDATE,
   curp              VARCHAR2(18) NOT NULL,
   email             VARCHAR2(40) NOT NULL,
   nombre            VARCHAR2(40) NOT NULL,
   apellido_paterno  VARCHAR2(40) NOT NULL,
   apellido_materno  VARCHAR2(40) NOT NULL,
   sueldo            NUMERIC(6,2) NOT NULL,
   CONSTRAINT empleado_pk PRIMARY KEY(empleado_id),
   CONSTRAINT empleado_curp_uk UNIQUE(curp),
   CONSTRAINT empleado_es_gerente_es_veterinario_es_administrativo_chk CHECK(
    (es_gerente = '1' AND es_veterinaro = '0' AND es_administrativo = '0') OR
    (es_gerente = '0' AND es_veterinaro = '1' AND es_administrativo = '0') OR
    (es_gerente = '0' AND es_veterinaro = '0' AND es_administrativo = '1') OR
    (es_gerente = '1' AND es_veterinaro = '1' AND es_administrativo = '0') OR
    (es_gerente = '0' AND es_veterinaro = '1' AND es_administrativo = '1')
   )
);

-- Eliminación y creación de la tabla empleado_grado
DROP TABLE IF EXISTS empleado_grado;
CREATE TABLE empleado_grado (
   empleado_grado_id GENERATED ALWAYS AS (empleado_grado_id_seq.nextval) VIRTUAL,
   cedula            VARCHAR2(8) not null,
   titulo            VARCHAR2(40) not null,
   fecha_titulacion  DATE DEFAULT ON NULL SYSDATE,
   empleado_id,
   CONSTRAINT empleado_grado_pk PRIMARY KEY(empleado_grado_id),
   CONSTRAINT empleado_grado_empleado_id_fk FOREIGN KEY ( empleado_id )
      REFERENCES empleado ( empleado_id ), 
  CONSTRAINT empleado_grado_cedula_uk UNIQUE(cedula)
);

-- Eliminación y creación de la tabla clinica
DROP TABLE IF EXISTS clinica;
CREATE TABLE clinica (
  clinica_id,
  hora_atencion_inicio     DATE NOT NULL,
  hora_atencion_fin        DATE NOT NULL,
  telefono                 VARCHAR2(10) NOT NULL,
  telefono_emergencia      VARCHAR2(10) NOT NULL,
  CONSTRAINT clinica_pk    PRIMARY KEY (clinica_id),
  CONSTRAINT clinica_clinica_id_fk FOREIGN KEY (clinica_id) 
    REFERENCES centro_operativo(centro_operativo_id)
);

-- Eliminación y creación de la tabla oficina
DROP TABLE IF EXISTS oficina;
CREATE TABLE oficina (
  oficina_id,
  rfc                      VARCHAR2(12) NOT NULL,
  firma_electronica        BLOB NOT NULL,
  responsable_legal        VARCHAR2(40) NOT NULL,
  CONSTRAINT oficina_pk    PRIMARY KEY (oficina_id),
  CONSTRAINT oficina_oficina_id_fk FOREIGN KEY (oficina_id) 
    REFERENCES centro_operativo(centro_operativo_id),
  CONSTRAINT oficina_rfc_uk UNIQUE(rfc),
  CONSTRAINT oficina_firma_electronica_uk UNIQUE(firma_electronica)
);

-- Eliminación y creación de la tabla centro_refugio
DROP TABLE IF EXISTS centro_refugio;
CREATE TABLE centro_refugio (
  centro_refugio_id,
  capacidad_maxima         NUMERIC(3,0) NOT NULL,
  numero_registro          VARCHAR2(8) NOT NULL,
  logo                     BLOB NOT NULL,
  lema                     VARCHAR2(30) NOT NULL,
  refugio_alterno          NUMERIC(10,0),
  CONSTRAINT centro_refugio_pk PRIMARY KEY (centro_refugio_id),
  CONSTRAINT centro_refugio_centro_refugio_id_fk FOREIGN KEY (centro_refugio_id) 
    REFERENCES centro_operativo(centro_operativo_id),
  CONSTRAINT centro_refugio_refugio_alterno_fk
    FOREIGN KEY (refugio_alterno) 
    REFERENCES centro_refugio(centro_refugio_id),
  CONSTRAINT centro_refugio_numero_registro_uk UNIQUE(numero_registro)
);

-- Eliminación y creación de la tabla centro_refugio_web
DROP TABLE IF EXISTS centro_refugio_web;
CREATE TABLE centro_refugio_web (
  centro_refugio_web_id    GENERATED ALWAYS AS (centro_refugio_web_id_seq.nextval) VIRTUAL,
  centro_refugio_id        NUMERIC(10,0),
  url                      VARCHAR2(60) NOT NULL,
  CONSTRAINT centro_refugio_web_pk PRIMARY KEY (centro_refugio_web_id),
  CONSTRAINT centro_refugio_web_centro_refugio_id_fk
    FOREIGN KEY (centro_refugio_id) 
    REFERENCES centro_refugio(centro_refugio_id)
);

-- Eliminación y creación de la tabla historico_status_mascota
DROP TABLE IF EXISTS historico_status_mascota;
CREATE TABLE historico_status_mascota (
  historico_status_mascota_id GENERATED ALWAYS AS (historico_status_mascota_id_seq.nextval) VIRTUAL,
  status_mascota_id           NUMERIC(10,0) NOT NULL,
  mascota_id                 NUMERIC(10,0) NOT NULL,
  fecha_status               DATE DEFAULT ON NULL SYSDATE,
  CONSTRAINT historico_status_mascota_pk PRIMARY KEY (historico_status_mascota_id),
  CONSTRAINT historico_status_mascota_status_mascota_id_fk
    FOREIGN KEY (status_mascota_id) 
    REFERENCES status_mascota(status_mascota_id),
  CONSTRAINT historico_status_mascota_mascota_id_fk
    FOREIGN KEY (mascota_id) 
    REFERENCES mascota(mascota_id)
);

-- Eliminación y creación de la tabla revision
DROP TABLE IF EXISTS revision;
CREATE TABLE revision (
  revision_id              GENERATED ALWAYS AS (revision_id_seq.nextval) VIRTUAL,
  mascota_id               NUMERIC(10,0) NOT NULL,
  costo                    NUMERIC(8,2) NOT NULL,
  observacion              VARCHAR2(300) NOT NULL,
  numero_revision          NUMERIC(10,0) NOT NULL,
  fecha                    DATE DEFAULT ON NULL SYSDATE,
  calificacion             NUMERIC(2,0) NOT NULL,
  clinica_id               NUMERIC(10,0),
  CONSTRAINT revision_pk   PRIMARY KEY (revision_id),
  CONSTRAINT revision_mascota_id_fk
    FOREIGN KEY (mascota_id) 
    REFERENCES mascota(mascota_id),
  CONSTRAINT revision_clinica_id_fk
    FOREIGN KEY (clinica_id) 
    REFERENCES clinica(clinica_id)
);


-- Eliminación y creación de la tabla mascota
DROP TABLE IF EXISTS mascota;
CREATE TABLE mascota (
  mascota_id          GENERATED ALWAYS AS (mascota_id_seq.nextval) VIRTUAL,
  fecha_status        DATE NOT NULL,
  fecha_ingreso       DATE NOT NULL, 
  fecha_nacimiento    DATE NOT NULL,
  nombre              VARCHAR2(40) NOT NULL, 
  folio               VARCHAR2(8) NOT NULL, 
  causa_muerte        VARCHAR2(100) NOT NULL,
  fecha_adopcion      DATE NOT NULL,
  madre_id, 
  padre_id, 
  status_mascota_id,
  mascota_tipo_id, 
  refugio_id, 
  refugio_nacimiento_id,
  origen_id,
  cliente_donador_id,
  CONSTRAINT mascota_madre_id_fk FOREIGN KEY (madre_id)
    REFERENCES mascota(mascota_id),
  CONSTRAINT mascota_padre_id_fk FOREIGN KEY (padre_id)
    REFERENCES mascota(mascota_id),
  CONSTRAINT mascota_status_mascota_id_fk FOREIGN KEY (status_mascota_id) 
    REFERENCES status_mascota(status_mascota_id),
  CONSTRAINT mascota_mascota_tipo_id_fk FOREIGN KEY (mascota_tipo_id) 
    REFERENCES mascota_tipo(mascota_tipo_id),
  CONSTRAINT mascota_refugio_id_fk FOREIGN KEY (refugio_id)
    REFERENCES centro_refugio(refugio_id), 
  CONSTRAINT mascota_refugio_nacimiento_id_fk FOREIGN KEY (refugio_nacimiento_id) 
    REFERENCES centro_refugio(refugio_id),
  CONSTRAINT mascota_origen_id_fk FOREIGN KEY (origen_id)
    REFERENCES origen(origen_id), 
  CONSTRAINT mascota_cliente_donador_id_fk FOREIGN KEY (cliente_donador_id)
    REFERENCES cliente(cliente_id),
  CONSTRAINT mascota_folio_uk UNIQUE(folio)
);

-- Salir de la base
PROMPT ========================================================
PROMPT Saliendo de la PDB
DISCONNECT;
PROMPT ========================================================