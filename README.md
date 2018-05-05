# Bases de Datos II - 2018

## Licenciatura en Sistemas (OPGCPI)

Repositorio para la materia "Bases de Datos 2" de la UNPSJB, Sede Trelew, 2018


#### Para levantar la BD

Crear un archivo "compose.env" con las siguientes variables de entorno en la forma VARIABLE=VALOR (**sin espacios**):

* *POSTGRES_PASSWORD*
* *POSTGRES_USER*
* *POSTGRES_DB*
* *PGDATA*

Y después ejecutar el comando `docker-compose up -d` estando parado en el mismo directorio que el archivo `docker-compose.yml`

#### Para conectarse a la BD

* Via `pgAdmin`. Agregar un servidor cuyo *host* sea `localhost` y puerto sea el `5555` (si es que no se modificó el puerto en el `docker-compose.yml`)

* Via `psql`: `psql -h localhost -p 5555 -d aviones -U <USUARIO>`
