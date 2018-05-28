-- SELECT * 
-- FROM piloto 
-- WHERE "dniPiloto" IN (
    -- SELECT dni 
    -- FROM TRABAJADOR AS t 
    -- WHERE t."idLocalidad" = (
        -- SELECT "idLocalidad" 
        -- FROM localidad 
        -- WHERE "nombreLocalidad" ILIKE '%trelew%'
    -- )
-- );

SELECT * 
FROM piloto AS p
JOIN trabajador AS t
ON t.dni = p."dniPiloto"
WHERE t."idLocalidad" = (
    SELECT "idLocalidad" 
    FROM localidad 
    WHERE "nombreLocalidad" ILIKE '%trelew%'
);
