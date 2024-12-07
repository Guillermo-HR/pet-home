--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos de los centros operativos
PROMPT ========================================================

-- Refugios
INSERT INTO centro_operativo (centro_operativo_id, es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES (centro_operativo_seq.NEXTVAL, '1', '0', '0', 'RR001', 'Refugio de Animales Esperanza', 'Avenida de la Paz 123, Ciudad', '19.432608', '-99.133209', 1);

INSERT INTO centro_refugio (centro_refugio_id, capacidad_maxima, numero_registro, logo, lema, refugio_alterno)
VALUES (centro_operativo_seq.CURRVAL, 50, 'MX001056', EMPTY_BLOB(), 'Refugio de Esperanza', NULL);

INSERT INTO centro_refugio_web (centro_refugio_web_id, url, centro_refugio_id)
VALUES (centro_refugio_web_seq.NEXTVAL, 'http://www.refugioesperanza.com', centro_operativo_seq.CURRVAL);

-- Refugios con clínica
INSERT INTO centro_operativo (centro_operativo_id, es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES (centro_operativo_seq.NEXTVAL, '1', '1', '0', 'RC001', 'Refugio y Clínica Veterinaria Los Amigos', 'Avenida de los Animales 345, Ciudad', '19.430000', '-99.134000', 6);

INSERT INTO centro_refugio (centro_refugio_id, capacidad_maxima, numero_registro, logo, lema, refugio_alterno)
VALUES (centro_operativo_seq.CURRVAL, 120, 'MX005002', EMPTY_BLOB(), 'Refugio Animal Salvavidas', NULL);

INSERT INTO centro_refugio_web (centro_refugio_web_id, url, centro_refugio_id)
VALUES (centro_refugio_web_seq.NEXTVAL, 'http://www.refugioanimal.com', centro_operativo_seq.CURRVAL);

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (centro_operativo_seq.CURRVAL, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS'), '5551234567', '5557654321');

--
INSERT INTO centro_operativo (centro_operativo_id, es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES (centro_operativo_seq.NEXTVAL, '1', '1', '0', 'RC002', 'Refugio y Clínica Veterinaria Corazón Animal', 'Calle de la Esperanza 678, Ciudad', '19.428000', '-99.140000', 7);

INSERT INTO centro_refugio (centro_refugio_id, capacidad_maxima, numero_registro, logo, lema, refugio_alterno)
VALUES (centro_operativo_seq.CURRVAL, 40, 'MX010103', EMPTY_BLOB(), 'Refugio y Hogar Animal', 2);

INSERT INTO centro_refugio_web (centro_refugio_web_id, url, centro_refugio_id)
VALUES (centro_refugio_web_seq.NEXTVAL, 'http://www.refugiohogar.com', centro_operativo_seq.CURRVAL);

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (centro_operativo_seq.CURRVAL, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS'), '5552345678', '5558765432');

-- Clínicas
INSERT INTO centro_operativo (centro_operativo_id, es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES (centro_operativo_seq.NEXTVAL, '0', '1', '0', 'CC001', 'Clínica Veterinaria San Juan', 'Calle del Sol 456, Ciudad', '19.425000', '-99.133500', 2);

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (centro_operativo_seq.CURRVAL, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS'), '5553456789', '5559876543');

--
INSERT INTO centro_operativo (centro_operativo_id, es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES (centro_operativo_seq.NEXTVAL, '0', '1', '0', 'CC002', 'Clínica Veterinaria Bienestar Animal', 'Calle del Río 789, Ciudad', '19.418000', '-99.142500', 3);

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (centro_operativo_seq.CURRVAL, TO_DATE('00:00:00', 'HH24:MI:SS'), TO_DATE('23:59:59', 'HH24:MI:SS'), '5554567890', '5550987654');

--
INSERT INTO centro_operativo (centro_operativo_id, es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES (centro_operativo_seq.NEXTVAL, '0', '1', '0', 'CC003', 'Clínica Veterinaria Vida Animal', 'Boulevard de la Reforma 202, Ciudad', '19.416000', '-99.130000', 4);

INSERT INTO clinica (clinica_id, hora_atencion_inicio, hora_atencion_fin, telefono, telefono_emergencia)
VALUES (centro_operativo_seq.CURRVAL, TO_DATE('00:00:00', 'HH24:MI:SS'), TO_DATE('23:59:59', 'HH24:MI:SS'), '5555678901', '5551098765');

-- Oficinas
INSERT INTO centro_operativo (centro_operativo_id, es_refugio, es_clinica, es_oficina, codigo, nombre, direccion, latitud, longitud, gerente_id)
VALUES (centro_operativo_seq.NEXTVAL, '0', '0', '1', 'OO001', 'Oficina Administrativa Central', 'Avenida del Centro 555, Ciudad', '19.419000', '-99.130500', 5);

INSERT INTO oficina (oficina_id, rfc, firma_electronica, responsable_legal)
VALUES (centro_operativo_seq.CURRVAL, 'PEG9001011H4', EMPTY_BLOB(), 'Juan Pérez Gómez');

COMMIT;