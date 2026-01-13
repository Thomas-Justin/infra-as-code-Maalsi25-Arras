# Déploiement d'un conteneur Nginx avec OpenTofu et Docker

Ce projet montre comment utiliser OpenTofu pour gérer l’infrastructure locale Docker et déployer un conteneur Nginx.

---

## Étape 1 : Prérequis

Assurez-vous d’avoir installé et fonctionnel :

- Docker : `docker version`
- OpenTofu : `tofu version`

> **Note** : Contrairement à la documentation officielle Linux qui propose `apt-get install opentofu`, j’ai utilisé la méthode Snap car elle est plus simple et fonctionne bien sur Ubuntu ARM64.

Installation rapide via Snap :

```bash
sudo snap install --classic opentofu
alias tofu='opentofu.tofu'
tofu version
```

L’alias `tofu` permet de lancer OpenTofu avec la commande simplifiée.

## Étape 2 : Création du répertoire du projet

Créez un dossier pour votre projet IaC :

`mkdir opentofu-docker-demo`
`cd opentofu-docker-demo`

## Étape 3 : Création du fichier `main.tf`

```bash
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name     = "nginx"
  image    = docker_image.nginx.image_id
  must_run = false
  ports {
    internal = 80
    external = 8080
  }
}
```

Modifications apportées :

`host` du provider Docker modifié pour pointer vers le socket Linux `/var/run/docker.sock` (au lieu du chemin MacOS).

`must_run = false` pour permettre la destruction de l’image sans conflit avec le container.

## Étape 4 : Initialiser, planifier et appliquer OpenTofu

```bash
tofu init
tofu plan
tofu apply -auto-approve
```

Verifiez que les ressources ont bien été créées : `docker ps`
`http://localhost:8080`

## Étape 5 : Détruire l’infrastructure

`tofu destroy -auto-approve`

## Étape 6 : Gestion locale de l’état

OpenTofu crée un fichier terraform.tfstate dans le dossier du projet.
Ce fichier garde la trace des containers et images créés.

Bonnes pratiques :

- Ne jamais versionner ce fichier (.gitignore)

- Pour recommencer à zéro, supprimez le fichier terraform.tfstate et tous les containers/images liés.
