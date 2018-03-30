SELECT capacidad, COUNT(*) FROM "modeloAvion" GROUP BY capacidad HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC LIMIT 1;

SELECT "tipoModelo" FROM "modeloAvion" WHERE capacidad in (
    SELECT capacidad FROM "modeloAvion" GROUP BY capacidad 
    HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC LIMIT 1
);

SELECT tr."dniTrabajador", tr."nroAvion", tr."fechaInicioReparacion", tr."fechaFinReparacion", md.descripcion, f.descripcion 
    FROM "trabajadorReparacion" AS tr, "modeloAvion" AS md, falla AS f 
    WHERE md."tipoModelo" IN (
        SELECT "tipoModelo" FROM "modeloAvion" WHERE capacidad IN (
            SELECT capacidad FROM "modeloAvion" GROUP BY capacidad 
            HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC LIMIT 1));

SELECT COUNT(*) FROM (
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
                AND md.capacidad = 1959
) sub_query;

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

SELECT  DISTINCT ON(tr."nroAvion")
        tr."dniTrabajador", 
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
            AND md.capacidad = 1959
        ORDER BY 
            tr."nroAvion",
            tr."fechaInicioReparacion";

SELECT COUNT(*) FROM (
    SELECT  DISTINCT ON(tr."nroAvion")
            tr."dniTrabajador", 
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
                AND md.capacidad = 1959
            ORDER BY 
                tr."nroAvion",
                tr."fechaInicioReparacion"
) sub_query;

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
            AND av."tipoModelo" IN (
                SELECT "tipoModelo" FROM "modeloAvion" WHERE capacidad IN (
                    SELECT capacidad FROM "modeloAvion" GROUP BY capacidad 
                    HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC LIMIT 1)
                ) ORDER BY tr."nroAvion";
