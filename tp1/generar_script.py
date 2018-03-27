import csv
import random

def main():
    with open("./modelos_aviones.csv") as f:
        reader = csv.DictReader(f)
        with open("script_carga_modelos.sql", "w") as script:
            for row in zip(reader, range(13, 2500)):
                modelo = {
                    "tipoModelo": int(row[1]),
                    "descripcion": "\'{}\'".format(row[0]['model']),
                    "capacidad": random.randint(50, 900),
                }
                script.write("INSERT INTO \"modeloAvion\" VALUES({}, {}, {});\n".format(
                    modelo["tipoModelo"], modelo["descripcion"], modelo["capacidad"]))

    exit(0)

if __name__ == "__main__":
    main()
