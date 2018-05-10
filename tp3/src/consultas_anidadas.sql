-- 6)
SELECT  nombre AS "Aeropuerto", 
        (parcelas).numero_parcela AS "Número de parcela", 
        CASE WHEN (parcelas).esta_ocupado=true THEN 
            'Ocupado' 
        ELSE 'Disponible' 
        END AS "Está ocupado?", 
        (parcelas).oid_avion AS "Avión" 
FROM aeropuerto_hangares, UNNEST(espacios) AS parcelas;

-- 7)


SELECT  trim(nombre) AS "Trabajador", 
        ARRAY_AGG(ROW(tr."nroAvion", trim(descripcion)))  AS "Aviones reparadas"
FROM "trabajadorReparacion" AS tr 
    JOIN trabajador AS t ON tr."dniTrabajador"=t.dni 
    JOIN avion AS av ON tr."nroAvion"=av."nroAvion" 
    JOIN "modeloAvion" AS ma ON av."tipoModelo"=ma."tipoModelo" 
GROUP BY nombre ORDER BY nombre;

-- select nombre, ciudad from (
    -- select nombre, (ubicacion).ciudad as ciudad, unnest(aerolineas) as nombre_aerolinea from aeropuerto) as sq 
-- where nombre_aerolinea ilike '%argentina%'
