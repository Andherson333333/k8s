#!/bin/bash

# Obtener la última versión disponible desde la página de lanzamientos de GitHub
version=$(curl -s https://api.github.com/repos/k0sproject/k0sctl/releases/latest|grep tag_name | cut -d '"' -f 4)

#Descargar Binario
curl -LO https://github.com/k0sproject/k0sctl/releases/download/$version/k0sctl-linux-x64

#Permisos de ejecuacion
chmod +x k0sctl-linux-x64

#Cambio de nombre
mv k0sctl-linux-x64 k0sctl

#Mover de ruta
sudo mv k0sctl /usr/local/bin/

# Instalacion de kubeclt
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt-get install -y  kubectl

