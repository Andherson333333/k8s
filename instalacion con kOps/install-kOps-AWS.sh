#!/bin/bash

# Solicitar las claves de acceso de AWS
echo "Ingrese la Clave de Acceso de AWS:"
read awsaccess

echo "Ingrese la Clave Secreta de AWS:"
read awssecret

# Solicitar detalles del clúster
echo "Ingrese el Nombre del Clúster: (por ejemplo, my-kube.k8s.local)"
read clname

echo "Ingrese una Zona de Disponibilidad para el clúster: (por ejemplo, us-east-1a)"
read az

# Actualizar el sistema
sudo apt update

# Descargar kubectl y python3
sudo apt-get install -y python3-pip apt-transport-https kubectl

# Descargar kOps
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64

# Otorgar permisos de ejecución al archivo kOps descargado y moverlo a la ruta de binarios
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Configurar el perfil de usuario de AWS
aws configure set aws_access_key_id $awsaccess
aws configure set aws_secret_access_key $awssecret

# Crear una clave que kOps pueda usar para iniciar sesión en el clúster
ssh-keygen -N "" -f $HOME/.ssh/id_rsa

# Crear un bucket S3 donde kOps guardará toda la información del estado del clúster.
aws s3 mb s3://$clname
aws s3api put-bucket-versioning --bucket $clname --versioning-configuration Status=Enabled

# Exponer el bucket S3 como variables de entorno.
export KOPS_STATE_STORE=s3://$clname

# Crear el clúster con 2 nodos de trabajo.
kops create cluster --node-count=2 --master-size="t2.micro" --node-size="t2.micro" --master-volume-size=8 --node-volume-size=8 --zones=$az --name $clname

# Aplicar las especificaciones del clúster al clúster
#kops get cluster
#kops update cluster $clname --yes

# El archivo .bashrc es un archivo de script que se ejecuta cuando un usuario inicia sesión.
echo "export KOPS_STATE_STORE=s3://$clname" >> .bashrc
