#!/bin/bash

# Étape 1 : Télécharger la dernière version stable de Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Étape 2 : # Rendre le binaire exécutable
chmod +x /usr/local/bin/docker-compose

# Étape 3 : Mettez à jour la liste de paquets
apt update

# Étape 4 : Vérifier l'installation
docker-compose --version

# Étape 5 : Teste docker avec le container Hello World
docker run hello-world