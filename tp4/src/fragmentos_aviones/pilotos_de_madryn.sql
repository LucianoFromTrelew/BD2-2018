/*
    Los siguientes fragmentos serían asignados al sitio de Puerto Madryn
 */

-- Descripción: Localidad de Madryn
-- Nombre de fragmento: localidad_madryn
SELECT *
FROM localidad
WHERE "nombreLocalidad"
    ILIKE '%madryn%';

-- Descripción: Pilotos de Madryn
-- Nombre de fragmento: piloto_madryn
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

-- Descripción: Trabajadores de Madryn
-- Nombre de fragmento: trabajador_madryn
SELECT * 
FROM trabajador AS t
WHERE t."idLocalidad" = (
    SELECT "idLocalidad" 
    FROM localidad 
    WHERE "nombreLocalidad" ILIKE '%madryn%'
);

-- Descripción: Relación entre piloto y avión de los pilotos de Madryn
-- Nombre de fragmento: piloto_avion_madryn
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

-- Descripción: Aviones piloteados por pilotos de Madryn
-- Nombre de fragmento: avion_madryn
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

-- Descripción: Modelos de aviones piloteados por pilotos de Madryn
-- Nombre de fragmento: modelo_avion_madryn
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
