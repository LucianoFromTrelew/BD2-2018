/*
    Consulta sobre aviones que tengan una capacidad de 1959
 */
SELECT  tr."dniTrabajador" AS "DNI", 
        tr."nroAvion" as "Avión",
        tr."fechaInicioReparacion" AS "Fecha de comienzo",
        tr."fechaFinReparacion" AS "Fecha de fin",
        md.descripcion AS "Modelo",
        f.descripcion AS "Falla reparada"
        FROM 
            "trabajadorReparacion" AS tr,
            "modeloAvion" AS md,
            avion AS av,
            falla AS f
        WHERE
            tr."nroAvion" = av."nroAvion"
            AND av."tipoModelo" = md."tipoModelo"
            AND md.capacidad = 1959
            AND f."tipoFalla" = tr."tipoFallaReparada";
