--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos

-- Conectarse a la base de datos
PROMPT ========================================================
PROMPT Conectando a la PDB
CONNECT ah_admin_rol/contrasena@ghrbd_s1
PROMPT s-06-indices-inicial.sql
PROMPT ========================================================

DROP INDEX IF EXISTS cliente_username_iuk;
CREATE UNIQUE INDEX cliente_username_iuk 
  ON cliente(username);

DROP INDEX IF EXISTS mascota_folio_iuk;
CREATE UNIQUE INDEX mascota_folio_iuk
  ON mascota(folio);


-- Salir de la base
PROMPT ========================================================
PROMPT Saliendo de la PDB
DISCONNECT;
PROMPT ========================================================