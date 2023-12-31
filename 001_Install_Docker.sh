#!/bin/bash

# Étape 1 : Mettez à jour la liste de paquets
apt update -y && apt upgrade -y

# Étape 2 : Installez les dépendances nécessaires
apt install -y apt-transport-https ca-certificates curl software-properties-common

# Étape 3 : Ajoutez la clé GPG officielle de Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Étape 4 : Ajoutez le dépôt Docker à vos sources APT
#echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Étape 5 : ajout du référentiel Docker :
#add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Étape 6 : Mettez à jour à nouveau votre liste de paquets
apt update -y && apt upgrade -y

# Étape 7 : Installez Docker Engine
apt install -y docker-ce docker-ce-cli containerd.io  docker-buildx-plugin

# Étape 8 : Démarrez le service Docker et activez-le pour qu'il démarre automatiquement
systemctl start docker
systemctl enable docker

# Étape 9 : Vérifiez que Docker est installé avec succès
docker --version

# Étape supplémentaire : Ajoutez votre utilisateur au groupe "docker"
usermod -aG docker $USER

# Déconnexion/reconnexion pour que les modifications prennent effet
echo "-------------------------------------Version 1 -----------------------------------------"
echo "Veuillez vous déconnecter et vous reconnecter pour que les modifications prennent effet."
echo "----------------------------Create by NANDILLON Maxence---------------------------------"
