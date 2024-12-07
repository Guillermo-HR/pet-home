--@Autor: Aburto López Roberto
--@Fecha: 06/12/2024
--@Descripción: consultas

/*
Para iniciar el proceso de reproducción de las mascotas, 
se requiere identificar aquellas que cumplan con las siguientes condiciones:

    Nunca han sido madres.
    Son de tipo "Gato".
    No presentan un estado de salud catalogado como "Enferma".
    Su origen es "Nacida en cautiverio".

El resultado debe mostrar el nombre y la edad de las mascotas que cumplen con estos criterios.
La consulta debe expresarse en términos de álgebra relacional.
*/

SELECT m.nombre, 
       (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM m.fecha_nacimiento)) AS edad
FROM mascota m
WHERE m.mascota_tipo_id IN (
    SELECT mascota_tipo_id
    FROM mascota_tipo
    WHERE UPPER(tipo) = 'GATO'
)
MINUS
SELECT m.nombre, 
       (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM m.fecha_nacimiento)) AS edad
FROM mascota m
WHERE m.status_mascota_id IN (
    SELECT status_mascota_id
    FROM status_mascota
    WHERE UPPER(clave) = 'ENFERMA'
)
MINUS
SELECT m.nombre, 
       (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM m.fecha_nacimiento)) AS edad
FROM mascota m
WHERE m.origen_id NOT IN (
    SELECT origen_id
    FROM origen
    WHERE descripcion = 'Nacida en cautiverio'
)
MINUS
SELECT m.nombre, 
       (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM m.fecha_nacimiento)) AS edad
FROM mascota m
WHERE m.mascota_id IN (
    SELECT padre_id FROM mascota
    UNION
    SELECT madre_id FROM mascota
);
