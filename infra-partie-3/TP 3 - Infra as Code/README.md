📘 TP – Infrastructure as Code

WebSolutions Inc.

📌 Contexte

WebSolutions Inc. est une entreprise spécialisée dans le développement d’applications web.
Elle gère plusieurs applications internes nécessitant des environnements fiables, reproductibles et sécurisés.

Jusqu’à présent, les environnements étaient configurés manuellement, ce qui entraînait :

des différences entre les environnements de développement, de test et de production

un risque d’erreurs humaines

des déploiements longs et difficiles à maintenir

Afin d’améliorer ce processus, l’entreprise souhaite mettre en place une approche Infrastructure as Code (IaC).

🎯 Objectifs du TP

Ce TP a pour objectif de :

automatiser la création de l’infrastructure

garantir la cohérence des environnements

faciliter le déploiement des applications web

introduire des pratiques DevOps modernes

🛠️ Technologies utilisées
Terraform / OpenTofu

Rôle : Provisionnement de l’infrastructure

Terraform permet de décrire et de créer l’infrastructure sous forme de code.

Il est utilisé pour :

créer les machines virtuelles

configurer le réseau

définir les règles de sécurité (ports, firewall)

provisionner les environnements de développement et de test

Avantages :

infrastructure reproductible

versionnée via Git

déploiement rapide

cohérence entre les environnements

Ansible

Rôle : Configuration des serveurs

Ansible est utilisé pour configurer automatiquement les serveurs une fois créés par Terraform.

Il permet notamment :

d’installer les logiciels nécessaires (Nginx, Node.js, MySQL, etc.)

de configurer les services

d’appliquer des règles de sécurité

de garantir l’idempotence des configurations

Avantages :

simple à utiliser

sans agent

basé sur SSH

très adapté à l’automatisation

CI/CD (Pipeline de déploiement)

Rôle : Déploiement continu

Un pipeline de déploiement continu permet d’automatiser le cycle de vie de l’application.

Fonctionnement général :

Push du code sur le dépôt Git

Exécution des tests automatisés

Build de l’application

Déploiement automatique en environnement de test

Avantages :

réduction des erreurs

déploiements rapides

amélioration de la qualité du code

gain de temps pour les équipes

🗂️ Arborescence du projet
iac-websolutions/
│
├── terraform/
│ ├── main.tf # Définition de l’infrastructure
│ ├── variables.tf # Variables Terraform
│ ├── outputs.tf # Informations de sortie
│
├── ansible/
│ ├── playbook.yml # Playbook principal
│ ├── inventory.ini # Inventaire des serveurs
│ └── roles/
│ ├── web/
│ ├── app/
│ └── db/
│
├── ci-cd/
│ └── pipeline.yml # Exemple de pipeline CI/CD
│
└── README.md

🔄 Fonctionnement global

Terraform est exécuté pour créer l’infrastructure (VM, réseau, sécurité).

Ansible configure automatiquement les serveurs.

Le pipeline CI/CD déploie l’application après validation du code.

Les environnements sont cohérents et reproductibles.

⚠️ Difficultés rencontrées

Prise en main des outils IaC

Gestion de l’ordre d’exécution entre Terraform et Ansible

Séparation claire entre provisionnement et configuration

Sécurisation des accès et des mots de passe

🚀 Améliorations possibles

Gestion sécurisée des secrets (Vault, variables chiffrées)

Conteneurisation avec Docker

Orchestration avec Kubernetes

Ajout de monitoring (Prometheus, Grafana)

Mise en place de déploiements Blue/Green

Ajout d’un environnement de production

✅ Conclusion

L’utilisation de l’Infrastructure as Code permet de fiabiliser le déploiement des applications web tout en réduisant les erreurs humaines.
Cette approche améliore la maintenabilité, la sécurité et la rapidité de mise en production, tout en s’inscrivant dans une démarche DevOps moderne.
