import csv

def main():
    airlines = []
    with open('airlines.dat') as f:
        for r in f.readlines():
            splitted_line = r.split(',')
            airline = {
                "id": int(splitted_line[0]),
                "name": splitted_line[1].strip('\"'),
                "country": splitted_line[-2].strip('\"')
            }
            airlines.append(airline)

    airlines = sorted(airlines, key=lambda airline: airline['id'])

    with open('airlines.csv', 'w', newline='') as csvfile:
        fieldnames=['id','name','country']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for a in airlines:
            writer.writerow(a)


if __name__ == "__main__":
    main()
