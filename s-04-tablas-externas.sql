--@Autor: Aburto López Roberto
--@Fecha: 04/10/2024
--@Descripción: Se crea una tabla externa, se crea el archivo .csv


define p_usuario='ah_proy_admin'

-- Password del usuario empleado en el proyecto para todos los usuarios 
define p_usuario_pass='contrasena'

-- Password del usuario sys
define p_sys_password='system1'

---Alias de servicio de la PDB
define p_pdb='ralbd_s1'
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
    tiempo_entrega_dias VARCHAR2(3),
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
                    tiempo_entrega_dias,
                    estado_contrato) 
    ) 
    LOCATION('proveedor_table_ext.csv')
) REJECT LIMIT UNLIMITED;

PROMPT Creando el directorio /unam/bd/proyecto/pet-home en caso de que no exista
!mkdir -p /unam/bd/Proyecto/pet-home/tabla-externa

PROMPT Creando un archivo csv de prueba
!touch /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv

!echo "100,Pet Supplies,555-1234,Comida,100.00,7,Activo" > /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "101,Medicamentos Veterinarios,555-2345,Medicamentos,250.50,10 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "102,Accesorios PetWorld,555-3456,Accesorios,30.75,5 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "103,Instrumental VetMed,555-4567,Instrumental Médico,450.00,15 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "104,Peluquería Mascotitas,555-5678,Servicios,75.00,3 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "105,Comida Orgánica PetCare,555-6789,Comida,120.00,7 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "106,Tienda Happy Pets,555-7890,Accesorios,40.00,4 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "107,MedicVet Solutions,555-8901,Medicamentos,180.00,12 ,Inactivo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "108,Distribuidora VetTools,555-9012,Instrumental Médico,520.00,18 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "109,Peluquería Happy Tails,555-0123,Servicios,95.00,5 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "110,Alimentos Premium Pets,555-1235,Comida,135.00,8 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "111,VetTech Pro,555-2346,Medicamentos,300.00,11 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "112,Accesorios Fancy Pets,555-3457,Accesorios,25.00,6 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "113,Instrumental Médico Animed,555-4568,Instrumental Médico,490.00,20 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "114,Comida Natural VetCare,555-5679,Comida,155.00,9 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "115,Tienda Accesorios Felices,555-6780,Accesorios,50.00,4 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "116,Medicamentos ExpressVet,555-7891,Medicamentos,275.00,13 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "117,Alimentos Organics Pro,555-8902,Comida,165.00,7 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "118,Distribuidora VetEquipos,555-9013,Instrumental Médico,600.00,22 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "119,Servicios Groomer Pro,555-0124,Servicios,85.00,3 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "120,NutriPet Alimentos,555-1237,Comida,140.00,6 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "121,Accesorios TotalPets,555-2348,Accesorios,65.00,5 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "122,Medicamentos PharmaVet,555-3459,Medicamentos,320.00,14 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "123,VetTools Equipos,555-4560,Instrumental Médico,550.00,18 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "124,Peluquería Peludos,555-5671,Servicios,75.00,4 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "125,Distribuidora SuperPets,555-6782,Comida,150.00,8 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "126,Accesorios PetLovers,555-7893,Accesorios,55.00,5 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv
!echo "127,Medicamentos MascotVet,555-8904,Medicamentos,275.00,130 ,Activo" >> /unam/bd/Proyecto/pet-home/tabla-externa/proveedor_table_ext.csv

PROMPT Cambiando permisos
!chmod 755 /unam/bd/Proyecto/pet-home
!chmod 777 /unam/bd/Proyecto/pet-home/tabla-externa

PROMPT Mostrando los datos de la tabla proveedor_ext
COL nombre FORMAT A40
COL telefono FORMAT A20
COL tipo_producto FORMAT A100
COL precio_unitario FORMAT 999999999.99
COL tiempo_entrega_dias FORMAT A50

SELECT * FROM proveedor_ext;
