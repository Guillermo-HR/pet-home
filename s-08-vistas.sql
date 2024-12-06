PROMPT ========================================================
PROMPT Creación de vistas
PROMPT s-08-vistas.sql
PROMPT ========================================================

-- Vista mascotas_disponibles
CREATE OR REPLACE VIEW mascota_mascota_tipo_monitoreo_cautiverio_centro_refugio AS
SELECT m.mascota_id, m.nombre, m.fecha_ingreso, (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM m.fecha_nacimiento)) edad,
  mt.tipo, mt.subcategoria, mc.foto, co.direccion
FROM mascota m, mascota_tipo mt, monitoreo_cautiverio mc, centro_operativo co
WHERE m.mascota_tipo_id = mt.mascota_tipo_id AND
  m.mascota_id = mc.mascota_id AND
  m.refugio_id = co.centro_operativo_id AND
  mc.monitoreo_cautiverio_id = (
    SELECT monitoreo_cautiverio_id
    FROM monitoreo_cautiverio mc1
    WHERE mc1.mascota_id = m.mascota_id
    ORDER BY mc1.fecha DESC
    FETCH FIRST 1 ROW ONLY
  )
ORDER BY m.mascota_id ASC;

-- Vista mascotas adoptadas
CREATE OR REPLACE VIEW cliente_cliente_mascota_solicitud_mascota_revision AS
SELECT c.cliente_id, c.nombre || ' ' || c.apellido_paterno || ' ' || c.apellido_materno nombre, m.fecha_adopcion,
  (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM m.fecha_nacimiento)) edad, r.fecha fecha_ultima_revision, 
  (((TRUNC(SYSDATE) - r.fecha)/30) > 6) revision_pendiente
FROM cliente c, cliente_mascota_solicitud cms, mascota m, revision r
WHERE c.cliente_id = cms.cliente_id AND
  cms.mascota_id = m.mascota_id AND
  r.mascota_id = m.mascota_id AND
  r.numero_revision = (
    SELECT COUNT(*)
    FROM revision r1
    WHERE r1.mascota_id = m.mascota_id
  )
ORDER BY m.fecha_adopcion ASC;

-- Vista empleados
CREATE OR REPLACE VIEW empleado_empleado_grado AS
SELECT e.empleado_id, e.nombre || ' ' || e.apellido_paterno || ' ' || e.apellido_materno nombre, e.es_gerente, e.es_veterinario,
  e.es_administrativo, eg.titulo, e.fecha_ingreso, co.centro_operativo_id "Gerente del centro"
FROM empleado e, empleado_grado eg, centro_operativo co
WHERE e.empleado_id = eg.empleado_id AND
  e.empleado_id = co.gerente_id(+);

-- Vista centro_operativo_centro_refugio_mascota
CREATE OR REPLACE VIEW centro_operativo_centro_refugio_mascota AS
SELECT co.centro_operativo_id, co.direccion, cr.numero_registro, cr.capacidad_maxima, (COUNT(*) - 1) mascotas_actuales
FROM centro_operativo co, centro_refugio cr, mascota m
WHERE co.centro_operativo_id = cr.centro_refugio_id AND
  m.refugio_id(+) = cr.centro_refugio_id
GROUP BY co.centro_operativo_id, co.direccion, cr.numero_registro, cr.capacidad_maxima
ORDER BY co.centro_operativo_id ASC;

COMMIT;