--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos centro operativo-Refugio-Web
PROMPT ========================================================

-- Insertar registro para el refugio 1
INSERT INTO centro_refugio_web (url, centro_refugio_id)
VALUES ('http://www.refugioesperanza.com', 1);

-- Insertar registro para el refugio 2
INSERT INTO centro_refugio_web (url, centro_refugio_id)
VALUES ('http://www.refugioanimal.com', 2);

-- Insertar registro para el refugio 3
INSERT INTO centro_refugio_web (url, centro_refugio_id)
VALUES ('http://www.refugiohogar.com', 3);

COMMIT;