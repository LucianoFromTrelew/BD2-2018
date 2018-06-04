-- Alumnos recursantes
SELECT 
    nombre,
    dni_alumno, 
    id_curso,
    COUNT(id_curso) AS cuantas 
FROM inscriptos AS ins
JOIN alumnos AS al
    ON ins.dni_alumno = al.dni
GROUP BY 
    nombre,
    dni_alumno, 
    id_curso 
HAVING COUNT(id_curso) > 1 
ORDER BY nombre;
