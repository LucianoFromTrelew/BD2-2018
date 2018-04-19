CREATE OR REPLACE FUNCTION registrar_operacion_avion() RETURNS TRIGGER as 
-- Registra una operacion sobre la tabla avión
-- No recibe nada
-- Devuelve un trigger
$$
BEGIN
    INSERT INTO audit VALUES ('avion', CAST(TG_OP AS tipo_operacion), CAST(user AS TEXT), now());

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para registrar inserciones sobre 'avion'
CREATE TRIGGER trigger_insercion_avion 
    AFTER INSERT ON avion
    EXECUTE PROCEDURE registrar_operacion_avion();

-- Trigger para registrar eliminaciones sobre 'avion'
CREATE TRIGGER trigger_eliminacion_avion 
    AFTER DELETE ON avion
    EXECUTE PROCEDURE registrar_operacion_avion();
