╔════════════╤══════════════════════════════════════╤═══════════════════════╤══════════════════════════════════════════════════════════════╗
║ Error No.  │ Descripción                          │ Programa Generador    │ Solución                                                     ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20000     │ Error en una prueba, no se superó la │ cualquier prueba      │ Revisar la prueba                                            ║
║            │ prueba                               │                       │                                                              ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20001     │ No se tiene registrado el prefijo    │ fx-generar-folio      │ Agregar a la función el prefijo correspondiente              ║
║            │ para el tipo de mascota al que se    │                       │                                                              ║
║            │ quiere generar un folio              │                       │                                                              ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20002     │ El cliente ya tiene 5 mascotas       │ solicitud-mascota-    │ El cliente no puede adoptar hasta que tenga registradas      ║
║            │ adoptadas y no puede hacer otra      │ trigger               │ menos de 5 mascotas                                          ║
║            │ solicitud                            │                       │                                                              ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20003     │ La mascota no está disponible para   │ solicitud-mascota-    │ Seleccionar otra mascota para solicitar la adopción          ║
║            │ adopción                             │ trigger               │                                                              ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20004     │ Se intentó registrar una solicitud   │ solicitud-mascota-    │ Insertar el registro con valor 1                             ║
║            │ de adopción con status no válido     │ trigger               │                                                              ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20005     │ La solicitud de adopción se hizo     │ solicitud-mascota-    │ Seleccionar otra mascota para solicitar la adopción          ║
║            │ después del período de 15 días tras  │ trigger               │                                                              ║
║            │ que uncliente registrara su solicitud│                       │                                                              ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20006     │ Error de extensión de archivo        │ s-17-lob-foto-mascota │ Verificar la extensión del archivo y asegurarse de que sea   ║
║            │                                      │                       │ una extensión permitida                                      ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20007     │ No existe el registro en             │ s-17-lob-foto-mascota │ Validar que el registro correspondiente exista antes de      ║
║            │ monitoreo_cautiverio                 │                       │ realizar la operación                                        ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20008     │ No existe el archivo en el directorio│ s-17-lob-foto-mascota │ Asegurarse de que el archivo esté disponible en el           ║
║            │                                      │                       │ directorio especificado                                      ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20009     │ El archivo se encuentra abierto      │ s-17-lob-foto-mascota │ Cerrar el archivo en uso antes de intentar realizar la       ║
║            │                                      │                       │ operación                                                    ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20010     │ Numero de refugio no valido          │ fx-generar-folio      │ Verificar que el número de refugio sea un número válido      ║
╟────────────┼──────────────────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────────────╢
║ -20011     │ Origen no valido de una mascota      │ fx-generar-folio      │ Verificar que el origen de la mascota sea un valor válido    ║
╚════════════╧══════════════════════════════════════╧═══════════════════════╧══════════════════════════════════════════════════════════════╝
