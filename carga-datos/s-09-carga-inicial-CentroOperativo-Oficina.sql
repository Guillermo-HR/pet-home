--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos centro operativo-Oficina
PROMPT ========================================================

INSERT INTO oficina (oficina_id, rfc, firma_electronica, responsable_legal)
VALUES (7, 'PEG9001011H4', EMPTY_BLOB(), 'Juan Pérez Gómez');

COMMIT;