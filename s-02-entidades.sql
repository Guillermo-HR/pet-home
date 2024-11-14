IF EXISTS DROP TABLE cliente;
CREATE TABLE cliente(
    cliente_id NUMERIC (10,0),
    nombre VARCHAR2 (40) NOT NULL,
    apellido_paterno VARCHAR2(40) NOT NULL, 
    apellido_materno VARCHAR2 (40) NOT NULL,
    direccion VARCHAR2(40) NOT NULL,
    ocupacion VARCHAR2(40) NOT NULL, 
    username VARCHAR2(40) NOT NULL,
    password VARCHAR2(40) NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (cliente_id)
);

IF EXISTS DROP TABLE donativo;
CREATE TABLE donativo(
    donativo_id NUMERIC(10,0),
    fecha DATE NOT NULL, 
    monto NUMERIC(6,0) NOT NULL,
    CONSTRAINT donativo_pk PRIMARY KEY (donativo_id)
);

IF EXISTS DROP TABLE mascota_tipo(
    mascota_tipo_id NUMERIC (10,0),
    tipo VARCHAR2(40) NOT NULL,
    subcadena VARCHAR2(40) NOT NULL,
    nivel_cuidado CHAR(1) NOT NULL,
    CONSTRAINT mascota_tipo_pk PRIMARY KEY (mascota_tipo_id)
);

IF EXISTS DROP TABLE origen;
CREATE TABLE ORIGEN(
    origen_id
);






------------------------------------------------------------
IF EXISTS DROP TABLE empleado;
CREATE TABLE empleado(
  empleado_id NUMERIC (10,0) CONSTRAINT empleado_pk PRIMARY KEY,
  es_gerente CHAR(1) NOT NULL,
  es_veterinaro CHAR(1) NOT NULL,
  es_administratico CHAR(1) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  curp VARCHAR2(18) NOT NULL,
  email VARCHAR2(40) NOT NULL,
  nombre VARCHAR2(40) NOT NULL,
  apellido_paterno VARCHAR2(40) NOT NULL,
  apellido_materno VARCHAR2(40) NOT NULL,
  sueldo NUMERIC(6, 2) NOT NULL
);

IF EXISTS DROP TABLE empleado_grado;
CREATE TABLE empleado_grado(
  empleado_grado_id NUMERIC(10,0) CONSTRAINT empleado_grado_pk PRIMARY KEY,
  cedula VARCHAR2(8) NOT NULL,
  titulo VARCHAR2(40) NOT NULL,
  fecha_titulacion DATE NOT NULL,
  empleado_id CONSTRAINT empleado_grado_empleado_id_fk REFERENCES empleado(empleado_id)
);

IF EXISTS DROP TABLE clinica
CREATE TABLE clinica(
  centro_operativo_id CONSTRAINT clinica_centro_operativo_id_fk 
    REFERENCES centro_operativo(centro_operativo_id),
  
);