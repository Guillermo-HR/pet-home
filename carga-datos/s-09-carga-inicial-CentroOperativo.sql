--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos centro operativo
PROMPT ========================================================

INSERT INTO centro_operativo (es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES ('1', '0', '0', 'R001', 'Refugio de Animales Esperanza', 'Avenida de la Paz 123, Ciudad', '19.432608', '-99.133209', 1);

INSERT INTO centro_operativo (es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES ('1', '1', '0', 'RC001', 'Refugio y Clínica Veterinaria Los Amigos', 'Avenida de los Animales 345, Ciudad', '19.430000', '-99.134000', 6);

INSERT INTO centro_operativo (es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES ('1', '1', '0', 'RC002', 'Refugio y Clínica Veterinaria Corazón Animal', 'Calle de la Esperanza 678, Ciudad', '19.428000', '-99.140000', 7);

INSERT INTO centro_operativo (es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES ('0', '1', '0', 'C001', 'Clínica Veterinaria San Juan', 'Calle del Sol 456, Ciudad', '19.425000', '-99.133500', 2);

INSERT INTO centro_operativo (es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES ('0', '1', '0', 'C002', 'Clínica Veterinaria Bienestar Animal', 'Calle del Río 789, Ciudad', '19.418000', '-99.142500', 3);

INSERT INTO centro_operativo (es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES ('0', '1', '0', 'C003', 'Clínica Veterinaria Vida Animal', 'Boulevard de la Reforma 202, Ciudad', '19.416000', '-99.130000', 4);

INSERT INTO centro_operativo (es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES ('0', '0', '1', 'O001', 'Oficina Administrativa Central', 'Avenida del Centro 555, Ciudad', '19.419000', '-99.130500', 5);

COMMIT;