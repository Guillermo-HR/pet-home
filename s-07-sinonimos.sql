--@Autor(es):  Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 5/12/2024
--@Descripción: Creación de sinónimos
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
CREATE SYNONYM solicitudes_registradas FOR ah_proy_admin.solicitudes_adopcion_cliente;

-- Conectar a la base de datos como usuario ah_proy_invitado
PROMPT ========================================================
PROMPT Conectando a la PDB como ah_proy_invitado
CONNECT ah_proy_invitado/&&p_usuario_pass@&&p_pdb
PROMPT ========================================================
CREATE SYNONYM empleados FOR ah_proy_admin.empleado_empleado_grado;
CREATE SYNONYM refugios FOR ah_proy_admin.centro_operativo_centro_refugio_mascota;
CREATE SYNONYM reporte_mensual_clinica FOR ah_proy_admin.ora$ptt_reporte_mensual_clinica;

-- Conectar a la base de datos como usuario ah_proy_admin
PROMPT ========================================================
PROMPT Conectando a la PDB como ah_proy_admin
CONNECT ah_proy_admin/&&p_usuario_pass@&&p_pdb
PROMPT ========================================================

COMMIT;