PROMPT ========================================================
PROMPT Creación de sinónimos
PROMPT s-07-sinonimos.sql
PROMPT ========================================================

-- Sinonimos publicos de ah_proy_admin

-- Dar permisos a usuarios
GRANT INSERT ON ah_proy_admin.cliente_mascota_solicitud TO ah_proy_cliente;
GRANT SELECT ON ah_proy_admin.mascota_mascota_tipo_monitoreo_cautiverio_centro_refugio TO ah_proy_cliente;
GRANT SELECT ON ah_proy_admin.cliente_cliente_mascota_solicitud_mascota_revision TO ah_proy_cliente;
GRANT SELECT ON ah_proy_admin.empleado_empleado_grado TO ah_proy_invitado;
GRANT SELECT ON ah_proy_admin.centro_operativo_centro_refugio_mascota TO ah_proy_invitado;

-- Conectar a la base de datos como usuario ah_proy_cliente
PROMPT ========================================================
PROMPT Conectando a la PDB como ah_proy_cliente
CONNECT ah_proy_cliente/&&p_usuario_pass@&&p_pdb
PROMPT ========================================================
CREATE SYNONYM mascotas_disponibles FOR ah_proy_admin.mascota_mascota_tipo_monitoreo_cautiverio_centro_refugio;
CREATE SYNONYM mascotas_adoptadas FOR ah_proy_admin.cliente_cliente_mascota_solicitud_mascota_revision;

-- Conectar a la base de datos como usuario ah_proy_invitado
PROMPT ========================================================
PROMPT Conectando a la PDB como ah_proy_cliente
CONNECT ah_proy_cliente/&&p_usuario_pass@&&p_pdb
PROMPT ========================================================
CREATE SYNONYM empleados FOR ah_proy_admin.empleado_empleado_grado;
CREATE SYNONYM refugios FOR ah_proy_admin.centro_operativo_centro_refugio_mascota;

-- Conectar a la base de datos como usuario ah_proy_cliente
PROMPT ========================================================
PROMPT Conectando a la PDB como ah_proy_admin
CONNECT ah_proy_admin/&&p_usuario_pass@&&p_pdb
PROMPT ========================================================

COMMIT;