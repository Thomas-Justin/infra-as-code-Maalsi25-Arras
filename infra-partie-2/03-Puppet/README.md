# TP Puppet – Gestion d’état en mode local avec Docker

## Objectif

L’objectif de ce TP est de découvrir Puppet en mode local (`puppet apply`), sans serveur Puppet, afin de gérer un état cible de manière déclarative.  
L’exécution est réalisée dans un conteneur Docker Ubuntu afin de garantir un environnement Linux reproductible et indépendant de la machine hôte.

Le scénario consiste à :

- installer Nginx,
- démarrer et activer le service,
- déployer une page HTML personnalisée,
- vérifier l’idempotence de Puppet.

---

## Environnement utilisé

- Docker
- Image : `ubuntu:22.04`
- Puppet (mode standalone)
- Nginx
- curl (pour les tests HTTP)

L’utilisation de Docker permet d’éviter toute installation directe de Puppet sur le système hôte.

---

## Structure du projet

tp-03-puppet/
└── modules/
└── nginx/
└── manifests/
└── init.pp

Le module Puppet `nginx` est défini localement et monté dans le conteneur via un bind-mount.

---

## Description du manifeste Puppet

Le manifeste `init.pp` définit une classe `nginx` qui adapte son comportement selon le système d’exploitation détecté grâce aux facts Puppet.

- Sur Linux :
  - installation du paquet `nginx`,
  - démarrage et activation du service,
  - gestion du fichier `/var/www/html/index.html` avec un contenu personnalisé.
- Sur macOS et Windows :
  - démonstration limitée à la gestion d’un fichier, sans installation de paquet.

Les ressources Puppet utilisées sont :

- `package` pour garantir l’installation de Nginx,
- `service` pour assurer que le service est démarré et activé,
- `file` pour garantir l’existence et le contenu d’un fichier.

---

## Lancement de l’environnement Docker

Depuis la racine du projet, un conteneur Ubuntu est démarré avec le dossier `modules` monté dans le conteneur :

```bash
docker run -it --rm \
  -v "$PWD/modules:/modules" \
  ubuntu:22.04 bash
```

## Installation des dépendances dans le conteneur

Dans le conteneur Ubuntu :

```bash
apt update
apt install -y puppet nginx curl
```

## Validation du manifeste Puppet

Avant toute application, la syntaxe du manifeste est validée :

`puppet parser validate /modules/nginx/manifests/init.pp`

Aucune sortie indique que la syntaxe est correcte.

## Application du module Puppet

Le module est appliqué localement avec la commande suivante :

puppet apply --modulepath=/modules -e "include nginx"

Lors de la première exécution :

Nginx est installé,

le service est démarré et activé,

la page d’accueil est déployée.

## Vérification du résultat

Le bon fonctionnement du serveur est vérifié avec la commande :

`curl http://localhost`

Le contenu HTML personnalisé est correctement retourné par Nginx.

## Vérification de l’idempotence

La commande Puppet est relancée une seconde fois :

`puppet apply --modulepath=/modules -e "include nginx"`

Aucune ressource n’est modifiée, ce qui démontre l’idempotence du manifeste : l’état cible est déjà atteint.

## Nettoyage

La sortie du conteneur met fin à l’environnement de test :

`exit`

Le conteneur est automatiquement supprimé, garantissant un environnement propre et reproductible.
