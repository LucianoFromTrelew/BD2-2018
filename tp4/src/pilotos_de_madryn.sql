/*
    Los siguientes fragmentos serían asignados al sitio de Puerto Madryn
 */

-- Localidad de Trelew
SELECT *
FROM localidad
WHERE "nombreLocalidad"
    ILIKE '%madryn%';

-- Pilotos de Trelew
SELECT * 
FROM piloto 
WHERE "dniPiloto" IN (
    SELECT dni 
    FROM TRABAJADOR AS t 
    WHERE t."idLocalidad" = (
        SELECT "idLocalidad" 
        FROM localidad 
        WHERE "nombreLocalidad" ILIKE '%madryn%'
    )
);

-- Trabajadores de Trelew
SELECT * 
FROM trabajador AS t
WHERE t."idLocalidad" = (
    SELECT "idLocalidad" 
    FROM localidad 
    WHERE "nombreLocalidad" ILIKE '%madryn%'
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
        WHERE "nombreLocalidad" ILIKE '%madryn%'
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
            WHERE "nombreLocalidad" ILIKE '%madryn%'
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
                WHERE "nombreLocalidad" ILIKE '%madryn%'
            )
        )
    )
);
