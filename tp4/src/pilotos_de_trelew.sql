-- Localidad de Trelew
SELECT *
FROM localidad
WHERE "nombreLocalidad"
    ILIKE '%trelew%';

-- Pilotos de Trelew
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

-- Trabajadores de Trelew
SELECT * 
FROM trabajador AS t
WHERE t."idLocalidad" = (
    SELECT "idLocalidad" 
    FROM localidad 
    WHERE "nombreLocalidad" ILIKE '%trelew%'
);

-- Relación entre piloto y avión de los pilotos de Trelew
SELECT *
FROM "pilotoAvion" AS pa
WHERE pa."dniPiloto" IN (
    SELECT dni 
    FROM trabajador AS t
    WHERE t."idLocalidad" = (
        SELECT "idLocalidad" 
        FROM localidad 
        WHERE "nombreLocalidad" ILIKE '%trelew%'
    )
);

-- Aviones piloteados por pilotos de Trelew
SELECT *
FROM avion
WHERE "nroAvion" in (
    SELECT "nroAvion"
    FROM "pilotoAvion" AS pa
    WHERE pa."dniPiloto" IN (
        SELECT dni 
        FROM trabajador AS t
        WHERE t."idLocalidad" = (
            SELECT "idLocalidad" 
            FROM localidad 
            WHERE "nombreLocalidad" ILIKE '%trelew%'
        )
    )
);

-- Modelos de aviones piloteados por pilotos de Trelew
SELECT *
FROM "modeloAvion"
WHERE "tipoModelo" IN (
    SELECT "tipoModelo"
    FROM avion
    WHERE "nroAvion" in (
        SELECT "nroAvion"
        FROM "pilotoAvion" AS pa
        WHERE pa."dniPiloto" IN (
            SELECT dni 
            FROM trabajador AS t
            WHERE t."idLocalidad" = (
                SELECT "idLocalidad" 
                FROM localidad 
                WHERE "nombreLocalidad" ILIKE '%trelew%'
            )
        )
    )
);
