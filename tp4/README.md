Crear los contenedores con:

```bash
docker-compose -p <NOMBRE_PROYECTO> up -d
```

Correrlos con: 

```bash
./run-compose.sh
```

O bien con

```bash
docker-compose -p <NOMBRE_PROYECTO> up -d
```

El nombre del proyecto utilizado es **bdd**

---

Para detenerlos:

```bash
./stop-compose.sh
```

O bien con

```bash
docker-compose -p <NOMBRE_PROYECTO> stop
```

Para eliminar la red y los contenedores, ejecutar:
```bash
docker-compose -p <NOMBRE_PROYECTO> down
```
