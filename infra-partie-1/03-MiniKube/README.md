# Atelier 3 - Déploiement d’un service Nginx avec Minikube sur une VM Ubuntu

## Pré-requis

Une machine virtuelle Ubuntu fonctionnelle

Un accès terminal à la VM

Docker installé et démarré

Une connexion Internet active

1. Vérification de l’environnement
   1.1 Vérification du système Ubuntu

Commande utilisée :

lsb_release -a

Cette commande permet de vérifier la version et la distribution d’Ubuntu installée sur la VM.

1.2 Vérification de Docker

Commande utilisée :

`sudo docker ps`

L’affichage d’une liste vide ou contenant des conteneurs indique que Docker fonctionne correctement.

1.3 Activation de Docker au démarrage (recommandé)

Vérification du service :

`sudo systemctl status docker`

Si le service n’est pas actif :

`sudo systemctl start docker`  
`sudo systemctl enable docker`

2. Autorisation de l’utilisateur à utiliser Docker

Minikube ne doit pas être exécuté avec les privilèges administrateur.
L’utilisateur courant est donc ajouté au groupe docker.

Commandes utilisées :

`sudo usermod -aG docker $USER`
`newgrp docker`

Aucune erreur de permission ne doit apparaître.

3. Installation de kubectl
   Installation via Snap
   `sudo apt update`
   `sudo apt install -y snapd`
   `sudo snap install kubectl --classic`

Validation
`kubectl version --client`

4. Installation de Minikube

Remarque
La VM étant exécutée sur un Mac avec puce Apple Silicon, l’architecture utilisée est ARM64.
La version ARM de Minikube est donc nécessaire.

Téléchargement de Minikube (ARM64)
`curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-arm64`

Rendre exécutable
`chmod +x minikube-linux-arm64`

Installation dans le système
`sudo mv minikube-linux-arm64 /usr/local/bin/minikube`

Validation
`minikube version`

5. Démarrage du cluster Minikube

Minikube est lancé en utilisant Docker comme driver.

`minikube start --driver=docker`

Vérification de l’état du cluster
`minikube status`
`kubectl get nodes`

Le nœud minikube doit être en état Ready.

6. Déploiement de Nginx
   Création du Deployment
   `kubectl create deployment nginx --image=nginx`

Vérification
`kubectl get deployments`
`kubectl get pods`

Un pod nginx-xxxxx doit apparaître avec le statut Running.

7. Exposition du service Nginx
   Création du Service de type NodePort
   `kubectl expose deployment nginx --type=NodePort --port=80`

Vérification
`kubectl get services`

Un service nginx avec un port du type 80:3xxxx/TCP doit être visible.

8. Accès au service Nginx
   Récupération de l’URL
   `minikube service nginx --url`

Une URL de la forme suivante est normalement fournie :
`http://192.168.xx.xx:3xxxx`

9. Test du service
   Test depuis la machine virtuelle
   `curl $(minikube service nginx --url)`

La page HTML par défaut de Nginx doit être retournée, confirmant le bon fonctionnement du service.

10. Exploration des ressources Kubernetes (optionnel)
    `kubectl get all`  
    `kubectl describe pod -l app=nginx`
    `kubectl logs -l app=nginx --tail=50`

11. Nettoyage de l’environnement
    Suppression des ressources Nginx
    `kubectl delete service nginx`  
    `kubectl delete deployment nginx`

Arrêt et suppression du cluster (optionnel)
`minikube stop`
`minikube delete`
