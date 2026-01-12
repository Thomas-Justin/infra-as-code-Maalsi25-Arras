# TP – MongoDB avec Docker

Dans ce TP, j’ai intégré MongoDB dans un conteneur Docker et j’ai appris à interagir avec lui.

## 1. Configuration Docker

J’ai créé un fichier docker-compose.yml pour définir le conteneur MongoDB.
Voici le contenu utilisé :

```version: "3.1"

services:
  mongo:
    image: mongo
    restart: always
    container_name: nosql-database
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: password
    volumes:
      - ./db_data:/data/db
```

Le nom du conteneur a été défini pour l’identifier facilement.

Le port 27017 du conteneur a été mappé au port local 27017.

J’ai défini un utilisateur root avec un mot de passe pour l’authentification.

Les données ont été persistées dans le dossier db_data de la machine locale.

## 2. Création et utilisation de la base

Je me suis connecté au conteneur avec mongosh :

docker exec -it nosql-database mongosh -u admin -p password


Dans le shell MongoDB, j’ai créé une base et une collection, puis j’ai inséré un document :

```
use tpdb
db.users.insertOne({ name: "Alice", age: 25 })
db.users.find()
```

La base n’existe réellement qu’après la création d’une collection ou l’insertion d’un document.

## 3. Bonnes pratiques

J’ai utilisé un volume pour garantir la persistance des données après redémarrage.

L’utilisateur et le mot de passe root ont été configurés pour la sécurité.

Pour un usage développement, j’aurais pu désactiver l’authentification en supprimant les variables environment.

Le port a été choisi pour éviter les conflits avec d’autres services.

## 4. Arrêt et suppression du conteneur

Pour nettoyer l’environnement, j’ai arrêté et supprimé le conteneur ainsi que ses volumes :
```
docker stop nosql-database
docker rm -v nosql-database
```
