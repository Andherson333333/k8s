## Requisitos

Antes de instalar se tiene que tener configurado un cluster kubernetes , cabe destacar que que esta instalacion se esta haciendo en bare-metal

## Que es metallb?

MetalLB es una solución de software pura que proporciona una implementación de equilibrador de carga de red para clústeres de Kubernetes que no están implementados en un proveedor de nube compatible que utiliza protocolos de enrutamiento estándar. Al instalar la solución MetalLB, obtiene efectivamente los servicios LoadBalancer dentro de su clúster de Kubernetes.

## Características de MetalLB

Características de MetalLB
MetalLB proporciona una implementación de balanceador de carga que se puede configurar para usar ARP (capa 2) o BGP (capa 3) para anunciar direcciones IP de servicio.

ARP
La dirección IP del servicio se publica enviando respuestas ARP (Protocolo de Resolución de Direcciones) en la red local. Este método funciona en la capa de enlace de datos del modelo OSI (capa 2).

El administrador solo tiene que proporcionar un rango de direcciones IP para ser utilizado por MetalLB.

BGP
La dirección IP del servicio se publica con solicitudes BGP al enrutador. Este método funciona en la capa de red del modelo OSI (capa 3).

El administrador debe proporcionar los siguientes elementos para configurar MetalLB con BGP:

La dirección IP del router.

El número AS (Sistema Autónomo) del router.

Un número AS privado para ser utilizado por MetalLB.

El prefijo CIDR de rango de direcciones IP que utilizará MetalLB.


## Que es nginx ingress?

En Kubernetes, un Ingress es un objeto que permite el acceso a sus servicios de Kubernetes desde fuera del clúster de Kubernetes. Configura el acceso creando una colección de reglas que definen qué conexiones entrantes alcanzan qué servicios.

## Instalacion metallb y nginx

Para ver una los metodos de instalacion por favor ir a la documentacion oficial:

`metallb` https://metallb.org/installation/

`ngnix` https://kubernetes.github.io/ingress-nginx/deploy/

En esta caso lo vamos hacer mediante manifiestos , en el repositorio hay un scrip que descarga el manifiesto con la ultima version disponible de ambos complementos copiar y pegar el contenido del `instal-metallb-nginx.sh` en su archivo y darle los permisos necesarios 

```
touch instal-metallb-nginx.sh
chmod +x
```
Luego ejecutar el scrip

```
./instal-metallb-nginx.sh
```

![Diagrama]()


## Instalacion 

Una ves descargado ambos manifiesto procedemos aplicarlo cabe destacar que automaticamente crea su propio namespace 

`Nginx`
```
 kubectl apply -f ingress-nginx-manifest.yaml
```

`Metallb`

```
kubectl apply -f metallb-native.yaml
```

## Verificacion de instalacion

Para verificar la instalacion usamos los siguientes comandos:

Aqui se verificara los namespace si se crearon correctamente
```
kubectl get ns
```

![Diagrama]()

Metallb pod y servicios verificacion
```
kubectl get pod -n metallb-system && kubectl get svc -n metallb-system
```
![Diagrama]()

nginx pod y servicios verificacion
```
kubectl get pod -n ingress-nginx &&  kubectl get svc -n ingress-nginx
```
![Diagrama]()


## Configuracion metallb

Vamos usar la configuracion Layer2 (arp), para usar esta configuracion se crearan 2 manifiestos :

1)El primer manifiesto contendra el pool de las ip 
2)El segundo manifiesto se encarga de anunciar las ip al swict















