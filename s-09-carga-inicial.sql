--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos

-- Conectarse a la base de datos
PROMPT ========================================================
PROMPT Conectando a la PDB
CONNECT ah_admin_rol/contrasena@ghrbd_s1
PROMPT s-09-carga-inicial.sql
PROMPT ========================================================

-- Agregar origen de las mascotas
INSERT INTO origen_mascota(origen_id, clave, descripcion)
  VALUES(1, 1, 'Donada por un cliente');
INSERT INTO origen_mascota(origen_id, clave, descripcion)
  VALUES(2, 2, 'Abandonada envía pública');
INSERT INTO origen_mascota(origen_id, clave, descripcion)
  VALUES(3, 3, 'Nacida en cautiverio');

-- Agregar tipos de mascotas
  -- Nivel cuidado [1, 5] (1: minimo, 5: maximo)
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Ave', 'Canario', 1);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Ave', 'Perico', 2);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Ave', 'Loro', 2);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Ave', 'Guacamaya', 3);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Perro', 'Pastor Aleman', 4);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Perro', 'Chihuahua', 2);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Perro', 'Pitbull', 3);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Gato', 'Siames', 2);
INSERT INTO mascota_tipo(tipo, subcategoria, nivel_cuidado)
  VALUES('Gato', 'Persa', 3);

-- Agregar status de mascotas
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(1, 1, 'EN_REFUGIO');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(2, 2, 'DISPONIBLE_ADOPCIÓN');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(3, 3, 'SOLICITADA_ADOPCION');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(4, 4, 'ADOPTADA'); 
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(5, 5, 'ENFERMA');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(6, 6, 'FALLECIDA_REFUGIO');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(7, 7, 'FALLECIDA_HOGAR'); 

-- Agregar status solicitud
INSERT INTO status_solicitud(status_solicitud_id, clave, descripcion)
  VALUES(1, 1, 'PENDIENTE');
INSERT INTO status_solicitud(status_solicitud_id, clave, descripcion)
  VALUES(2, 2, 'APROBADA');
INSERT INTO status_solicitud(status_solicitud_id, clave, descripcion)
  VALUES(3, 3, 'RECHAZADA');

-- Salir de la base
PROMPT ========================================================
PROMPT Saliendo de la PDB
DISCONNECT;
PROMPT ========================================================