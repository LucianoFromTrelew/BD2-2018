-- 4a)
SELECT nombre
FROM aeropuerto 
WHERE 'Aerolineas Argentinas' = ANY(aerolineas);

-- 4a)
SELECT  nombre, 
        (ubicacion).ciudad AS ciudad, 
        nombres_aerolineas 
FROM aeropuerto, UNNEST(aerolineas) AS nombres_aerolineas 
WHERE nombres_aerolineas ILIKE '%argentina%' 
ORDER BY nombres_aerolineas, ciudad;



SELECT nombre FROM aeropuerto_hangares WHERE true = ALL(SELECT esta_ocupado FROM UNNEST(espacios) AS parcelas);

SELECT nombre, oid_avion from aeropuerto_hangares, unnest(espacios) where true = all(select esta_ocupado from unnest(espacios));

-- 4b)
SELECT  nombre, 
        oid_avion, 
        descripcion 
FROM    aeropuerto_hangares, 
        UNNEST(espacios), 
        avion, 
        "modeloAvion" 
WHERE true = ALL(SELECT esta_ocupado FROM UNNEST(espacios)) 
    AND oid_avion=avion.oid 
    AND avion."tipoModelo"="modeloAvion"."tipoModelo" 
ORDER BY aeropuerto_hangares.ctid;

