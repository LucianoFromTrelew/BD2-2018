/*
    Script para cargar masivamente las reparaciones de los aviones
 */

CREATE OR REPLACE FUNCTION getEnteroAleatorio(min integer, max integer) RETURNS integer AS $$
/*
    Genera un entero aleatorio en el rango especificado
    Recibe dos enteros min y max
    Devuelve un entero aleatorio entre [min, max] 
*/
BEGIN
	RETURN floor(random()*(max-min+1))+min;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getRandomDate(min timestamp, max timestamp) RETURNS SETOF date AS $$
/*
    Genera una fecha aleatoria en el rango especificado
    Recibe dos timestamp min y max
    Devuelve una fecha aleatoria entre [min, max]
 */
BEGIN

    RETURN QUERY
    SELECT date(min +
       random() * (max - min));
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cargarReparaciones() RETURNS integer AS $$
/*
    Carga masivamente las reparaciones
    No recibe nada
    Devuelve un entero
 */
DECLARE
    nro_avion integer;
    dni_trabajador integer;
    tipo_falla integer;
    fecha_inicio date;
    fecha_fin date;
BEGIN
    FOR nro_avion IN SELECT "nroAvion" from avion LOOP
        FOR i in 1..getEnteroAleatorio(1, 10) LOOP
            -- elegimos un dni aleatorio
            SELECT INTO dni_trabajador dni FROM trabajador ORDER BY random() LIMIT 1;
            -- elegimos fecha de comienzo aleatoria
            SELECT INTO fecha_inicio getRandomDate(timestamp '2010-01-01', timestamp '2018-03-01');
            -- la fecha de fin de reparacion puede ser entre 2 a 30 dias del inicio
            fecha_fin := fecha_inicio + getEnteroAleatorio(2, 30);
            -- el tipo falla puede ser alguna de las 4 tipificadas
            tipo_falla := getEnteroAleatorio(1, 4);

            RAISE NOTICE 'INSERTANDO REPARACION... dni: %, nro_avion: %, fecha_inicio: %, fecha_fin: %, tipo_falla: %', 
                dni_trabajador, nro_avion, fecha_inicio, fecha_fin, tipo_falla;
            INSERT INTO "trabajadorReparacion" VALUES(dni_trabajador, nro_avion, fecha_inicio, fecha_fin, tipo_falla)
                ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
    RETURN 1;
END;
$$ LANGUAGE plpgsql;

SELECT cargarReparaciones();
