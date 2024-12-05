--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos centro operativo-Refugio
PROMPT ========================================================

INSERT INTO centro_refugio (centro_refugio_id, capacidad_maxima, numero_registro, logo, lema, refugio_alterno)
VALUES (1, 35, 'R001', EMPTY_BLOB(), 'Refugio de Esperanza', NULL);

INSERT INTO centro_refugio (centro_refugio_id, capacidad_maxima, numero_registro, logo, lema, refugio_alterno)
VALUES (2, 70, 'R002', EMPTY_BLOB(), 'Refugio Animal Salvavidas', NULL);

INSERT INTO centro_refugio (centro_refugio_id, capacidad_maxima, numero_registro, logo, lema, refugio_alterno)
VALUES (3, 40, 'R003', EMPTY_BLOB(), 'Refugio y Hogar Animal', 2);

COMMIT;