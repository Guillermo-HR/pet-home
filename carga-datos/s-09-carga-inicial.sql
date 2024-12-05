--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Llamar a todos los archivos que hacen la carga inicial de datos

PROMPT ========================================================
PROMPT Iniciando carga de datos
PROMPT s-09-carga-inicial.sql
PROMPT ========================================================

-- Llamar a todos los archivos que hacen la carga inicial de datos
@carga-datos/s-09-carga-inicial-Empleado.sql
@carga-datos/s-09-carga-inicial-EmpleadoGrado.sql
@carga-datos/s-09-carga-inicial-CentroOperativo.sql
@carga-datos/s-09-carga-inicial-CentroOperativo-CentroRefugio.sql
@carga-datos/s-09-carga-inicial-CentroRefugioWeb.sql
@carga-datos/s-09-carga-inicial-CentroOperativo-Clinica.sql
@carga-datos/s-09-carga-inicial-CentroOperativo-Oficina.sql
@carga-datos/s-09-carga-inicial-Origen.sql
@carga-datos/s-09-carga-inicial-MascotaTipo.sql
@carga-datos/s-09-carga-inicial-statusMascota.sql
@carga-datos/s-09-carga-inicial-Cliente.sql
@carga-datos/s-09-carga-inicial-Donativo.sql
@carga-datos/s-09-carga-inicial-StatusSolicitud.sql
@carga-datos/s-09-carga-inicial-Mascota.sql
--@carga-datos/s-09-carga-inicial-Simulacion.sql
