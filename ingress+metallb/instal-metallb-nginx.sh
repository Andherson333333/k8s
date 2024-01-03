#!/bin/sh

Metallb_Version=$(curl -s https://api.github.com/repos/metallb/metallb/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')
echo "MetalLB Version: $Metallb_Version"

wget https://raw.githubusercontent.com/metallb/metallb/v$Metallb_Version/config/manifests/metallb-native.yaml



