#!/bin/bash

check_docker_compose() {
    if command -v docker-compose &> /dev/null
    then
        echo "Docker Compose is already installed."
        # Ajoutez ici les étapes supplémentaires du script
    else
        echo "Install Docker Compose before continuing."
		# Installer Docker-compose
		curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 |  wget -qi -

		# Rendre le fichier binaire exécutable
		 chmod +x docker-compose-linux-x86_64

		# Déplacer le fichier vers votre PATH
		 mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose

    fi
}

# Start Docker automatiquement au démarrage
 systemctl start docker &&   systemctl enable docker
 
# Appel de la fonction
check_docker_compose

### Création de la pile docker-compose ###

# Création du répertoire glpi pour le conteneur glpi
mkdir /glpi
cd /glpi


# Création du fichier de configuration glpi
YML_CONTENT="version: '2'

volumes:
  data:
  db:

services:
# mariaDB Container
  db:
    image: mariadb:11.1.1-rc
    restart: always
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    volumes:
      - db:/var/lib/mysql
    environment:
# It is strongly recommended to change these identifiers by other more secure ones.
# Don't forget to report them in the app service below.
      - MYSQL_ROOT_PASSWORD=rtpsw
      - MYSQL_PASSWORD=psw
      - MYSQL_DATABASE=glpi
      - MYSQL_USER=user
    healthcheck:
      test: ["CMD", "/usr/local/bin/healthcheck.sh", "--connect"]
      interval: 5s
      timeout: 5s
      retries: 3

#GLPI Container
  app:
    image: jr0w3/glpi
    restart: always
    ports:
      - 80:80
    depends_on:
      db:
        condition: service_healthy
    links:
      - db
    volumes:
      - ./app:/app
    environment:
      - MYSQL_PASSWORD=psw
      - MYSQL_DATABASE=glpi
      - MYSQL_USER=user
      - MYSQL_HOST=db
    healthcheck:
      test: ["CMD", "curl", "http://localhost", "-f"]
      interval: 5s
      timeout: 5s
      retries: 24"
	  
# Écrire le contenu dans un fichier YML
echo "$YML_CONTENT" > docker-compose.yml

# Config de l'utilisateur
echo "MYSQL_ROOT_PASSWORD with your own password which must be at least 16 characters long."
echo "MYSQL_ROOT_PASSWORD SHA2 with a SHA2 password obtained using the command:."

echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

# Demander à l'utilisateur d'entrer le nouveau SHA2
echo -n "Enter the new SHA-256 hash: "
read -s new_hash

# Remplacer la valeur existante dans le fichier docker-compose.yml
 sed -i "s/MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=$new_hash/" docker-compose.yml

# Fonction pour vérifier la mise à jour du mot de passe de root dans docker-compose.yml
check_password_update() {
    if grep -q "MYSQL_ROOT_PASSWORD=$new_hash" docker-compose.yml; then
        echo "GLPI root password was updated successfully in docker-compose.yml."
    else
        echo "Failed to update GLPI root password in docker-compose.yml."
    fi
}

# Appel de la fonction pour vérifier la mise à jour du mot de passe de root mariadb
check_password_update


# Déploiement de glpi
docker compose up -d

# Access the Graylog Web UI
echo "Now open the Graylog web interface using the URL http://IP_address:9000."

# Fonction pour vérifier si un dossier existe
check_directory() {
    if [ -d "$1" ]; then
        echo "$1"
    else
        echo "Error : The folder $1 does not existe on your machine."
        exit 1
    fi
}

# Chercher les chemins des dossiers spécifiés
glpi=$(check_directory "/glpi")
db=$(check_directory "/glpi/db")
app=$(check_directory "/glpi/app")

# Modifie le message en remplaçant les [...]
message="Think about modifying the folder permissions, if necessary  :
- db : $db
- app : $app
- glpi : $glpi"

# Envoi du message
echo "$message"
echo "----------------------------Create by NANDILLON Maxence---------------------------------"
