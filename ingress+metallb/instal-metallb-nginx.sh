#!/bin/sh

##Metallb
Metallb_Version=$(curl -s https://api.github.com/repos/metallb/metallb/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')
echo "MetalLB Version: $Metallb_Version"
wget https://raw.githubusercontent.com/metallb/metallb/v$Metallb_Version/config/manifests/metallb-native.yaml

##Nginx-ingress
url="https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/baremetal/deploy.yaml"
# Obtén la versión desde el enlace
Version=$(curl -s $url | grep 'image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller' | awk -F ':' '{print $3}' | cut -d '"' -f 1)
# Imprime la versión obtenida
echo "Versión del Ingress Nginx Controller: $Version"
# Descarga el manifiesto YAML usando wget
wget -O ingress-nginx-manifest.yaml $url



