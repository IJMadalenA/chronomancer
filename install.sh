#!/bin/bash
# Script de instalación de Docker en Ubuntu/Debian

# Actualizar índice de paquetes
apt-get update

# Instalar paquetes necesarios para descargar paquetes a través de HTTPS
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Agregar la clave GPG oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Agregar el repositorio de Docker al sistema
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar el índice de paquetes nuevamente después de agregar el repositorio
apt-get update

# Instalar Docker
apt-get install -y docker-ce docker-ce-cli containerd.io

# Agregar el usuario actual al grupo de docker para evitar tener que usar sudo cada vez que se utiliza Docker
usermod -aG docker "$USER"
usermod -aG docker jenkins

# Comprobar la versión de Docker instalada
docker --version
