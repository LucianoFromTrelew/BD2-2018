import csv
import random
MIN_CAPACIDAD = 50
MAX_CAPACIDAD = 2000

def main():
    with open("./modelos_aviones.csv") as f:
        reader = csv.DictReader(f)
        with open("script_carga_modelos.sql", "w") as script:
            for row in zip(reader, range(13, 2500)):
                modelo = {
                    "tipoModelo": int(row[1]),
                    "descripcion": "\'{}\'".format(row[0]['model']),
                    "capacidad": random.randint(MIN_CAPACIDAD, MAX_CAPACIDAD),
                }
                script.write("INSERT INTO \"modeloAvion\" VALUES({}, {}, {});\n".format(
                    modelo["tipoModelo"], modelo["descripcion"], modelo["capacidad"]))

    exit(0)

if __name__ == "__main__":
    main()
