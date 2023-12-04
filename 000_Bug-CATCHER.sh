#!/bin/bash

# Étape 1 : Mettez à jour la liste de paquets
apt update -y && apt upgrade -y

# Étape 2 : Résoudre les problèmes liés aux paquets manquants :
  # - Les erreurs liées aux paquets manquants peuvent être résolues en installant les paquets nécessaires.
  # - Cependant, veuillez noter que les noms des paquets peuvent varier en fonction de votre distribution.
  # - Assurez-vous d'avoir les paquets requis pour votre distribution (Linux)

# install sudo 
apt install sudo 

# curl :
apt install -y  curl 

# Certificates :
apt install -y apt-transport-https ca-certificates curl

# propriétés-logicielles-communes:
apt install -y software-properties-common

## APT Docker pour Debian
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Étape 3 : Ajoutez le packet gpg
  # Outil qui permet de chiffrer/déchiffrer mais aussi de signer 
apt install -y gnupg
apt install -y gpg


echo "------------------------------------ Version 1 -----------------------------------------"
echo "				           ___"
echo "				    ,_    '---'    _,"
echo "				    \ \`-._|\\_/|_.-' /"
echo "				     |   =)'T'(=   |"
echo "				      \   /\`\"\"\`\\   /"
echo "				       '._\\) (/_.'"
echo "				           | |"
echo "				          /\\ /\\"
echo "				          \\ T /"
echo "				          (/ \\)"
echo "				              ))"
echo "				             (("
echo "	  		 	              \\)"
echo "----------------------------Create by NANDILLON Maxence---------------------------------"
