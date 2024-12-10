--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: MAIN

--Modificar las siguientes variables en caso de ser necesario

define p_usuario='ah_proy_admin' 
define p_usuario_pass='contrasena'
define p_sys_password='system1'
define p_pdb='ghrbd_s1'



SET SERVEROUTPUT ON
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

-- Crear trigger 1
@s-11-historico-status-mascota-trigger.sql

-- Crear trigger 2
@s-11-gestion-solicitud-mascota-trigger.sql

-- Crear función 1
@s-15-fx-generar-folio.sql

-- Crear función 2
@s-15-fx-generar-numero-revision.sql

-- Crear procedimiento almacenado 1
@s-13-p-agregar-hijos.sql

-- Crear procedimiento almacenado 2
@s-13-p-lob-carga-foto.sql

-- Crear procedimiento almacenado 3
@s-13-p-lob-descarga-imagen-disco.sql

-- Crear procedimiento almacenado 4
@s-13-p-historial-clinico.sql

-- Cargar datos
@/unam/bd/Proyecto/pet-home/carga-datos/s-09-carga-inicial.sql

-- Crear vistas
@s-08-vistas.sql

-- Crear sinónimos
@s-07-sinonimos.sql

-- Crear tablas temporales
@s-03-tablas-temporales.sql

-- Ejectuar pruebas
PROMPT ========================================================
PROMPT Ejecutando pruebas
PROMPT ========================================================

-- Prueba trigger 1
@s-12-historico-status-mascota-trigger-prueba.sql

-- Prueba trigger 2
@s-12-gestion-solicitud-mascota-trigger-prueba.sql

-- Prueba función 1
@s-16-fx-generar-folio-prueba.sql

-- Prueba función 2
@s-16-fx-generar-numero-revision-prueba.sql

-- Prueba procedimiento almacenado 1

-- Prueba procedimiento almacenado 2
@s-14-p-lob-carga-foto-prueba.sql

-- Prueba procedimiento almacenado 3
@s-14-p-lob-descarga-imagen-disco-prueba.sql

-- Prueba procedimiento almacenado 4
@s-14-historial-clinico-prueba.sql

-- Validador
PROMPT ========================================================
PROMPT Validador
PROMPT ========================================================

-- Validador
@resultados-proyecto-final.sql

COMMIT;

-- Consultas
PROMPT ========================================================
PROMPT Consultas
PROMPT ========================================================

-- Consultas
@s-10-consultas.sql

-- Salir de la base
PROMPT ========================================================
--PROMPT Saliendo de la PDB
--DISCONNECT;
PROMPT ========================================================