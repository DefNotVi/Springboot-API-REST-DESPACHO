# Repositorio Backend - Innovatech Chile

Este repositorio contiene el código de la API de microservicios desarrollada con Spring Boot (Java) y conectada a una base de datos MySQL.

## Orquestación y Redes Internas

En el servidor privado (ec2-app) se utiliza Docker Compose para coordinar y levantar el microservicio y el motor de base de datos de forma conjunta.

* Seguridad en Redes: Los contenedores se comunican a través de una red interna privada creada por Docker. El puerto de la base de datos MySQL no se expone hacia internet, permitiendo que únicamente la API pueda consumir los datos y protegiendo el entorno de accesos externos no autorizados.

## Persistencia de Datos con Named Volumes

Para asegurar la continuidad operativa de la base de datos MySQL, se configuraron Volúmenes Nombrados (Named Volumes) en Docker Compose en lugar de Bind Mounts.

* Justificación técnica: Los Named Volumes son gestionados directamente por el motor de Docker en el almacenamiento del host. Esto da un mejor rendimiento de lectura y escritura en la nube, mayor portabilidad y garantiza que los registros de la base de datos no se borren en caso de que los contenedores se detengan, reinicien o actualicen.

## Automatización de Despliegue

El flujo implementado en GitHub Actions realiza las tareas automáticas al detectar cambios en la rama "deploy":
1. Compila el código Java para generar el archivo ejecutable (.jar).
2. Empaqueta el archivo en una imagen Docker y la sube al registro privado de Amazon ECR.
3. Establece conexión SSH con la instancia EC2 Privada para detener el contenedor antiguo y arrancar el nuevo con las últimas actualizaciones.
