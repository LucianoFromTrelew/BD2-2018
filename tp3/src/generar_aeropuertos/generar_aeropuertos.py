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
    return "INSERT INTO aeropuerto VALUES('{nombre}', ROW('{ciudad}', '{ciudad}', '{pais}'), ROW({longitud}, {ancho}, '{compuesto}'), ARRAY{aerolineas});\n".format(
        nombre=aeropuerto['nombre'],
        ciudad=aeropuerto['ciudad'],
        pais=aeropuerto['pais'],
        longitud=aeropuerto['longitud'],
        ancho=aeropuerto['ancho'],
        compuesto=aeropuerto['compuesto'],
        aerolineas=aeropuerto['aerolineas']
    )

def create_airport(iter_airport, airlines_csv):
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
    return aeropuerto

def main():
    with open("script_carga_aeropuertos.sql", "w") as f:
        with open("data/airports.csv", newline='') as airports_csv:
            reader = csv.DictReader(airports_csv)
            airlines = get_data_from_csv('data/airlines.csv')
            for airport in reader:
                aeropuerto = create_airport(airport, airlines)

                f.write(get_airport_insert_string(aeropuerto))


if __name__ == "__main__":
    main()
