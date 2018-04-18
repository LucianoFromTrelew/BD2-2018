CREATE OR REPLACE FUNCTION es_nombre_tabla(tabla text) RETURNS BOOLEAN AS 
-- Verifica si el nombre a ingresar en el campo 'tabla' se corresponde con una tabla de la BD
-- Recibe un nombre de tabla
-- Devuelve un valor lógico
BEGIN
    RETURN (SELECT tabla IN (
            SELECT table_name FROM information_schema.tables WHERE table_schema='public'
    ));
END;
$$ LANGUAGE plpgsql;

ALTER TABLE audit
ADD CONSTRAINT "check_nombre_tabla" CHECK (
    es_nombre_tabla(tabla)
)
