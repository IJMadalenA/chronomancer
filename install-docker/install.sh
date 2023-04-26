#!/bin/bash

apt-get update
apt-get install apt-transport-https ca-certificates curl software-properties-common

# Descargar e instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

apt-get update

# Añadir el usuario actual al grupo de docker para evitar usar sudo
usermod -aG docker $(whoami)
usermod -aG docker jenkins
