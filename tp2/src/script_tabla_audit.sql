-- Tipo de dato enumerado para las operacioes
CREATE TYPE TIPO_OPERACION AS ENUM ('SELECT', 'INSERT', 'UPDATE', 'DELETE');

-- Tabla para auditoría
CREATE TABLE IF NOT EXISTS audit (
    tabla TEXT,
    operacion TIPO_OPERACION,
    usuario TEXT,
    fecha_hora TIMESTAMP PRIMARY KEY,
    -- Regla para verificar que el nombre de la tabla sea correcto
    CONSTRAINT "check_nombre_tabla" CHECK(
        es_nombre_tabla(tabla)
    )
);

CREATE OR REPLACE FUNCTION es_nombre_tabla(tabla text) RETURNS BOOLEAN AS 
-- Verifica si el nombre a ingresar en el campo 'tabla' se corresponde con una tabla de la BD
-- Recibe un nombre de tabla
-- Devuelve un valor lógico
$$
BEGIN
    RETURN (SELECT tabla IN (
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema='public'
    ));
END;
$$ LANGUAGE plpgsql;


