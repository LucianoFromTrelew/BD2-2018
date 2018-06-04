-- Alumnos recursantes

SELECT dblink_connect('conn_cursos', 'hostaddr=172.20.0.20 user=admin password=admin dbname=universidad');

SELECT 
    al.nombre AS "Alumno",
    ins.dni_alumno AS "DNI", 
    cur.nombre AS "Curso",
    COUNT(ins.id_curso) AS "Cuántas veces" 
FROM inscriptos AS ins
JOIN alumnos AS al
    ON ins.dni_alumno = al.dni
JOIN (SELECT * FROM dblink('conn_cursos', 'SELECT id_curso, nombre FROM cursos') AS t(id_curso integer, nombre text)) AS cur
    ON ins.id_curso=cur.id_curso
GROUP BY 
    al.nombre,
    ins.dni_alumno,
    cur.nombre
HAVING COUNT(ins.id_curso) > 1 
ORDER BY al.nombre;

SELECT dblink_disconnect('conn_cursos');
