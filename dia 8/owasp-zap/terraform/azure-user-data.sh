#! /bin/bash
# Install Docker and Apache
apt-get update
apt-get install docker.io -y
apt-get install apache2 -y
rm -rf /var/www/html/*

# Ejecutar contenedores
docker run -d --name webgoat -p 8080:8080 webgoat/webgoat-8.0