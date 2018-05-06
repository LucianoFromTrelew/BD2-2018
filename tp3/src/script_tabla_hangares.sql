-- Modificamos la tabla "avion" para que utilice OIDS
ALTER TABLE avion SET WITH OIDS;

CREATE OR REPLACE FUNCTION es_oid_avion(valor oid) RETURNS BOOLEAN AS
-- Verifica si "valor" es un OID de un avion
-- Recibe un OID
-- Devuelve un valor verdadero si "valor" es un OID de un avion
-- Devuelve un valor falso en caso contrario
$$
BEGIN
    RETURN (SELECT valor IN (
            SELECT oid FROM avion 
        )
    );
END;
$$ LANGUAGE plpgsql;

-- Dominio para emular una clave foránea en un tipo compuesto
CREATE DOMAIN d_espacio_avion oid CHECK (
    es_oid_avion(value)    
);

-- Tipo compuesto para modelar la parcela de un hangar
CREATE TYPE t_espacio AS (
    numero_parcela  integer,
    esta_ocupado    boolean,
    oid_avion       d_espacio_avion
);


CREATE TABLE aeropuerto_hangares (
    precio_espacio  integer,
    espacios        t_espacio[]
) INHERITS (aeropuerto);
