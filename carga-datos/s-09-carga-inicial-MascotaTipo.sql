--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos status mascota
PROMPT ========================================================

-- Insertar raza de perro con nivel de cuidado según el tamaño
INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Chihuahua', '1');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Pomerania', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Bichón Frisé', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Shih Tzu', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Beagle', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Cocker Spaniel', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Bulldog Francés', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Dachshund', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Border Collie', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Bóxer', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Schnauzer', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Labrador Retriever', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Golden Retriever', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Rottweiler', '4');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Pastor Alemán', '4');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Doberman', '4');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Gran Danés', '5');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Mastín Inglés', '5');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Saint Bernard', '5');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Husky Siberiano', '4');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Criollo pequeño', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Criollo mediano', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Perro', 'Criollo grande', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Gato', 'Persa', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Gato', 'Siamés', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Gato', 'Maine Coon', '3');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Gato', 'Bengalí', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Gato', 'Ragdoll', '2');

INSERT INTO mascota_tipo (tipo, subcategoria, nivel_cuidado) 
VALUES ('Gato', 'Sphynx', '3');

COMMIT;