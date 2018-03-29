import csv

def main():
    with open("../dataset.csv",) as f:
        # Abrimos el dataset completo
        reader = csv.DictReader(f)
        # Obtenemos una lista con los modelos de las naves
        modelos = [r['Type'] for r in reader]
        # ordenados por nombre y sin duplicados
        modelos = sorted(list(set(modelos)))

        with open("modelos_aviones.csv", "w") as dataset:
            # Escribrimos nuestro dataset
            fieldnames = ['model']
            writer = csv.DictWriter(dataset, fieldnames=fieldnames)
            writer.writeheader()

            for m in modelos:
                writer.writerow({'model': m})

if __name__ == "__main__":
    main()
