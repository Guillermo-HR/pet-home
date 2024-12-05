--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Creación de tablas 

PROMPT ========================================================
PROMPT Creación de entidades
PROMPT s-02-entidades-1.sql
PROMPT ========================================================

-- Tablas independientes

-- Eliminación y creación de la tabla empleado
DROP TABLE IF EXISTS empleado CASCADE CONSTRAINTS;
CREATE TABLE empleado (
  empleado_id       NUMBER GENERATED ALWAYS AS IDENTITY,
  es_gerente        CHAR(1) NOT NULL,
  es_veterinaro     CHAR(1) NOT NULL,
  es_administrativo CHAR(1) NOT NULL,
  fecha_ingreso     DATE DEFAULT ON NULL SYSDATE,
  curp              VARCHAR2(18) NOT NULL,
  email             VARCHAR2(40) NOT NULL,
  nombre            VARCHAR2(40) NOT NULL,
  apellido_paterno  VARCHAR2(40) NOT NULL,
  apellido_materno  VARCHAR2(40) NOT NULL,
  sueldo            NUMERIC(7,2) NOT NULL,
  CONSTRAINT empleado_pk PRIMARY KEY (empleado_id),
  CONSTRAINT empleado_curp_uk UNIQUE (curp),
  CONSTRAINT empleado_es_gerente_es_veterinario_es_administrativo_chk CHECK (
    (es_gerente = '1' AND es_veterinaro = '0' AND es_administrativo = '0') OR
    (es_gerente = '0' AND es_veterinaro = '1' AND es_administrativo = '0') OR
    (es_gerente = '0' AND es_veterinaro = '0' AND es_administrativo = '1') OR
    (es_gerente = '1' AND es_veterinaro = '1' AND es_administrativo = '0') OR
    (es_gerente = '0' AND es_veterinaro = '1' AND es_administrativo = '1')
  )
);

-- Eliminación y creación de la tabla origen
DROP TABLE IF EXISTS origen CASCADE CONSTRAINTS;
CREATE TABLE origen (
  origen_id   NUMERIC(10,0),
  descripcion VARCHAR2(40) NOT NULL, 
  clave       NUMBER(1,0) NOT NULL, 
  CONSTRAINT origen_pk PRIMARY KEY (origen_id) 
);

-- Eliminación y creación de la tabla mascota_tipo
DROP TABLE IF EXISTS mascota_tipo CASCADE CONSTRAINTS;
CREATE TABLE mascota_tipo (
  mascota_tipo_id NUMBER GENERATED ALWAYS AS IDENTITY,
  tipo            VARCHAR2(40) NOT NULL,
  subcategoria    VARCHAR2(40) NOT NULL,
  nivel_cuidado   CHAR(1) NOT NULL,
  CONSTRAINT mascota_tipo_pk PRIMARY KEY (mascota_tipo_id)
);

-- Eliminación y creación de la tabla status_mascota
DROP TABLE IF EXISTS status_mascota CASCADE CONSTRAINTS;
CREATE TABLE status_mascota (
  status_mascota_id NUMERIC(10,0), 
  descripcion       VARCHAR2(40) NOT NULL, 
  clave             NUMBER(1,0) NOT NULL, 
  CONSTRAINT status_mascota_pk PRIMARY KEY (status_mascota_id)
);

-- Eliminación y creación de la tabla cliente
DROP TABLE IF EXISTS cliente CASCADE CONSTRAINTS;
CREATE TABLE cliente (
  cliente_id       NUMBER GENERATED ALWAYS AS IDENTITY,
  nombre           VARCHAR2(40) NOT NULL,
  apellido_paterno VARCHAR2(40) NOT NULL, 
  apellido_materno VARCHAR2(40) NOT NULL,
  direccion        VARCHAR2(40) NOT NULL,
  ocupacion        VARCHAR2(40) NOT NULL, 
  username         VARCHAR2(40) NOT NULL,
  password         VARCHAR2(40) NOT NULL,
  CONSTRAINT cliente_pk PRIMARY KEY (cliente_id),
  CONSTRAINT cliente_password_chk CHECK (LENGTH(password) >= 8)
);

-- Eliminación y creación de la tabla status_solicitud
DROP TABLE IF EXISTS status_solicitud CASCADE CONSTRAINTS;
CREATE TABLE status_solicitud(
  status_solicitud_id NUMERIC(1,0), 
  descripcion         VARCHAR(20)   NOT NULL,
  CLAVE               NUMERIC(1,0)  NOT NULL,
  CONSTRAINT status_solicitud_pk PRIMARY KEY (status_solicitud_id)
);

