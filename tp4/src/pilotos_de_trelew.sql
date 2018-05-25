SELECT * 
FROM piloto 
WHERE "dniPiloto" IN (
    SELECT dni 
    FROM TRABAJADOR AS t 
    WHERE t."idLocalidad" = (
        SELECT "idLocalidad" 
        FROM localidad 
        WHERE "nombreLocalidad" ILIKE '%trelew%'
    )
);
