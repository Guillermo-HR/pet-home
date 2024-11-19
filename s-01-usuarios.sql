--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Creación de usuarios

-- Conectarse a la base de datos
PROMPT ========================================================
PROMPT Conectando a la PDB
CONNECT sys/system1@ghrbd_s1 AS SYSDBA
PROMPT s-01-usuarios.sql
PROMPT ========================================================

-- Limpiar usuarios y roles
PROMPT Limpiando usuarios y roles usados en la practica
DECLARE 
    CURSOR cur_usuarios IS 
        SELECT username FROM dba_users WHERE 
            username LIKE 'ah%'; 
    CURSOR cur_roles IS 
        SELECT role FROM dba_roles WHERE 
            role like 'ah'; 
BEGIN
    FOR r IN cur_usuarios LOOP 
        EXECUTE IMMEDIATE 'DROP USER '||r.username||' CASCADE'; 
    END LOOP; 
    FOR r IN cur_roles LOOP 
        EXECUTE IMMEDIATE 'DROP ROLE '||r.role; 
    END LOOP; 
END; 
/

-- Crear roles
PROMPT creando roles
CREATE ROLE ah_admin_rol;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO ah_admin_rol;

CREATE ROLE ah_invitado_rol;
GRANT CREATE SESSION TO ah_invitado_rol;

-- Crear usuarios
PROMPT creando usuarios
CREATE USER ah_proy_admin_rol IDENTIFIED BY contrasena QUOTA UNLIMITED ON USERS;
GRANT ah_admin_rol TO ah_proy_admin_rol;

CREATE USER ah_proy_invitado IDENTIFIED BY contrasena QUOTA UNLIMITED ON USERS;
GRANT ah_invitado_rol TO ah_proy_invitado;

-- Salir de la base
PROMPT ========================================================
PROMPT Saliendo de la PDB
DISCONNECT;
PROMPT ========================================================