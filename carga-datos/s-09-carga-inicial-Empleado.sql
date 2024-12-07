--@Autor(es): Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla empleado

PROMPT ========================================================
PROMPT Carga datos empleados
PROMPT ========================================================

-- Gerentes (id 1-5)
INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '1', '0', '0', TO_DATE('2020-10-15', 'YYYY-MM-DD'), 'JUA123456HDFNRN010', 'juan.gomez@email.com', 'Juan', 'Gómez', 'Ramírez', 35000.12);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '1', '0', '0', TO_DATE('2020-12-03', 'YYYY-MM-DD'), 'MAR123456HDFRSD021', 'maria.lopez@email.com', 'María', 'López', 'Díaz', 38000.50);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '1', '0', '0', TO_DATE('2021-02-10', 'YYYY-MM-DD'), 'CAR123456HDFQPD032', 'carlos.martinez@email.com', 'Carlos', 'Martínez', 'Pérez', 31000.75);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '1', '0', '0', TO_DATE('2021-05-21', 'YYYY-MM-DD'), 'ANA123456HDFXCD043', 'ana.torres@email.com', 'Ana', 'Torres', 'Castillo', 40000.00);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '1', '0', '0', TO_DATE('2021-07-15', 'YYYY-MM-DD'), 'PED123456HDFLPF025', 'pedro.sanchez@email.com', 'Pedro', 'Sánchez', 'Flores', 30000.89);

-- Gerentes-Veterinarios (id 6-7)
INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '1', '1', '0', TO_DATE('2021-09-30', 'YYYY-MM-DD'), 'LUZ123456HDFPRL064', 'luz.mendoza@email.com', 'Luz', 'Mendoza', 'León', 43400.00);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '1', '1', '0', TO_DATE('2022-03-10', 'YYYY-MM-DD'), 'JOR123456HDFKRL057', 'jorge.castro@email.com', 'Jorge', 'Castro', 'Hernández', 40267.00);

-- Veterinarios (id 8-22)
INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2020-10-07', 'YYYY-MM-DD'), 'ALE123456HDFGFL038', 'alejandro.reyes@email.com', 'Alejandro', 'Reyes', 'López', 23000.34);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2020-10-20', 'YYYY-MM-DD'), 'MAR123456HDFVNB098', 'martha.hernandez@email.com', 'Martha', 'Hernández', 'Vázquez', 24000.40);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2020-11-01', 'YYYY-MM-DD'), 'JOR123456HDFDNL107', 'jorge.soto@email.com', 'Jorge', 'Soto', 'Pérez', 26000.55);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2021-01-18', 'YYYY-MM-DD'), 'LUIS123456HDFLJK11', 'luis.martin@email.com', 'Luis', 'Martín', 'Jiménez', 23000.20);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2021-02-04', 'YYYY-MM-DD'), 'CYN123456HDFPQR128', 'cynthia.campuzano@email.com', 'Cynthia', 'Campuzano', 'Reyes', 28000.60);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2020-10-17', 'YYYY-MM-DD'), 'JUL123456HDFPRT017', 'julio.hernandez@email.com', 'Julio', 'Hernández', 'Sánchez', 24000.50);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2021-01-05', 'YYYY-MM-DD'), 'CAR123456HDFLNT026', 'carla.garcia@email.com', 'Carla', 'Garcia', 'Ruiz', 26500.75);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2021-03-03', 'YYYY-MM-DD'), 'PED123456HDFJLP053', 'pedro.carrillo@email.com', 'Pedro', 'Carrillo', 'Gómez', 22000.60);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2021-06-17', 'YYYY-MM-DD'), 'ELI123456HDFTRS034', 'elisabeth.martin@email.com', 'Elisabeth', 'Martín', 'López', 23000.90);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2021-09-10', 'YYYY-MM-DD'), 'AND123456HDFNSL057', 'andrés.fuentes@email.com', 'Andrés', 'Fuentes', 'Ramírez', 28000.40);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2022-02-22', 'YYYY-MM-DD'), 'ROS123456HDFQWL063', 'rosa.vazquez@email.com', 'Rosa', 'Vázquez', 'Jiménez', 29000.55);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2022-04-30', 'YYYY-MM-DD'), 'JOR123456HDFTRN057', 'jorge.diaz@email.com', 'Jorge', 'Díaz', 'Moreno', 25500.45);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2022-07-12', 'YYYY-MM-DD'), 'MIG123456HDFJDK028', 'miguel.mendoza@email.com', 'Miguel', 'Mendoza', 'Serrano', 26000.30);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2022-09-20', 'YYYY-MM-DD'), 'JES123456HDFLDF098', 'jesica.gomez@email.com', 'Jesica', 'Gómez', 'Torres', 27000.65);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '0', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'ALF123456HDFPKN105', 'alfredo.crespo@email.com', 'Alfredo', 'Crespo', 'Alvarado', 24000.90);

-- Administrativos (id 23-32)
INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2020-11-15', 'YYYY-MM-DD'), 'ALE123456HDFSRN130', 'alejandra.nava@email.com', 'Alejandra', 'Nava', 'Sánchez', 20000.40);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2020-12-08', 'YYYY-MM-DD'), 'CAR123456HDFLRN140', 'carlos.mejia@email.com', 'Carlos', 'Mejía', 'Rodríguez', 25000.75);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2021-03-17', 'YYYY-MM-DD'), 'MAR123456HDFNJK152', 'martha.mora@email.com', 'Martha', 'Mora', 'Vázquez', 22000.60);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2021-06-30', 'YYYY-MM-DD'), 'FEL123456HDFNRD012', 'felipe.jimenez@email.com', 'Felipe', 'Jiménez', 'Rodríguez', 26000.15);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2021-07-25', 'YYYY-MM-DD'), 'ROS123456HDFGRD026', 'rosa.moreno@email.com', 'Rosa', 'Moreno', 'González', 28000.50);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2021-08-11', 'YYYY-MM-DD'), 'JOR123456HDFPFL031', 'jorge.mendoza@email.com', 'Jorge', 'Mendoza', 'Flores', 31000.70);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2021-10-02', 'YYYY-MM-DD'), 'LIL123456HDFQWF049', 'lilia.garcia@email.com', 'Lilia', 'Garcia', 'Fernández', 35000.30);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2022-01-17', 'YYYY-MM-DD'), 'ROS123456HDFMWN025', 'rosa.carrillo@email.com', 'Rosa', 'Carrillo', 'Morales', 27000.45);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2022-04-14', 'YYYY-MM-DD'), 'RUB123456HDFXWL026', 'rubén.rojas@email.com', 'Rubén', 'Rojas', 'López', 32000.60);

INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '0', '1', TO_DATE('2022-06-30', 'YYYY-MM-DD'), 'MAR123456HDFRPL079', 'martha.martinez@email.com', 'Martha', 'Martínez', 'Salazar', 33000.80);

-- Veterinario-Administrativo (id 33)
INSERT INTO empleado (empleado_id, es_gerente, es_veterinario, es_administrativo, fecha_ingreso, curp, email, nombre, apellido_paterno, apellido_materno, sueldo)
VALUES (empleado_seq.NEXTVAL, '0', '1', '1', TO_DATE('2021-05-12', 'YYYY-MM-DD'), 'AND123456HDFVNG013', 'andrea.perez@email.com', 'Andrea', 'Pérez', 'Gutiérrez', 47390.00);

COMMIT;