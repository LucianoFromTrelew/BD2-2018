CREATE TABLE alumnos (
    dni integer PRIMARY KEY,
    nombre varchar(50)
);

SELECT dblink_connect('conn_cursos', 'hostaddr=172.20.0.3 dbname=universidad user=admin password=admin');

SELECT dblink_exec('conn_cursos', 'CREATE TABLE cursos (id_curso integer PRIMARY KEY, nombre varchar(50), id_profesor integer, departamento integer)');

CREATE TABLE inscriptos (
    dni_alumno integer REFERENCES alumnos (dni),
    id_curso integer,
    anio integer,
    nota integer,
    PRIMARY KEY (dni_alumno, id_curso, anio)
);
