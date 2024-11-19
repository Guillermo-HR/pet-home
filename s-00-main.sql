

--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: MAIN

-- Conectarse a la base de datos
PROMPT ========================================================
PROMPT Conectando a la PDB
CONNECT ah_admin_rol/contrasena@ghrbd_s1
PROMPT s-06-indices-inicial.sql
PROMPT ========================================================

PROMPT Eliminando todas las tablas y purgándolas
BEGIN
    FOR rec IN (
        SELECT table_name FROM user_tables
        WHERE table_name IN (
            'DONATIVO', 
            'CLIENTE',
            'STATUS_SOLICITUD',
            'CLIENTE_MASCOTA_SOLICITUD', 
            'HISTORICO_STATUS_MASCOTA',
            'MASCOTA', 
            'STATUS_MASCOTA', 
            'MASCOTA_TIPO', 
            'ORIGEN', 
            'MONITOREO_CAUTIVERIO',
            'EMPLEADO_GRADO', 
            'EMPLEADO', 
            'REVISION',
            'CENTRO_OPERATIVO', 
            'CLINICA',
            'OFICINA', 
            'CENTRO_REFUGIO',
            'CENTRO_REFUGIO_WEB' 
        )
    ) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS PURGE';
        EXCEPTION
            WHEN OTHERS THEN
                -- Si hay algún error, continúa con la siguiente tabla
                NULL;
        END;
    END LOOP;
END;
/

PROMPT Eliminando secuencias

BEGIN
    FOR rec IN (
        SELECT sequence_name FROM user_sequences
        WHERE sequence_name 
            IN ('CLIENTE_ID_SEQ', 
                'DONATIVO_ID_SEQ', 
                'CENTRO_OPERATIVO_ID_SEQ', 
                'CLIENTE_MASCOTA_SOLICITUD_ID_SEQ', 
                'MONITOREO_CAUTIVERIO_ID_SEQ', 
                'EMPLEADO_ID_SEQ',
                'EMPLEADO_GRADO_ID_SEQ', 
                'CENTRO_REFUGIO_WEB_ID_SEQ', 
                'HISTORICO_STATUS_MASCOTA_ID_SEQ', 
                'REVISION_ID_SEQ', 
                'MASCOTA_ID_SEQ'
                )
    ) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || rec.sequence_name;
        EXCEPTION
            WHEN OTHERS THEN
                -- Si hay algún error, continúa con la siguiente secuencia
                NULL;
        END;
    END LOOP;
END;
/



/*


* check cliente.contraseña que cumpla algunas reglas
* triger 1: para actualizar los estatus 
* vista 1: mostrar solicitudes, se ponen los datos del cliente, datos de las mascotas en las que tiene solicitud, estatus de la solicitud, si la solicitud es rechazada poner el motivo, si es aceptada poner la fecha de adopción, si es pendiente poner fecha del último monitoreo y calificación 
* * agregar tabla estatus_solicitud puede tener 3 valores (pendiente, aceptada o rechazada)
* tabla temporal: subtipos
* vista 2: datos cliente, número de donativos, total de solicitudes, total solicitudes de cada tipo
*/



-- Salir de la base
PROMPT ========================================================
PROMPT Saliendo de la PDB
DISCONNECT;
PROMPT ========================================================