-- Tablas dependientes

-- Eliminación y creación de la tabla empleado_grado
DROP TABLE IF EXISTS empleado_grado CASCADE CONSTRAINTS;
CREATE TABLE empleado_grado (
  empleado_grado_id NUMBER GENERATED ALWAYS AS IDENTITY,
  cedula            VARCHAR2(8) NOT NULL,
  titulo            VARCHAR2(60) NOT NULL,
  fecha_titulacion  DATE NOT NULL,
  empleado_id       NOT NULL,
  CONSTRAINT empleado_grado_pk PRIMARY KEY(empleado_grado_id),
  CONSTRAINT empleado_grado_empleado_id_fk FOREIGN KEY(empleado_id)
    REFERENCES empleado(empleado_id), 
  CONSTRAINT empleado_grado_cedula_uk UNIQUE(cedula)
);

-- Eliminación y creación de la tabla centro_operativo
DROP TABLE IF EXISTS centro_operativo CASCADE CONSTRAINTS;
CREATE TABLE centro_operativo (
  centro_operativo_id NUMBER GENERATED ALWAYS AS IDENTITY,
  es_refugio          CHAR(1) NOT NULL,
  es_clinica          CHAR(1) NOT NULL,
  es_oficina          CHAR(1) NOT NULL,
  codigo              VARCHAR2(5) NOT NULL,
  nombre              VARCHAR2(50) NOT NULL,
  direccion           VARCHAR2(100) NOT NULL,
  latitud             VARCHAR2(10) NOT NULL,
  longitud            VARCHAR2(10) NOT NULL,
  gerente_id          NOT NULL,
  CONSTRAINT centro_operativo_pk PRIMARY KEY (centro_operativo_id),
  CONSTRAINT centro_operativo_gerente_id_fk FOREIGN KEY (gerente_id)
    REFERENCES empleado(empleado_id),
  CONSTRAINT centro_operativo_codigo_uk UNIQUE(codigo),
  CONSTRAINT centro_operativo_gerente_id_uk UNIQUE(gerente_id),
  CONSTRAINT centro_operativo_es_refugio_es_clinica_es_oficina_chk CHECK (
    (es_refugio = '1' AND es_clinica = '0' AND es_oficina = '0') OR
    (es_refugio = '0' AND es_clinica = '1' AND es_oficina = '0') OR
    (es_refugio = '0' AND es_clinica = '0' AND es_oficina = '1') OR
    (es_refugio = '1' AND es_clinica = '1' AND es_oficina = '0')
  )
);

-- Eliminación y creación de la tabla centro_refugio
DROP TABLE IF EXISTS centro_refugio CASCADE CONSTRAINTS;
CREATE TABLE centro_refugio (
  centro_refugio_id        NOT NULL,
  capacidad_maxima         NUMERIC(3,0) NOT NULL,
  numero_registro          VARCHAR2(8) NOT NULL,
  logo                     BLOB NOT NULL,
  lema                     VARCHAR2(30) NOT NULL,
  refugio_alterno,
  CONSTRAINT centro_refugio_pk PRIMARY KEY (centro_refugio_id),
  CONSTRAINT centro_refugio_centro_refugio_id_fk FOREIGN KEY (centro_refugio_id) 
    REFERENCES centro_operativo(centro_operativo_id),
  CONSTRAINT centro_refugio_refugio_alterno_fk FOREIGN KEY (refugio_alterno) 
    REFERENCES centro_refugio(centro_refugio_id),
  CONSTRAINT centro_refugio_numero_registro_uk UNIQUE(numero_registro)
);

-- Eliminación y creación de la tabla centro_refugio_web
DROP TABLE IF EXISTS centro_refugio_web;
CREATE TABLE centro_refugio_web (
  centro_refugio_web_id    NUMBER GENERATED ALWAYS AS IDENTITY,
  url                      VARCHAR2(60) NOT NULL,
  centro_refugio_id        NOT NULL,
  CONSTRAINT centro_refugio_web_pk PRIMARY KEY (centro_refugio_web_id),
  CONSTRAINT centro_refugio_web_centro_refugio_id_fk FOREIGN KEY (centro_refugio_id) 
    REFERENCES centro_refugio(centro_refugio_id),
  CONSTRAINT centro_refugio_web_url_uk UNIQUE(url)
);

