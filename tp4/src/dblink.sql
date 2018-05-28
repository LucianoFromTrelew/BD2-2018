CREATE EXTENSION dblink;

-- Crear conexión
SELECT dblink_connect('conn_empleados', 'dbname=empleados');

-- Hacemos un SELECT con la conexión creada anteriormente
SELECT * FROM dblink('conn_empleados', 'SELECT nombre, apellido FROM empleado') AS t(nombre varchar(50), apellido varchar(50));

-- O si no, creamos la conexión con la consulta
SELECT * FROM dblink('dbname=empleados', 'SELECT nombre, apellido FROM empleado') AS t(nombre varchar(50), apellido varchar(50));
