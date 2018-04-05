/*
    Script para cargar masivamente los aviones
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

CREATE OR REPLACE FUNCTION getUltimoAvion() RETURNS SETOF integer AS $$
/*
    Devuelve el id del ultimo avion insertado
    No recibe nada
    Devuelve el id del último avión ingresado
*/
BEGIN
	RETURN QUERY
	SELECT "nroAvion" FROM "avion" ORDER BY "nroAvion" DESC LIMIT 1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cargarAviones() RETURNS integer AS $$
/*
    Carga aviones masivamente en la table 'avion'
    No recibe nada
    Devuelve un entero
*/
DECLARE 
	MIN_HORAS CONSTANT integer := 100;
	MAX_HORAS CONSTANT integer := 5000;
	MIN_ANIO CONSTANT integer := 1970;
	MAX_ANIO CONSTANT integer := 2018;
	AVIONES_POR_MODELO CONSTANT integer := 10000;

	anio integer;
	numeroAvion integer;
	horas integer;
	tipoModelo integer;
BEGIN

	SELECT INTO numeroAvion getUltimoAvion();
	
    -- Imprimimos la hora a la que empieza
	RAISE NOTICE '%', clock_timestamp();

	FOR tipoModelo IN SELECT "tipoModelo" from "modeloAvion" LOOP
		RAISE NOTICE '*** tipoModelo: % ***', tipoModelo;
		FOR i in 1..AVIONES_POR_MODELO LOOP
			horas := getEnteroAleatorio(MIN_HORAS, MAX_HORAS);
			anio := getEnteroAleatorio(MIN_ANIO, MAX_ANIO);
			numeroAvion := numeroAvion + 1;
			RAISE NOTICE 'INSERTANDO AVION... nroAvion: %. tipoModelo: %. anio: %. horasVuelo: %', numeroAvion, tipoModelo, anio, horas;
			INSERT INTO avion VALUES(numeroAvion, tipoModelo, anio, horas);
		END LOOP;
	END LOOP;

    -- Imprimimos la hora a la que termino
	RAISE NOTICE '%', clock_timestamp();
	
	RETURN 1;
END;
$$ LANGUAGE plpgsql;

SELECT cargarAviones();
