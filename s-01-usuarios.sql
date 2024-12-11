--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Creación de usuarios

PROMPT ========================================================
PROMPT Creación de usuarios
PROMPT s-01-usuarios.sql
PROMPT ========================================================
SET SERVEROUTPUT OFF

-- Limpiar usuarios y roles
PROMPT Limpiando usuarios y roles usados en el proyecto
DECLARE 
    CURSOR cur_usuarios IS 
        SELECT username FROM dba_users WHERE 
            username LIKE 'AH%'; 
    CURSOR cur_roles IS 
        SELECT role FROM dba_roles WHERE 
            role like 'AH%'; 
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
GRANT CREATE SESSION, 
    CREATE TABLE, 
    CREATE SEQUENCE, 
    CREATE VIEW, 
    CREATE TRIGGER, 
    CREATE PROCEDURE, 
    CREATE PUBLIC SYNONYM 
TO ah_admin_rol;

CREATE ROLE ah_invitado_rol;

GRANT CREATE SESSION, 
    CREATE SYNONYM 
TO ah_invitado_rol;

-- Crear usuarios
PROMPT creando usuarios
CREATE USER ah_proy_admin IDENTIFIED BY contrasena QUOTA UNLIMITED ON USERS;
GRANT ah_admin_rol TO ah_proy_admin;

CREATE USER ah_proy_invitado IDENTIFIED BY contrasena QUOTA UNLIMITED ON USERS;
GRANT ah_invitado_rol TO ah_proy_invitado;

CREATE user ah_proy_cliente IDENTIFIED BY contrasena QUOTA UNLIMITED ON USERS;
GRANT ah_invitado_rol TO ah_proy_cliente;