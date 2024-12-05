--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos grado empleados
PROMPT ========================================================

-- Registros para la tabla empleado_grado
INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('12345678', 'Licenciado en Administración de Empresas', TO_DATE('2015-06-10', 'YYYY-MM-DD'), 1);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('23456789', 'Licenciado en Dirección de Empresas', TO_DATE('2016-03-25', 'YYYY-MM-DD'), 2);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('34567890', 'Licenciado en Gestión de Proyectos', TO_DATE('2017-09-14', 'YYYY-MM-DD'), 3);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('45678901', 'Licenciado en Gestión Empresarial', TO_DATE('2018-04-05', 'YYYY-MM-DD'), 4);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('56789012', 'Licenciado en Administración Estratégica', TO_DATE('2019-11-01', 'YYYY-MM-DD'), 5);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('89012345', 'Licenciado en Veterinaria', TO_DATE('2019-06-20', 'YYYY-MM-DD'), 6);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('90123456', 'Diplomado en Administración de Empresas', TO_DATE('2020-03-12', 'YYYY-MM-DD'), 6);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('99012345', 'Licenciado en Veterinaria y Zootecnia', TO_DATE('2015-06-20', 'YYYY-MM-DD'), 7);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('91234567', 'Diplomado en Gestión de Empresas', TO_DATE('2021-09-05', 'YYYY-MM-DD'), 7);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('12365678', 'Licenciado en Veterinaria', TO_DATE('2014-05-30', 'YYYY-MM-DD'), 8);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('23456780', 'Licenciado en Veterinaria', TO_DATE('2015-07-25', 'YYYY-MM-DD'), 9);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('34567590', 'Licenciado en Veterinaria', TO_DATE('2016-03-14', 'YYYY-MM-DD'), 10);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('45672901', 'Licenciado en Veterinaria', TO_DATE('2017-11-01', 'YYYY-MM-DD'), 11);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('50789012', 'Licenciado en Veterinaria', TO_DATE('2017-12-05', 'YYYY-MM-DD'), 12);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('67890123', 'Licenciado en Veterinaria', TO_DATE('2018-06-19', 'YYYY-MM-DD'), 13);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('78901234', 'Licenciado en Veterinaria', TO_DATE('2019-02-28', 'YYYY-MM-DD'), 14);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('89014345', 'Licenciado en Veterinaria', TO_DATE('2019-08-14', 'YYYY-MM-DD'), 15);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('90120456', 'Licenciado en Veterinaria', TO_DATE('2020-05-10', 'YYYY-MM-DD'), 16);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('91234167', 'Licenciado en Veterinaria', TO_DATE('2020-09-18', 'YYYY-MM-DD'), 17);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('92345678', 'Licenciado en Veterinaria', TO_DATE('2021-01-25', 'YYYY-MM-DD'), 18);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('93456789', 'Licenciado en Veterinaria', TO_DATE('2021-04-12', 'YYYY-MM-DD'), 19);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('94567890', 'Licenciado en Veterinaria', TO_DATE('2021-10-07', 'YYYY-MM-DD'), 20);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('95678901', 'Licenciado en Veterinaria', TO_DATE('2022-02-14', 'YYYY-MM-DD'), 21);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('96789012', 'Licenciado en Veterinaria', TO_DATE('2022-05-23', 'YYYY-MM-DD'), 22);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('12346789', 'Diplomado en Cirugía Veterinaria', TO_DATE('2016-11-05', 'YYYY-MM-DD'), 8);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('23457890', 'Diplomado en Medicina Veterinaria Preventiva', TO_DATE('2017-07-12', 'YYYY-MM-DD'), 10);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('34568901', 'Diplomado en Patología Animal', TO_DATE('2018-02-28', 'YYYY-MM-DD'), 12);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('45679012', 'Diplomado en Nutrición Animal', TO_DATE('2019-03-20', 'YYYY-MM-DD'), 14);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('56789123', 'Diplomado en Análisis Clínicos Veterinarios', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 17);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('67890134', 'Maestría en Cirugía Veterinaria', TO_DATE('2020-05-15', 'YYYY-MM-DD'), 9);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('78901245', 'Maestría en Medicina Veterinaria de Animales Exóticos', TO_DATE('2021-08-23', 'YYYY-MM-DD'), 13);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('89012356', 'Maestría en Salud Pública Veterinaria', TO_DATE('2022-04-05', 'YYYY-MM-DD'), 15);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('12345178', 'Licenciado en Contaduría Pública', TO_DATE('2017-05-20', 'YYYY-MM-DD'), 23);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('23406789', 'Licenciado en Administración de Negocios', TO_DATE('2016-11-14', 'YYYY-MM-DD'), 24);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('34367890', 'Licenciado en Secretariado Ejecutivo', TO_DATE('2018-02-22', 'YYYY-MM-DD'), 25);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('45678900', 'Licenciado en Gestión de Recursos Humanos', TO_DATE('2015-08-30', 'YYYY-MM-DD'), 26);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('56789112', 'Licenciado en Marketing', TO_DATE('2019-03-17', 'YYYY-MM-DD'), 27);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('61890123', 'Licenciado en Finanzas', TO_DATE('2020-07-10', 'YYYY-MM-DD'), 28);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('78909234', 'Licenciado en Comercio Internacional', TO_DATE('2017-11-05', 'YYYY-MM-DD'), 29);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('19012345', 'Licenciado en Dirección de Empresas', TO_DATE('2018-04-20', 'YYYY-MM-DD'), 30);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('90423456', 'Licenciado en Administración Pública', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 31);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('91234147', 'Licenciado en Economía', TO_DATE('2020-01-18', 'YYYY-MM-DD'), 32);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('12345672', 'Licenciado en Veterinaria', TO_DATE('2016-05-10', 'YYYY-MM-DD'), 33);

INSERT INTO empleado_grado (cedula, titulo, fecha_titulacion, empleado_id)
VALUES ('63456789', 'Licenciado en Contaduría Pública', TO_DATE('2018-09-25', 'YYYY-MM-DD'), 33);

COMMIT;