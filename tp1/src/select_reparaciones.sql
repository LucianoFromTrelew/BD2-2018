EXPLAIN (ANALYZE true)
SELECT  tr."dniTrabajador", 
        tr."nroAvion",
        tr."fechaInicioReparacion",
        tr."fechaFinReparacion",
        md.descripcion,
        f.descripcion
        FROM 
            "trabajadorReparacion" AS tr,
            "modeloAvion" AS md,
            avion AS av,
            falla AS f
        WHERE
            tr."nroAvion" = av."nroAvion"
            AND av."tipoModelo" = md."tipoModelo"
            AND md.capacidad = 1959;
