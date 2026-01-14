# TP 04 – Déploiement d’un serveur Nginx avec Ansible

## Objectif

Ce TP a pour but de découvrir Ansible et les principes de la _configuration as code_ en automatisant le déploiement d’un serveur Nginx avec une page HTML personnalisée.  
L’exécution est réalisée localement dans un conteneur Docker afin de garantir un environnement portable et reproductible, sans dépendre du système hôte.

---

## Environnement

- Poste hôte : macOS / Windows / Linux
- Docker Desktop
- Image utilisée : `ubuntu:22.04`
- Ansible exécuté dans le conteneur

Ce choix permet d’utiliser les modules Ansible Linux (`apt`, `service`) de manière cohérente.

---

## Structure du projet

tp-04-ansible/
├── inventory.ini
└── playbook.yml

---

## Inventaire Ansible

L’inventaire utilise un format INI avec une exécution locale, sans SSH :

```ini
[local]
localhost ansible_connection=local
```

## Playbook Ansible

Le playbook définit un état cible pour la machine locale :

    mise à jour du cache des paquets,

    installation de Nginx,

    démarrage et activation du service,

    déploiement d’une page HTML personnalisée,

    affichage d’un message de fin.

L’élévation de privilèges est activée via become: yes afin de permettre l’installation de paquets et l’écriture dans `/var/www/html.`

## Déroulement du TP

    Création du dossier du projet et des fichiers Ansible.

    Lancement d’un conteneur Ubuntu avec un bind-mount du projet.

    Installation d’Ansible dans le conteneur.

    Test de la connectivité avec le module `ping`.

    Exécution du playbook Ansible.

    Vérification du serveur Nginx avec `curl`.

## Vérification de l’idempotence

Après une première exécution, le playbook est relancé sans modification :

    toutes les tâches sont en état ok.

Une modification manuelle du fichier HTML est ensuite effectuée :

    la tâche copy repasse en changed,

    les autres tâches restent inchangées.

Une nouvelle exécution confirme le retour à l’état cible.
