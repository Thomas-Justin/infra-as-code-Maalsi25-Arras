# TP OpenTofu – Node.js + PostgreSQL + Redis

## 1. Mise en place du projet

- Dossier : `opentofu-pro-demo`
- Structure :
  opentofu-pro-demo/
  ├── main.tf
  ├── README.md
  └── api/
  ├── Dockerfile
  ├── index.js
  └── package.json
- API Node.js avec endpoints :
  - `/health` → vérification PostgreSQL et Redis
  - `/products` → données de démo

## 2. Définition de l’infrastructure

- Réseau Docker dédié : `opentofu_stack`
- Volumes persistants :
  - PostgreSQL : `pg_data`
  - Redis : `redis_data`
- Conteneurs :
  1. `postgres` (PostgreSQL 16)
  2. `redis` (Redis 7)
  3. `opentofu-api` (Node.js)
- Dépendances : l’API démarre après PostgreSQL et Redis
- Déploiement déclaré via OpenTofu

## 3. Paramétrage des variables

- Port API : `3000`
- Base de données : `demo_db`
- PostgreSQL : `demo_user` / `demo_pass`
- Redis : `demo_pass`

## 4. Déploiement avec OpenTofu

```bash
# Initialisation
tofu init

# Vérification du plan
tofu plan

# Application
tofu apply -auto-approve
```

## 5. Vérification du déploiement

# Liste des conteneurs

docker ps

# Test endpoints

curl http://localhost:3000/health
curl http://localhost:3000/products

## 6. Exploration du résultat

Accès navigateur : http://localhost:3000

Résultat :

Produits depuis PostgreSQL

Cache Redis opérationnel

Conteneurs isolés via Docker

## 7. Nettoyage de l’environnement

`tofu destroy`
Volumes peuvent être conservés ou supprimés
