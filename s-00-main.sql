--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: MAIN


--Modificar las siguientes variables en caso de ser necesario.
--En scripts reales no deben incluirse passwords. Solo se hace para
--propósitos de pruebas y evitar escribirlos cada vez que se quiera ejecutar 

-- Nombre del usuario empleado en el proyecto
define p_usuario='ah_proy_admin'

-- Password del usuario empleado en el proyecto para todos los usuarios 
define p_usuario_pass='contrasena'

-- Password del usuario sys
define p_sys_password='system1'

---Alias de servicio de la PDB
define p_pdb='ralbd_s1'



SET SERVEROUTPUT OFF
-- Conectarse a la base de datos como sys
PROMPT ========================================================
PROMPT Conectando a la PDB
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA
PROMPT ========================================================

-- Crear los usuarios y roles
@s-01-usuarios.sql

-- Conectar a la base de datos como usuario ah_proy_cliente
PROMPT ========================================================
PROMPT Conectando a la PDB como usuario
CONNECT ah_proy_admin/&&p_usuario_pass@&&p_pdb
PROMPT ========================================================

-- Crear las secuencias
@s-05-secuencias.sql

-- Crear las tablas
@s-02-entidades.sql

--crea tabla externa
@s-04-tablas-externas.sql

-- Crear los índices
@s-06-indices.sql

-- Crear tablas externas
--@s-04-tablas-externas.sql

-- Crear vistas
@s-08-vistas.sql

-- Crear sinónimos
@s-07-sinonimos.sql

-- Crear trigger 1
@s-11-historico-status-mascota-trigger.sql

-- Crear trigger 2
@s-11-gestion-solicitud-mascota-trigger.sql

-- Crear función 1
@s-15-fx-generar-folio.sql

-- Crear procedimiento almacenado 1
@s-13-p-agregar-hijos.sql

-- Crear procedimiento almacenado 2

-- Crear función 2
@s-15-fx-generar-numero-consulta.sql

-- Crear función 3

-- Cargar datos
@carga-datos/s-09-carga-inicial.sql

-- Crear tablas temporales
@s-03-tablas-temporales.sql

-- Ejectuar pruebas
PROMPT ========================================================
PROMPT Ejecutando pruebas
PROMPT ========================================================

-- Prueba trigger 1
@s-12-historico-status-mascota-trigger-prueba.sql

-- Prueba trigger 2

-- Prueba procedimiento almacenado 1

-- Prueba procedimiento almacenado 2

-- Prueba función 1

-- Prueba función 2

-- Prueba función 3

COMMIT;

-- Salir de la base
PROMPT ========================================================
PROMPT Saliendo de la PDB
DISCONNECT;
PROMPT ========================================================