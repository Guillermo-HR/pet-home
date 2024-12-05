--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos status mascota
PROMPT ========================================================


INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(1, 1, 'EN_REFUGIO');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(2, 2, 'DISPONIBLE_ADOPCIÓN');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(3, 3, 'SOLICITADA_ADOPCION');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(4, 4, 'ADOPTADA'); 
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(5, 5, 'ENFERMA');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(6, 6, 'FALLECIDA_REFUGIO');
INSERT INTO status_mascota(status_mascota_id, clave, descripcion)
  VALUES(7, 7, 'FALLECIDA_HOGAR'); 

COMMIT;