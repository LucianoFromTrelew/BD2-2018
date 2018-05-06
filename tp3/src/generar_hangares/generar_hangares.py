import csv
import random
import config

def get_random_int(floor, roof):
    """Devuelve un entero aleatorio entre 'floor' y 'roof'"""
    return random.randint(floor, roof)

def get_random_choices(population, k):
    """Devuelve una lista de k-elementos aleatorios de 'population'"""
    return random.sample(population, k)

def get_data_from_csv(file):
    """Devuelve un csv 'file' entero en una lista"""
    data = []
    with open(file, newline='') as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)

    return data

def get_airport_insert_string(aeropuerto):
    """Devuelve una cadena formateada para insertar un aeropuerto"""
    return "INSERT INTO aeropuerto_hangares VALUES('{nombre}', ROW('{ciudad}', '{ciudad}', '{pais}'), ROW({longitud}, {ancho}, '{compuesto}'), ARRAY{aerolineas}, {precio_espacio}, ARRAY[{hangares}]);\n".format(
        nombre=aeropuerto['nombre'],
        ciudad=aeropuerto['ciudad'],
        pais=aeropuerto['pais'],
        longitud=aeropuerto['longitud'],
        ancho=aeropuerto['ancho'],
        compuesto=aeropuerto['compuesto'],
        aerolineas=aeropuerto['aerolineas'],
        precio_espacio=aeropuerto['precio_espacio'],
        hangares=aeropuerto['hangares']
    )

def create_airport_hangar(iter_airport, airlines_csv):
    """Arma el aeropuerto con todos sus datos"""
    aeropuerto = {}
    aeropuerto['nombre'] = iter_airport['name'].replace("\'", " ")
    aeropuerto['ciudad'] = iter_airport['city'].replace("\'", " ")
    aeropuerto['pais'] = iter_airport['country'].replace("\'", " ")
    aeropuerto['longitud'] = get_random_int(
        config.MIN_LONG, config.MAX_LONG)

    aeropuerto['ancho'] = get_random_int(
        config.MIN_ANCHO, config.MAX_ANCHO)

    aeropuerto['compuesto'] = get_random_choices(
        config.COMPUESTOS, 1)[0]

    aeropuerto['aerolineas'] = [
        '{}'.format(airline['name'].replace("\'", " ")) for airline in get_random_choices(
            airlines_csv, get_random_int(
                config.MIN_AEROLINEAS,
                config.MAX_AEROLINEAS))
    ]

    aeropuerto['precio_espacio'] = get_random_int(
        config.MIN_PRECIO_ESPACIO,
        config.MAX_PRECIO_ESPACIO)

    hangares = [
        'CAST(ROW({numero_hangar}, {esta_ocupado}, {oid_avion}) as t_espacio)'.format(
            numero_hangar=get_random_int(config.MIN_NRO_HANGAR, config.MAX_NRO_HANGAR),
            esta_ocupado=random.choice([True, False]),
            oid_avion=get_random_int(config.MIN_OID_AVION, config.MAX_OID_AVION)
        ) for i in range(0, get_random_int(config.MIN_HANGARES, config.MAX_HANGARES))
    ]

    aeropuerto['hangares'] = ','.join(hangares)
    return aeropuerto

def main():
    with open("script_carga_hangares.sql", "w") as f:
        with open("data/airports.csv", newline='') as airports_csv:
            reader = csv.DictReader(airports_csv)
            airlines = get_data_from_csv('data/airlines.csv')
            for t in zip(reader, range(100)):
                airport = t[0]
                aeropuerto_hangar = create_airport_hangar(airport, airlines)

                f.write(get_airport_insert_string(aeropuerto_hangar))


if __name__ == "__main__":
    main()
