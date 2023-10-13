#!/bin/bash

# Étape 1 : Mettez à jour la liste de paquets
apt update -y && apt upgrade -y

# Étape 2 : Résoudre les problèmes liés aux paquets manquants :
  # - Les erreurs liées aux paquets manquants peuvent être résolues en installant les paquets nécessaires.
  # - Cependant, veuillez noter que les noms des paquets peuvent varier en fonction de votre distribution.
  # - Assurez-vous d'avoir les paquets requis pour votre distribution (Linux)

# curl :
apt install curl 
# Certificates :
apt install -y apt-transport-https ca-certificates curl

# propriétés-logicielles-communes:
apt install software-properties-common

# Étape 3 : Ajoutez le packet gpg
  # Outil qui permet de chiffrer/déchiffrer mais aussi de signer 
apt install gnupg
apt install gpg


echo "------------------------------------ Version 1 -----------------------------------------"
					           echo ".-.       _.---._ __  / \
								 /  )    .-'        './ /   \
								(  (   .'            '/    /|
								 \  '-"             \'\   / |
								  '.              .  \ \ /  |
								   /'.          .'-'----Y   |
								  (            ;        |   '
								  |  .-.    .-'         |  /
								  |  | (   |   Box bug  | /
								  )  |  \  '.___________|/
								  '--'   '--'"
echo "----------------------------Create by NANDILLON Maxence---------------------------------"