import csv

def main():
    airports = []
    with open('airports.dat') as f:
        for r in f.readlines():
            splitted_line = r.split(',')
            airport = {
                "id": int(splitted_line[0]),
                "name": splitted_line[1].strip('\"'),
                "city": splitted_line[2].strip('\"'),
                "country": splitted_line[3].strip('\"')
            }
            airports.append(airport)

    airports = sorted(airports, key=lambda airport: airport['id'])

    with open('airports.csv', 'w', newline='') as csvfile:
        fieldnames=['id','name', 'city', 'country']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for a in airports:
            writer.writerow(a)


if __name__ == "__main__":
    main()
