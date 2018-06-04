CREATE OR REPLACE FUNCTION verificar_curso_inscripto() RETURNS VOID AS $$
/*
    Verica que los cursos que figuran en las inscripciones existan en la tabla correspondiente
    No recibe nada
    No devuelve nada
 */
DECLARE
    resultado TEXT;
    inscripcion RECORD; 
    alumno alumnos%ROWTYPE;
    curso RECORD;
BEGIN
    --Conectar a la BD remota
    PERFORM dblink_connect('conn_cursos', 'hostaddr=172.20.0.20 user=admin password=admin dbname=universidad');

    -- Iterar sobre cada inscripción registrada
    FOR inscripcion IN SELECT * FROM inscriptos LOOP

        resultado := '';

        -- Recuperar el alumno de la inscripción
        SELECT INTO alumno * FROM alumnos 
            WHERE dni=inscripcion.dni_alumno;

        -- Recuperar el curso de la inscripción
        SELECT INTO curso * FROM 
            dblink('conn_cursos', 'SELECT id_curso, nombre FROM cursos') 
            AS t(id_curso integer, nombre text) 
            WHERE t.id_curso=inscripcion.id_curso;

        resultado := resultado || 'Alumno: ' || alumno.nombre || ' | ';

        IF curso IS NULL THEN
            resultado := resultado || 'Curso: INEXISTENTE | ';
        ELSE
            resultado := resultado || 'Curso: ' || curso.nombre || ' | ';
        END IF;

        resultado := resultado || 'Año: ' || inscripcion.anio || ' | ';
        resultado := resultado || 'Nota: ' || inscripcion.nota || '.';

        RAISE NOTICE '%', resultado;
    END LOOP;
    
    -- Cerrar conexión remota
    PERFORM dblink_disconnect('conn_cursos');

END;
$$ LANGUAGE plpgsql;
