CREATE EXTENSION dblink;

-- Crear conexión
SELECT dblink_connect('conn_empleados', 'dbname=empleados');

-- Hacemos un SELECT con la conexión creada anteriormente
SELECT * FROM dblink('conn_empleados', 'SELECT nombre, apellido FROM empleado') AS t(nombre varchar(50), apellido varchar(50));

-- O si no, creamos la conexión con la consulta
SELECT * FROM dblink('dbname=empleados', 'SELECT nombre, apellido FROM empleado') AS t(nombre varchar(50), apellido varchar(50));


/*
 Ejemplos de Cristian vistos en clase
 */

-- Crear una conexión persistente
SELECT dblink_connect('myconn', 'dbname=sitio1 user=db user=dblinktest password=prueba');

-- Query a tabla local
select * from "ClienteDom"

-- Query a Tablas remotas (primitiva dblink())
SELECT * FROM dblink('myconn','SELECT * FROM "Cliente"') AS t(id int, nom character(50))

-- Query a Tablas remotas join con tabla local
SELECT * FROM dblink('myconn','SELECT * FROM "Cliente"') AS t(id int, nom character(50)) full outer join "ClienteDom" cd 
    on t.id=cd."idCliente"


-- Enviar comandos a ejecutar en servidor remoto
SELECT dblink_exec('myconn', 'insert into "Cliente" values (20, ''Rodrigo'')')

-- Este comando crea una tabla en el sitio remoto en base a otra, comprobarlo mirando en una conexion al sitio remoto
select dblink_exec('myconn','SELECT * into tempcliente FROM "Cliente"')   

        
-- Crear una tabla local
CREATE TABLE tdist	
(
  col1 integer NOT NULL,
  col2 integer,
  nombre character(50),
  CONSTRAINT pk PRIMARY KEY (col1)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tdist
  OWNER TO postgres;

-- Insertar en la tabla local desde la remota
INSERT INTO tdist (col1, nombre)
 SELECT id, nombre FROM dblink('myconn','SELECT * FROM "Cliente"') AS t( id integer,  nombre character(50));

-- Ver el resultado (no es dinámico, sino que copió los datos que tenía a ese momento la tabla en el sitio remoto)
SELECT * FROM tdist;
 
-- Crear una vista con la consulta remota
CREATE VIEW vwremote AS 
   SELECT * FROM dblink('myconn','SELECT * FROM "Cliente"') AS t(id int, nom character(50));

-- Ver el resultado (Es dinámico, prueben insertar en otra conexion a sitio 1 una tupla y ver que aparece acá)
SELECT * FROM vwremote


-- Ejemplo de transaccion que toca datos remotos, si se hace ROLLBACK, igual altera los datos remotos
BEGIN TRANSACTION;
  INSERT INTO "ClienteDom" VALUES ('23', 'Rivadavia', 220, 'Trelew');

  SELECT dblink_exec('myconn', 'insert into "Cliente" values (23, ''PABLO'')');
rollback

-- Comprobamos que los cambios están hecho en la tabla remoto y el rollback si lo hizo sobre la tabla local
SELECT * FROM "ClienteDom"

SELECT * FROM dblink('myconn','SELECT * FROM "Cliente"') AS t(id int, nom character(50));



-- Cerrar la conexión
SELECT dblink_disconnect('myconn');

