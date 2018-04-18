CREATE TABLE IF NOT EXISTS audit (
    tabla TEXT,
    operacion TIPO_OPERACION,
    usuario TEXT,
    fecha_hora TIMESTAMP
);
