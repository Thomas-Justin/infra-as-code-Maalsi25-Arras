# Atelier 2 : Mise en Place d'une VM et d'un Conteneur Docker

## Objectif

Cet atelier consiste à configurer une machine virtuelle et à déployer un conteneur Docker exécutant une application web. L'objectif est de mettre en pratique les concepts de virtualisation, de conteneurs et de configuration réseau.

## Étapes réalisées

### 1. Mise en place de la VM

- VirtualBox a été installé sur la machine hôte.
- Une VM nommée `UbuntuDev` a été créée avec Ubuntu Server 64-bit.
- La VM a été configurée avec 2 Go de RAM et 20 Go de stockage en VDI dynamique.
- Ubuntu a été installé à partir d'une image ISO. Sur un Mac équipé d'une puce Apple Silicon, une image ARM 64 a été utilisée.
- Le réseau a été configuré en mode Pont afin que la VM soit visible sur le réseau local.
- Le serveur SSH a été installé et activé pour permettre les connexions depuis la machine hôte.

### 2. Installation et configuration de Docker

- Docker a été installé sur la VM selon les instructions officielles pour Ubuntu.
- L'image Nginx a été téléchargée depuis le registre Docker.
- Un conteneur Nginx a été lancé en arrière-plan avec le port 80 de la VM exposé.
- La disponibilité du conteneur a été vérifiée via `docker ps` et `curl localhost`.

### 3. Accès à l'application web

- Le port 80 du conteneur a été rendu accessible depuis la machine hôte en configurant deux règles réseau :

  1. **Port forwarding (NAT)** : pour permettre à la machine hôte d’accéder au conteneur. Le port 8080 de l’hôte a été redirigé vers le port 80 de la VM dans VirtualBox. L'application est accessible via `http://127.0.0.1:8080`.
  2. **Réseau en Pont** : la VM reçoit une adresse IP sur le réseau local, permettant un accès direct depuis d'autres appareils du réseau. L'adresse IP statique a été configurée via Netplan dans `/etc/netplan/50-cloud-init.yaml` et appliquée avec `sudo netplan apply`.

- La page d'accueil par défaut de Nginx s'affiche correctement, confirmant que le conteneur fonctionne.

### 4. Configuration réseau avancée

- Différents types de réseau VirtualBox ont été explorés : NAT, Pont et Interne.
- La configuration d'une adresse IP statique a été testée pour la VM afin de simplifier l'accès aux services déployés.