-- Eliminación y creación de la tabla clinica
DROP TABLE IF EXISTS clinica CASCADE CONSTRAINTS;
CREATE TABLE clinica (
  clinica_id               NOT NULL,
  hora_atencion_inicio     DATE NOT NULL,
  hora_atencion_fin        DATE NOT NULL,
  telefono                 VARCHAR2(10) NOT NULL,
  telefono_emergencia      VARCHAR2(10) NOT NULL,
  CONSTRAINT clinica_pk PRIMARY KEY (clinica_id),
  CONSTRAINT clinica_clinica_id_fk FOREIGN KEY (clinica_id) 
    REFERENCES centro_operativo(centro_operativo_id)
);

-- Eliminación y creación de la tabla oficina
DROP TABLE IF EXISTS oficina;
CREATE TABLE oficina (
  oficina_id               NOT NULL,
  rfc                      VARCHAR2(12) NOT NULL,
  firma_electronica        BLOB NOT NULL,
  responsable_legal        VARCHAR2(40) NOT NULL,
  CONSTRAINT oficina_pk PRIMARY KEY (oficina_id),
  CONSTRAINT oficina_oficina_id_fk FOREIGN KEY (oficina_id) 
    REFERENCES centro_operativo(centro_operativo_id),
  --CONSTRAINT oficina_firma_electronica_uk UNIQUE(firma_electronica),
  CONSTRAINT oficina_rfc_uk UNIQUE(rfc)
);

-- Eliminación y creación de la tabla donativo
DROP TABLE IF EXISTS donativo CASCADE CONSTRAINTS;
CREATE TABLE donativo (
  donativo_id NUMBER GENERATED ALWAYS AS IDENTITY,
  fecha       DATE DEFAULT ON NULL SYSDATE,
  monto       NUMERIC(6,0) NOT NULL,
  cliente_id  NOT NULL,
  CONSTRAINT donativo_pk PRIMARY KEY (donativo_id),
  CONSTRAINT donativo_cliente_id_fk FOREIGN KEY (cliente_id)
    REFERENCES cliente(cliente_id)
);

-- Eliminación y creación de la tabla mascota
DROP TABLE IF EXISTS mascota CASCADE CONSTRAINTS;
CREATE TABLE mascota (
  mascota_id          NUMBER GENERATED ALWAYS AS IDENTITY,
  fecha_status        DATE NOT NULL,
  fecha_ingreso       DATE NOT NULL, 
  fecha_nacimiento    DATE NOT NULL,
  nombre              VARCHAR2(40) NOT NULL, 
  folio               VARCHAR2(8) NOT NULL, 
  causa_muerte        VARCHAR2(100),
  fecha_adopcion      DATE,
  mascota_tipo_id     NOT NULL, 
  status_mascota_id   NOT NULL,
  padre_id, 
  madre_id, 
  refugio_id          NOT NULL, 
  refugio_nacimiento_id,
  origen_id           NOT NULL,
  cliente_donador_id,
  CONSTRAINT mascota_pk PRIMARY KEY (mascota_id),
  CONSTRAINT mascota_mascota_tipo_id_fk FOREIGN KEY (mascota_tipo_id) 
    REFERENCES mascota_tipo(mascota_tipo_id),
  CONSTRAINT mascota_status_mascota_id_fk FOREIGN KEY (status_mascota_id) 
    REFERENCES status_mascota(status_mascota_id),
  CONSTRAINT mascota_padre_id_fk FOREIGN KEY (padre_id)
    REFERENCES mascota(mascota_id),
  CONSTRAINT mascota_madre_id_fk FOREIGN KEY (madre_id)
    REFERENCES mascota(mascota_id),
  CONSTRAINT mascota_refugio_id_fk FOREIGN KEY (refugio_id)
    REFERENCES centro_refugio(centro_refugio_id), 
  CONSTRAINT mascota_refugio_nacimiento_id_fk FOREIGN KEY (refugio_nacimiento_id) 
    REFERENCES centro_refugio(centro_refugio_id),
  CONSTRAINT mascota_origen_id_fk FOREIGN KEY (origen_id)
    REFERENCES origen(origen_id), 
  CONSTRAINT mascota_cliente_donador_id_fk FOREIGN KEY (cliente_donador_id)
    REFERENCES cliente(cliente_id),
  CONSTRAINT mascota_folio_uk UNIQUE (folio),
  CONSTRAINT mascota_origen_chk CHECK (
    (origen_id = 1 AND padre_id IS NULL AND madre_id IS NULL 
      AND refugio_nacimiento_id IS NULL AND cliente_donador_id IS NOT NULL) OR
    (origen_id = 2 AND padre_id IS NULL AND madre_id IS NULL 
      AND refugio_nacimiento_id IS NULL AND cliente_donador_id IS NULL) OR
    (origen_id = 3 AND madre_id IS NOT NULL AND refugio_nacimiento_id IS NOT NULL 
      AND cliente_donador_id IS NULL)
  )
);

