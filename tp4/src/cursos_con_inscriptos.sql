SELECT dblink_connect('conn_cursos', 'hostaddr=172.20.0.20 user=admin password=admin dbname=universidad');

SELECT 
    distinct nombre 
FROM 
    dblink('conn_cursos', 'SELECT id_curso, nombre FROM cursos') 
    AS t(id_curso integer, nombre text)
JOIN inscriptos AS ins 
    ON t.id_curso=ins.id_curso;

SELECT dblink_disconnect('conn_cursos');
