--@Autor: Aburto López Roberto
--@Fecha: 04/10/2024
--@Descripción: Se crea una tabla externa, se crea el archivo .csv

PROMPT ========================================================
PROMPT Creación de tablas externas
PROMPT s-04-tablas-externas.sql
PROMPT ========================================================

PROMPT Conectando como sys
CONNECT sys/&&p_sys_password@&&p_pdb AS SYSDBA

PROMPT Creando directorio pet_home_extern_table_dir
CREATE OR REPLACE DIRECTORY pet_home_extern_table_dir AS '/unam/bd/Proyecto/pet-home/tabla-externa';
GRANT READ, WRITE ON DIRECTORY pet_home_extern_table_dir TO &&p_usuario;


PROMPT Conectando con usuario admin para crear la tabla externa
CONNECT &&p_usuario/&&p_usuario_pass@&&p_pdb

PROMPT Creando tabla externa
DROP TABLE IF EXISTS proveedor_ext;
CREATE TABLE proveedor_ext (
    proveedor_id NUMBER(10, 0),
    nombre VARCHAR2(40),
    telefono VARCHAR2(40),
    tipo_producto VARCHAR2(100),
    precio_unitario NUMBER(10, 2),
    tiempo_entrega VARCHAR2(50),
    estado_contrato VARCHAR2(50)
) ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER 
    DEFAULT DIRECTORY pet_home_extern_table_dir 
    ACCESS PARAMETERS( 
        RECORDS DELIMITED BY NEWLINE 
                BADFILE pet_home_extern_table_dir:'proveedor_ext_bad.log' 
                LOGFILE pet_home_extern_table_dir:'proveedor_ext.log' 
                FIELDS TERMINATED BY ',' 
                LRTRIM 
                MISSING FIELD VALUES ARE NULL ( 
                    proveedor_id,
                    nombre,
                    telefono,
                    tipo_producto,
                    precio_unitario,
                    tiempo_entrega,
                    estado_contrato) 
    ) 
    LOCATION('proveedor_table_ext.csv')
) REJECT LIMIT UNLIMITED;

PROMPT Creando el directorio /unam/bd/proyecto/pet-home en caso de que no exista
!mkdir -p /unam/bd/Proyecto/pet-home/tabla-externa

PROMPT Creando un archivo csv de prueba
!touch /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv

!echo "100,Pet Supplies,555-1234,Alimentos,100.00,7 días,Activo" > /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "101,Medicamentos Veterinarios,555-2345,Medicamentos,250.50,10 días,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "102,Accesorios PetWorld,555-3456,Accesorios,30.75,5 días,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "103,Alimentos NutriPets,555-4567,Alimentos,120.00,7 días,Inactivo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "104,Distribuciones PetShop,555-5678,Alimentos,150.00,8 días,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "105,Tienda Animalia,555-6789,Accesorios,45.00,5 días,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "106,Suministros Veterinarios,555-7890,Medicamentos,300.00,12 días,Inactivo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "107,Peluquería Animal,555-8901,Servicios,80.00,3 días,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "108,Alimentos PetCare,555-9012,Alimentos,120.50,7 días,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "109,Accesorios del Pet,555-0123,Accesorios,60.00,4 días,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv


PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home
!chmod 777 /unam/bd/Proyecto/pet-home/tabla-externa

PROMPT Mostrando los datos de la tabla proveedor_ext
COL nombre FORMAT A40
COL telefono FORMAT A20
COL tipo_producto FORMAT A100
COL precio_unitario FORMAT 999999999.99
COL tiempo_entrega FORMAT A50

SELECT * FROM proveedor_ext;
