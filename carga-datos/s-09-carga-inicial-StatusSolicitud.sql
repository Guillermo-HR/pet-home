--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 


PROMPT ========================================================
PROMPT Carga datos status solicitud
PROMPT ========================================================

INSERT INTO status_solicitud(status_solicitud_id, clave, descripcion)
  VALUES(1, 1, 'PENDIENTE');
INSERT INTO status_solicitud(status_solicitud_id, clave, descripcion)
  VALUES(2, 2, 'APROBADA');
INSERT INTO status_solicitud(status_solicitud_id, clave, descripcion)
  VALUES(3, 3, 'RECHAZADA');

COMMIT;