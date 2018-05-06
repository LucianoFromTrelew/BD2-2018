SELECT nombre
    FROM aeropuerto 
    WHERE 'Aerolineas Argentinas' = ANY(aerolineas);

SELECT nombre, (ubicacion).ciudad AS ciudad, nombres_aerolineas 
    FROM aeropuerto, UNNEST(aerolineas) AS nombres_aerolineas 
    WHERE nombres_aerolineas ILIKE '%argentina%' ORDER BY nombres_aerolineas, ciudad;

-- select nombre, ciudad from (
    -- select nombre, (ubicacion).ciudad as ciudad, unnest(aerolineas) as nombre_aerolinea from aeropuerto) as sq 
-- where nombre_aerolinea ilike '%argentina%'
