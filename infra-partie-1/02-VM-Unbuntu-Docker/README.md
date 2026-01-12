# Atelier 2 : Mise en Place d'une VM et d'un Conteneur Docker

## Objectif

Dans cet atelier, j'ai configuré ma propre machine virtuelle et déployé un conteneur Docker exécutant une application web. L'objectif était de mettre en pratique la théorie sur les machines virtuelles, Docker et la configuration réseau.

## Étapes réalisées

### 1. Mise en place de la VM

- J'ai installé VirtualBox sur ma machine hôte.
- J'ai créé une VM nommée `UbuntuDev` avec Ubuntu Server 64-bit.
- J'ai attribué 2 Go de RAM et 20 Go de stockage en VDI dynamique.
- J'ai installé Ubuntu à partir de l'image ISO téléchargée. Étant sur un Mac avec puce Apple Silicon, j'ai dû choisir une image ARM 64.
- J'ai configuré le réseau en mode Pont pour que ma VM soit visible sur le réseau local.
- J'ai installé et activé le serveur SSH pour me connecter à la VM depuis mon hôte.

### 2. Installation et configuration de Docker

- J'ai installé Docker sur ma VM en suivant les instructions officielles pour Ubuntu.
- J'ai téléchargé l'image Nginx depuis le registre Docker.
- J'ai lancé un conteneur Nginx en arrière-plan avec le port 80 de la VM exposé.
- J'ai vérifié que le conteneur était opérationnel via `docker ps` et `curl localhost`.

### 3. Accès à l'application web

- Depuis mon navigateur sur la machine hôte, j'ai configuré le port forwarding ou utilisé l'adresse IP de la VM pour accéder à Nginx.
- La page d'accueil par défaut de Nginx s'affiche correctement, ce qui confirme que le conteneur fonctionne.

### 4. Configuration réseau avancée

- J'ai exploré les différents types de réseau dans VirtualBox : NAT, Pont et Interne.
- J'ai testé la configuration d'une adresse IP statique via Netplan pour la VM.
