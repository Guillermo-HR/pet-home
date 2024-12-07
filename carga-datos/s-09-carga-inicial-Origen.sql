--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos origen mascota
PROMPT ========================================================

INSERT INTO origen(origen_id, clave, descripcion)
  VALUES(1, 1, 'Donada por un cliente');
INSERT INTO origen(origen_id, clave, descripcion)
  VALUES(2, 2, 'Abandonada envía pública');
INSERT INTO origen(origen_id, clave, descripcion)
  VALUES(3, 3, 'Nacida en cautiverio');

COMMIT;