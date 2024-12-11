--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de tablas temporales

PROMPT ========================================================
PROMPT Creación de tablas temporales
PROMPT s-03-tablas-temporales.sql
PROMPT ========================================================

-- Tabla temporal privada on commit drop definition
CREATE PRIVATE TEMPORARY TABLE ora$ptt_reporte_mensual_clinica(
  clinica_id NUMBER(2, 0),
  anio VARCHAR2(4),
  mes VARCHAR2(2),
  numero_consultas NUMBER(5, 0),
  ganancias_totales NUMBER(10, 2)
) ON COMMIT PRESERVE DEFINITION;
  
-- Insertar datos en la tabla temporal
INSERT INTO ora$ptt_reporte_mensual_clinica  
SELECT r.clinica_id, TO_CHAR(r.fecha, 'YYYY') anio, TO_CHAR(r.fecha, 'MM') mes, 
  COUNT(*) numero_colsultas, SUM(r.costo) ganancias_totales
FROM clinica c, revision r
WHERE c.clinica_id(+) = r.clinica_id 
  --AND TO_CHAR(r.fecha, 'YYYY') = 2024
  --AND r.clinica_id = 2
GROUP BY r.clinica_id, anio, mes
ORDER BY r.clinica_id, anio, mes ASC;

PROMPT ========================================================
PROMPT Ver los datos de la tabla temporal
PROMPT ========================================================

-- Ver datos del reporte
SELECT * from ora$ptt_reporte_mensual_clinica;

-- Tabla temporal global on commit delete rows
CREATE GLOBAL TEMPORARY TABLE solicitudes_adopcion_cliente(
  cliente_id NUMBER(3, 0),
  nobre VARCHAR2(122),
  solicitud_id NUMBER(5, 0),
  nombre_mascota VARCHAR2(40),
  foto BLOB,
  status_solicitud_id NUMBER(1,0),
  comentario VARCHAR2(1000)
) ON COMMIT DELETE ROWS;

-- Insertar datos en la tabla temporal
INSERT INTO solicitudes_adopcion_cliente
SELECT c.cliente_id, c.nombre || ' ' || c.apellido_paterno || ' ' || c.apellido_materno  nombre, 
  cms.cliente_mascota_solicitud_id solicitud_id, m.nombre nombre_mascota, mc.foto, 
  cms.status_solicitud_id, cms.comentario
FROM cliente c, cliente_mascota_solicitud cms, mascota m, monitoreo_cautiverio mc
WHERE c.cliente_id = cms.cliente_id AND
  cms.mascota_id = m.mascota_id AND
  m.mascota_id = mc.mascota_id AND
  cms.status_solicitud_id = 1;

PROMPT ========================================================
PROMPT Ver los datos de la tabla temporal
PROMPT ========================================================

-- Ver datos de las solicitudes de adopción
SELECT * from solicitudes_adopcion_cliente;

COMMIT;

select * from cliente_mascota_solicitud where status_solicitud_id = 1;