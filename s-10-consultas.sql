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


/*
Para la entrega de reconocimientos al empleado del mes, se requiere identificar 
al veterinario con la mayor cantidad de diagnósticos registrados por cada tipo 
de mascota que están bajo su cuidado.
*/

SELECT e.nombre, 
       e.apellido_paterno, 
       e.apellido_materno, 
       mt.tipo AS tipo_mascota, 
       COUNT(mc.veterinario_id) AS total_diagnosticos
FROM mascota m
JOIN mascota_tipo mt 
    ON mt.mascota_tipo_id = m.mascota_tipo_id
JOIN monitoreo_cautiverio mc 
    ON mc.mascota_id = m.mascota_id
JOIN empleado e 
    ON e.empleado_id = mc.veterinario_id
GROUP BY mt.tipo, 
         mc.veterinario_id
HAVING COUNT(mc.veterinario_id) = (
    SELECT MAX(total_diagnosticos)
    FROM (
        SELECT COUNT(mc1.veterinario_id) AS total_diagnosticos
        FROM monitoreo_cautiverio mc1
        GROUP BY mc1.veterinario_id
    )
);

