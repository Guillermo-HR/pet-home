--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla: nombre_perro

PROMPT ========================================================
PROMPT Carga datos de los posibles nombres de perros
PROMPT ========================================================

INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Firulais');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Rex');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Boby');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Max');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Rocky');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Bruno');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Lucky');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Sultan');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Duke');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Ringo');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Rusty');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Rufus');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Rocco');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Bonnie');
INSERT INTO nombre_perro (nombre_perro_id, nombre)
VALUES (nombre_perro_seq.NEXTVAL, 'Bella');

COMMIT;