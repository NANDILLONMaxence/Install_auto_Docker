#!/bin/bash

# Fonction pour vérifier et installer Docker.io si nécessaire
check_install_docker() {
    if command -v docker &> /dev/null; then
        echo "Docker is already installed. Proceeding with the script."
    else
        echo "Docker is not installed. Installing Docker.io..."
         apt update
         apt install docker.io -y
         usermod -aG docker $USER
        newgrp docker
        echo "Docker.io has been installed successfully."
    fi
}

# Appel de la fonction pour vérifier et installer Docker.io
check_install_docker

# Étapes pour installer les dépendances
 apt install -y curl wget

# Installer Docker-compose
 curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 |  wget -qi -

# Rendre le fichier binaire exécutable
 chmod +x docker-compose-linux-x86_64

# Déplacer le fichier vers votre PATH
 mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose

# Confirmer la version
docker-compose version

# Start Docker automatiquement au démarrage
 systemctl start docker &&   systemctl enable docker

### Provisionner le conteneur Graylog ###

# Création du fichier de configuration Graylog
YML_CONTENT="version: '2'
services:
  mongodb:
    image: mongo:4.2
    networks:
      - graylog
    volumes:
      - /mongo_data:/data/db
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.2
    volumes:
      - /es_data:/usr/share/elasticsearch/data
    environment:
      - http.host=0.0.0.0
      - transport.host=localhost
      - network.host=0.0.0.0
      - 'ES_JAVA_OPTS=-Xms512m -Xmx512m'
    ulimits:
      memlock:
        soft: -1
        hard: -1
    mem_limit: 1g
    networks:
      - graylog
  graylog:
    image: graylog/graylog:4.2
    volumes:
      - /graylog_journal:/usr/share/graylog/data/journal
    environment:
      - GRAYLOG_PASSWORD_SECRET=password@1234567890
      - GRAYLOG_ROOT_PASSWORD_SHA2=e1b24204830484d635d744e849441b793a6f7e1032ea1eef40747d95d30da592
      - GRAYLOG_HTTP_EXTERNAL_URI=http://192.168.1.2:9000/
    entrypoint: /usr/bin/tini -- wait-for-it elasticsearch:9200 --  /docker-entrypoint.sh
    networks:
      - graylog
    links:
      - mongodb:mongo
      - elasticsearch
    restart: always
    depends_on:
      - mongodb
      - elasticsearch
    ports:
      - 9000:9000
      - 1514:1514
      - 1514:1514/udp
      - 12201:12201
      - 12201:12201/udp
volumes:
  mongo_data:
    driver: local
  es_data:
    driver: local
  graylog_journal:
    driver: local
networks:
  graylog:
    driver: bridge"

# Écrire le contenu dans un fichier YML
echo "$YML_CONTENT" > docker-compose.yml

# Fonction pour vérifier l'existence du fichier docker-compose.yml
check_docker_compose_file() {
    file_path=$(find / -type f -name "docker-compose.yml" 2>/dev/null)

    if [ -n "$file_path" ]; then
        echo "The docker-compose.yml file was found at:"
        echo "$file_path"
        echo "Docker-compose.yml configuration file created successfully."
    else
        echo "The docker-compose.yml file was not found on the machine."
    fi
}

# Appel de la fonction pour vérifier le fichier docker-compose.yml
check_docker_compose_file

# Config de l'utilisateur
echo "GRAYLOG PASSWORD_SECRET with your own password which must be at least 16 characters long."
echo "GRAYLOG ROOT_PASSWORD SHA2 with a SHA2 password obtained using the command:."

echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

# Demander à l'utilisateur d'entrer le nouveau SHA2
echo -n "Enter the new SHA-256 hash: "
read -s new_hash

# Remplacer la valeur existante dans le fichier docker-compose.yml
 sed -i "s/GRAYLOG_ROOT_PASSWORD_SHA2=.*/GRAYLOG_ROOT_PASSWORD_SHA2=$new_hash/" docker-compose.yml

# Fonction pour vérifier la mise à jour du mot de passe de root dans docker-compose.yml
check_password_update() {
    if grep -q "GRAYLOG_ROOT_PASSWORD_SHA2=$new_hash" docker-compose.yml; then
        echo "Graylog root password was updated successfully in docker-compose.yml."
    else
        echo "Failed to update Graylog root password in docker-compose.yml."
    fi
}

# Appel de la fonction pour vérifier la mise à jour du mot de passe de root
check_password_update

# Demander à l'utilisateur de saisir l'adresse IP URI externe HTTP Graylog
echo -n "Enter the IP address for GRAYLOG_HTTP_EXTERNAL_URI: "
read graylog_ip

# Remplacer la valeur existante dans le fichier docker-compose.yml
 sed -i "s|GRAYLOG_HTTP_EXTERNAL_URI=.*|GRAYLOG_HTTP_EXTERNAL_URI=http://$graylog_ip:9000/|" docker-compose.yml

# Fonction pour vérifier la mise à jour de l'URI externe HTTP dans docker-compose.yml
check_uri_update() {
    if grep -q "GRAYLOG_HTTP_EXTERNAL_URI=http://$graylog_ip:9000/" docker-compose.yml; then
        echo "GRAYLOG_HTTP_EXTERNAL_URI was updated successfully in docker-compose.yml."
    else
        echo "Failed to update GRAYLOG_HTTP_EXTERNAL_URI in docker-compose.yml."
    fi
}

# Appel de la fonction pour vérifier la mise à jour de l'URI externe HTTP
check_uri_update

# Create Persistent volumes
 mkdir /mongo_data
 mkdir /es_data
 mkdir /graylog_journal

# Set the right permissions:
 chmod 777 -R /mongo_data
 chmod 777 -R /es_data
 chmod 777 -R /graylog_journal

# Exécutez le serveur Graylog dans les conteneurs Docker
docker-compose up -d

# Une fois que toutes les images ont été extraites et les conteneurs démarrés, vérifiez l'état comme ci-dessous :
docker ps

# Access the Graylog Web UI
echo "Now open the Graylog web interface using the URL http://IP_address:9000."