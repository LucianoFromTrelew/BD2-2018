CREATE TABLE IF NOT EXISTS compuesto (
    id_compuesto integer PRIMARY KEY,
    descripcion varchar(100)
); 

CREATE TYPE t_ubicacion AS (
    ciudad      varchar(50),
    provincia   varchar(50),
    pais        varchar(30)
);

CREATE TYPE t_medidas AS (
    longitud    integer,
    ancho       integer,
    compuesto   varchar(100)
);


CREATE TYPE t_aeropuerto AS (
    nombre      varchar(100),
    ubicacion   t_ubicacion,
    medidas     t_medidas,
    aerolineas  text[]
);

CREATE TABLE aeropuerto OF t_aeropuerto;
