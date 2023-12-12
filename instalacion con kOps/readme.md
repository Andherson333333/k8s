## Ques es kOps?

Kops (Kubernetes Operations) es una herramienta de código abierto que facilita la creación, el mantenimiento y la operación de clústeres de Kubernetes. Fue desarrollado para simplificar el proceso de aprovisionamiento y gestión de clústeres de Kubernetes en entornos de infraestructura en la nube

## Requisitos antes de la instalacion

**Crear una maquina EC2 o en sistema operativo local linux:**
  - python3
  - AWS CLI
  - kubectl
  - SSH keys

**Crear usuario en AWS con los siguientes permisos:**
  - AmazonEC2FullAccess
  - AmazonRoute53FullAccess
  - AmazonS3FullAccess
  - IAMFullAccess
  - AmazonVPCFullAccess
  - AmazonSQSFullAccess
  - AmazonEventBridgeFullAccess

## Instalacion kOps

**Instalación del AWS CLI y otras dependencias**
```
sudo apt-get update
sudo apt install nano curl wget awscli -y
```
### Creación de usuario AWS
 **2.1 Crearlo a través de la GUI**
    - Acceda a la consola de AWS
    - Navegue a IAM -> Usuers -> Create user-->Attach policies directly

 **2.2 Crearlo a través de CLI (debe tener acceso de root o permisos para crear)**
   - Crear un archivo y copiar el contenido del script creacion-usuario-permisos.sh
```
touch creacion-usuario-permisos.sh
chmod +x creacion-usuario-permisos.sh
```
   - Luego, ejecute el script con el comando
```
./creacion-usuario-permisos.sh
```
   - Este script creará un grupo con los permisos requeridos y luego adjuntará ese usuario a ese grupo

### Una vez creado el usuario, copiaremos otro script en otro archivo**
```
touch install-kOps-AWS.sh
chmod +x install-kOps-AWS.sh
```
Luego, ejecute el script
```
./install-kOps-AWS.sh
```
**Al ejecutar el script, se le pedirá los siguientes parámetros:**
   - Ingrese la Clave de Acceso de AWS
   - Ingrese la Clave Secreta de AWS
   - Ingrese el Nombre del Clúster (por ejemplo, my-kube.k8s.local)
   - Ingrese una Zona de Disponibilidad para el clúster (por ejemplo, us-east-1a)

## Despligue de scrip
