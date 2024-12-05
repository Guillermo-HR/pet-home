--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos centro operativo-clinica
PROMPT ========================================================

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (2, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS'), '5551234567', '5557654321');

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (3, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS'), '5552345678', '5558765432');

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (4, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS'), '5553456789', '5559876543');

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (5, TO_DATE('00:00:00', 'HH24:MI:SS'), TO_DATE('23:59:59', 'HH24:MI:SS'), '5554567890', '5550987654');

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (6, TO_DATE('00:00:00', 'HH24:MI:SS'), TO_DATE('23:59:59', 'HH24:MI:SS'), '5555678901', '5551098765');

COMMIT;