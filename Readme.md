PROJET DEVOPS - Orchestration



1) Introduction
La société IC GROUP souhaite mettre en place un site web vitrine pour accéder à ses 02 applications phares :

Odoo - Un ERP permettant de gérer plusieurs aspects de l'entreprise comme les ventes, la comptabilité, les achats, etc.

pgAdmin - Un outil d'administration de bases de données PostgreSQL.

Le but de ce projet est de conteneuriser ces deux applications et de déployer l'ensemble dans un cluster Kubernetes.

2) Prérequis
Outils à installer
Avant de commencer, tu dois installer les outils suivants sur ton système :

Docker : Pour créer des images et gérer des containers.

Minikube : Pour créer un cluster Kubernetes local.

kubectl : Pour interagir avec le cluster Kubernetes.


📅 Etapes du projet



Installation des outils de base

![Texte alternatif](images/installation_2025.png)



Installation de docker

![Texte alternatif](images/install_docker.png)




Installation de git et Installation de kubectl

![Texte alternatif](images/Install_git.png)




Installation de minikube + configuration du fichier Dockerfile

![Texte alternatif](images/Install_minikub.png)



Je créé un fichier requirements.txt avec nano.
 C’est pour que Docker installe cette version précise de Flask dans mon image.

 docker build -t ic-webapp:1.0 .
J’ai construit une image Docker depuis le Dockerfile de mon dossier courant (.).
Je lui ai donné le nom ic-webapp et le tag 1.0.

👉 À la fin, j’obtiens une image locale prête à être testée ou poussée.

🧱 docker tag ic-webapp:1.0 adam2696/ic-webapp:1.0
J’ai "renommé" l’image avec un tag Docker Hub pour pouvoir la pousser en ligne.
adam2696 c’est mon identifiant Docker Hub.

👉 C’est une exigence pour pouvoir la publier sur mon Docker Hub.

![Texte alternatif](images/Requirement_docker_build.png)




🧱 docker login -u adam2696
Je me suis connecté à Docker Hub avec mon identifiant.

🧱 docker push adam2696/ic-webapp:1.0
J’ai envoyé mon image Docker vers Docker Hub.
✅ L’image est maintenant disponible en ligne.

🧱 minikube start --driver=docker
J’ai lancé un cluster Kubernetes local avec Minikube en utilisant Docker comme moteur.

🧱 kubectl create namespace icgroup
J’ai créé un namespace Kubernetes nommé icgroup pour isoler mes ressources.

🧱 kubectl label namespace icgroup env=prod
J’ai ajouté un label env=prod à ce namespace (pratique pour l'organisation).

🧱 kubectl apply -f ic-webapp-deployment.yaml -n icgroup
J’ai déployé mon application (Deployment + Service) dans le namespace icgroup.

![Texte alternatif](images/Connexion_docker_image.png)

Vérfication de la création de l'image sur DockerHub
![Texte alternatif](images/Docker_image_prete.png)


Exposer un service Kubernetes

La commande kubectl expose permet de rendre un déploiement accessible depuis l'extérieur du cluster Kubernetes. Elle expose le déploiement sous forme de service et spécifie le type de service (ici NodePort) ainsi que le port sur lequel il doit être accessible.

Vérifier les services

La commande kubectl get services -n icgroup liste les services actifs dans le namespace icgroup. Cela permet de vérifier les adresses IP internes, les ports attribués ainsi que les types de services (ici NodePort), ce qui te permet de savoir comment accéder à chaque service.

Accéder à un service via Minikube

La commande minikube service ouvre un service spécifique dans ton navigateur. Elle utilise l'adresse IP du cluster local Minikube et le port exposé du service pour te permettre d'accéder à ton application web via une URL locale.

![Texte alternatif](images/Exposition_port.png)



kubectl get pods -n icgroup : Liste les pods dans le namespace icgroup et vérifie leur état.

Création du Service : Le fichier YAML expose l'application via un service NodePort, accessible sur un port externe (30641).

kubectl apply -f ic-webapp-service.yaml : Applique la configuration du service pour exposer l'app dans le cluster.

kubectl describe svc ic-webapp -n icgroup : Donne des détails sur le service, comme son port externe et ses endpoints.

![Texte alternatif](images/webapp-service_yaml.png)


Création du fichier ic-wobapp-doploymont.yaml
![Texte alternatif](images/webapp-serviceyaml.png)

Création du fichier configurer les paramètres de l' instance Odoo Ce fichier est essentiel pour l'initialisation et la configuration d'Odoo
![Texte alternatif](images/instance_odoos.png)

Création du fichier odoo-deploymont.yaml
![Texte alternatif](images/odoo-deploymont.png)


Création du fichier odoo-db-doploymont.yaml
![Texte alternatif](images/odoo-db-doploymont1.png)

Création du fichier pgadmin-deployment.yaml
![Texte alternatif](images/images/images/pgadmin-deployment.png)
![Texte alternatif](images/images/images/pgadmin-deployment2.png)
