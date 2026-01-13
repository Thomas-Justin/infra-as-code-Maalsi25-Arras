# TP – Introduction à Docker et Kubernetes avec Minikube

## Objectif du projet

Ce projet a pour objectif de découvrir :

- l’exécution d’une application Node.js dans un conteneur Docker,
- le déploiement de cette application dans un cluster Kubernetes local via Minikube,
- les différences entre Docker et Kubernetes.

L’application consiste en un serveur HTTP simple affichant un message dans le navigateur.

---

## Préparation du projet

### 1. Création du répertoire du projet

```bash
mkdir tp-intro-docker-minikube
cd tp-intro-docker-minikube
```

### 2. Création du fichier `server.js`

```bash
const http = require('http');

const hostname = '0.0.0.0';
const port = 8080;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello, Docker and Minikube from Node.js !');
});

server.listen(port, hostname, () => {
  console.log(`Server running on port ${port}`);
});
```

### 3. Création du fichier `Dockerfile`

```bash
FROM node:22-alpine

WORKDIR /app

COPY server.js .

EXPOSE 8080

CMD ["node", "server.js"]
```

### 4. Création du fichier `deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: node-app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: node-app
  template:
    metadata:
      labels:
        app: node-app
    spec:
      containers:
        - name: node-app
          image: node-app
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 8080

apiVersion: v1
kind: Service
metadata:
  name: node-app-service
spec:
  type: NodePort
  selector:
    app: node-app
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 30080
```

---

## Déploiement du projet

### 1. Création du cluster Kubernetes

Pour déployer notre application, nous allons utiliser Minikube.

Minikube est un outil permettant de créer et de gérer un cluster Kubernetes local.

Pour installer Minikube, suivez les instructions sur le site officiel : [https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/)

Une fois Minikube installé, il suffit de lancer la commande suivante pour créer un cluster Kubernetes :

```bash
minikube start
```

### 2. Déploiement de l’application

Pour déployer l’application, nous allons utiliser Docker.

Docker est un outil permettant de créer et de gérer des conteneurs.

Pour installer Docker, suivez les instructions sur le site officiel : [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

Une fois Docker installé, il suffit de lancer la commande suivante pour créer le conteneur Docker :

```bash
docker build -t node-app .
```

Ensuite, il suffit de lancer la commande suivante pour déployer l’application :

```bash
docker run -d -p 8080:8080 node-app
```

### 3. Vérification de l’application

Une fois l’application déployée, vous pouvez accéder à l’application en utilisant votre navigateur web.

Vous pouvez accéder à l’application en utilisant l’URL suivante :

```
http://localhost:8080
```

## Conclusion

Ce TP a permis de découvrir les bases de Docker et Kubernetes.

## Analyse et questions

Pourquoi Docker a permis d’exécuter le serveur Node.js sans Node.js installé localement ?

Docker permet d’embarquer toutes les dépendances nécessaires à l’application dans une image.
L’image utilisée contient déjà Node.js, ce qui rend l’application totalement indépendante de l’environnement local.
Ainsi, le serveur peut être exécuté sans installer Node.js sur la machine hôte.

Quel est l’intérêt d’utiliser Minikube / Kubernetes pour déployer un conteneur ?

Minikube permet de simuler un cluster Kubernetes localement.
Kubernetes apporte une gestion avancée des applications conteneurisées, notamment :

le déploiement automatisé,

la gestion des pannes,

la mise à l’échelle,

la communication entre services.

Cela se rapproche davantage d’un environnement de production réel.

Quelles sont les différences entre lancer un conteneur avec Docker et l’orchestrer avec Kubernetes ?

Avec Docker seul, le conteneur est lancé manuellement et doit être géré individuellement.
Kubernetes, quant à lui, orchestre les conteneurs :

il gère leur cycle de vie,

redémarre automatiquement les pods en cas de panne,

permet la mise à l’échelle,

sépare la logique applicative de l’infrastructure.

Docker est un outil de conteneurisation, tandis que Kubernetes est un outil d’orchestration.

Conclusion

Ce TP a permis de comprendre les bases de Docker et Kubernetes, ainsi que leur complémentarité.
Docker facilite l’exécution d’applications de manière portable, tandis que Kubernetes permet leur déploiement et leur gestion à grande échelle.
