# Bases de Datos II - 2018

## Licenciatura en Sistemas (OPGCPI)

Repositorio para la materia "Bases de Datos 2" de la UNPSJB, Sede Trelew, 2018


#### Para levantar la BD

> Modificar puerto de escucha, versión de Postgres, y dirección en donde se va a montar el volumen en el `docker-compose.yml` (por defecto son el 5555, 9.5, y ~/pg_data, respectivamente) 

Crear un archivo `compose.env` (en el mismo directorio que el `docker-compose.yml`), con las siguientes variables de entorno en la forma `VARIABLE=VALOR` (**sin espacios**):

* *POSTGRES_PASSWORD*
* *POSTGRES_USER*
* *POSTGRES_DB*
* *PGDATA*

Y después ejecutar el comando `docker-compose up -d`

#### Para conectarse a la BD

* Via `pgAdmin`. Agregar un servidor cuyo *host* sea `localhost` y puerto el indicado (por defecto 5555)

* Via `psql`: `psql -h localhost -p <PUERTO> -d <NOMBRE_DE_LA_BASE> -U <USUARIO>`