-- Eliminación y creación de la tabla historico_status_mascota
DROP TABLE IF EXISTS historico_status_mascota;
CREATE TABLE historico_status_mascota (
  historico_status_mascota_id NUMBER GENERATED ALWAYS AS IDENTITY,
  fecha_status                DATE DEFAULT ON NULL SYSDATE,
  status_mascota_id           NOT NULL,
  mascota_id                  NOT NULL,
  CONSTRAINT historico_status_mascota_pk PRIMARY KEY (historico_status_mascota_id),
  CONSTRAINT historico_status_mascota_status_mascota_id_fk FOREIGN KEY (status_mascota_id) 
    REFERENCES status_mascota(status_mascota_id),
  CONSTRAINT historico_status_mascota_mascota_id_fk FOREIGN KEY (mascota_id) 
    REFERENCES mascota(mascota_id)
);

-- Eliminación y creación de la tabla cliente_mascota_solicitud
DROP TABLE IF EXISTS cliente_mascota_solicitud;
CREATE TABLE cliente_mascota_solicitud (
  cliente_mascota_solicitud_id NUMBER GENERATED ALWAYS AS IDENTITY,
  fecha                        DATE DEFAULT ON NULL SYSDATE,
  descripcion_no_ganador       VARCHAR2(40),
  mascota_id                   NOT NULL,
  cliente_id                   NOT NULL,
  status_solicitud_id          NOT NULL,
  CONSTRAINT cliente_mascota_solicitud_pk primary KEY (cliente_mascota_solicitud_id),
  CONSTRAINT cliente_mascota_solicitud_status_solicitud_id_fk FOREIGN KEY (status_solicitud_id)
    REFERENCES status_solicitud(status_solicitud_id),
  CONSTRAINT cliente_mascota_solicitud_mascota_id_fk foreign KEY (mascota_id)
    REFERENCES mascota(mascota_id),
  CONSTRAINT cliente_mascota_solicitud_cliente_id_fk foreign KEY (cliente_id)
    REFERENCES cliente(cliente_id),
  CONSTRAINT cliente_mascota_solicitud_rechazado_chk CHECK (
    (status_solicitud_id = 1 AND descripcion_no_ganador IS NULL) OR
    (status_solicitud_id = 2 AND descripcion_no_ganador IS NULL) OR
    (status_solicitud_id = 3 AND descripcion_no_ganador IS NOT NULL))
);

-- Eliminación y creación de la tabla monitoreo_cautiverio
DROP TABLE IF EXISTS monitoreo_cautiverio;
CREATE TABLE monitoreo_cautiverio (
  monitoreo_cautiverio_id NUMBER GENERATED ALWAYS AS IDENTITY,
  fecha                   DATE DEFAULT ON NULL SYSDATE,
  diagnostico             VARCHAR2(200) NOT NULL, 
  foto                    BLOB NOT NULL,
  mascota_id              NOT NULL,
  veterinario_id          NOT NULL,
  CONSTRAINT monitoreo_cautiverio_pk PRIMARY KEY (monitoreo_cautiverio_id),
  CONSTRAINT monitoreo_cautiverio_mascota_id_fk FOREIGN KEY (mascota_id)
    REFERENCES mascota(mascota_id),
  CONSTRAINT monitoreo_cautiverio_veterinario_id_fk FOREIGN KEY (veterinario_id)
    REFERENCES empleado(empleado_id)
);

-- Eliminación y creación de la tabla revision
DROP TABLE IF EXISTS revision;
CREATE TABLE revision (
  revision_id              NUMBER GENERATED ALWAYS AS IDENTITY,
  costo                    NUMERIC(8,2) NOT NULL,
  observacion              VARCHAR2(300) NOT NULL,
  numero_revision          NUMERIC(10,0) NOT NULL,
  fecha                    DATE DEFAULT ON NULL SYSDATE,
  calificacion             NUMERIC(2,0) NOT NULL,
  clinica_id               NOT NULL,
  mascota_id               NOT NULL,
  CONSTRAINT revision_pk PRIMARY KEY (revision_id),
  CONSTRAINT revision_mascota_id_fk FOREIGN KEY (mascota_id) 
    REFERENCES mascota(mascota_id),
  CONSTRAINT revision_clinica_id_fk FOREIGN KEY (clinica_id) 
    REFERENCES clinica(clinica_id)
);

COMMIT;