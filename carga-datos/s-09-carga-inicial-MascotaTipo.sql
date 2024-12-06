--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos tipo de mascota
PROMPT ========================================================

-- Insertar raza de perro con nivel de cuidado según el tamaño
INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado) 
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Chihuahua', '1');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Pomerania', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Bichón Frisé', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Shih Tzu', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Beagle', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Cocker Spaniel', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Bulldog Francés', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Dachshund', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Border Collie', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Bóxer', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Schnauzer', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Labrador Retriever', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Golden Retriever', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Rottweiler', '4');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Pastor Alemán', '4');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Doberman', '4');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Gran Danés', '5');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Mastín Inglés', '5');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Saint Bernard', '5');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Husky Siberiano', '4');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Criollo pequeño', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Criollo mediano', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Perro', 'Criollo grande', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Gato', 'Persa', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Gato', 'Siamés', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Gato', 'Maine Coon', '3');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Gato', 'Bengalí', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Gato', 'Ragdoll', '2');

INSERT INTO mascota_tipo (mascota_tipo_id, tipo, subcategoria, nivel_cuidado)  
VALUES (mascota_tipo_seq.NEXTVAL, 'Gato', 'Sphynx', '3');

COMMIT;