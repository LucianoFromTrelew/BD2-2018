/*
    Los siguientes fragmentos serían asignados al sitio de Trelew
 */

-- Descripción: Localidad de Trelew
-- Nombre de fragmento: localidad_trelew
SELECT *
FROM localidad
WHERE "nombreLocalidad"
    ILIKE '%trelew%';

-- Descripción: Pilotos de Trelew
-- Nombre de fragmento: piloto_trelew
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

-- Descripción: Trabajadores de Trelew
-- Nombre de fragmento: trabajador_trelew
SELECT * 
FROM trabajador AS t
WHERE t."idLocalidad" = (
    SELECT "idLocalidad" 
    FROM localidad 
    WHERE "nombreLocalidad" ILIKE '%trelew%'
);

-- Descripción: Relación entre piloto y avión de los pilotos de Trelew
-- Nombre de fragmento: piloto_avion_trelew
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

-- Descripción: Aviones piloteados por pilotos de Trelew
-- Nombre de fragmento: avion_trelew
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

-- Descripción: Modelos de aviones piloteados por pilotos de Trelew
-- Nombre de fragmento: modelo_avion_trelew
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
