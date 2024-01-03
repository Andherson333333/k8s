## Índice de contenidos
* [Requisitos](#item1)
* [Que es metallb?](#item2)
* [Características de MetalLB](#item3)
* [Que es nginx ingress?](#item4)
* [Instalacion metallb y nginx](#item5)
* [despligue de manifiestos](#item6)
* [Verificacion de instalacion](#item7)
* [Configuracion metallb](#item8)
* [Configuracion del nginx-ingress](#item9)
* [Creacion manifiestos y despliegue](#item10)

<a name="item1"></a>
## Requisitos

Antes de instalar se tiene que tener configurado un cluster kubernetes , cabe destacar que que esta instalacion se esta haciendo en bare-metal

<a name="item2"></a>
## Que es metallb?

MetalLB es una solución de software pura que proporciona una implementación de equilibrador de carga de red para clústeres de Kubernetes que no están implementados en un proveedor de nube compatible que utiliza protocolos de enrutamiento estándar. Al instalar la solución MetalLB, obtiene efectivamente los servicios LoadBalancer dentro de su clúster de Kubernetes.

![Diagrama]()

<a name="item3"></a>
## Características de MetalLB

MetalLB proporciona una implementación de balanceador de carga que se puede configurar para usar ARP (layer 2) o BGP (layer 3) para anunciar direcciones IP de servicio.

**ARP (layer2)**

La dirección IP del servicio se publica enviando respuestas ARP (Protocolo de Resolución de Direcciones) en la red local. Este método funciona en la capa de enlace de datos del modelo OSI (capa 2). El administrador solo tiene que proporcionar un rango de direcciones IP para ser utilizado por MetalLB.

**BGP**

La dirección IP del servicio se publica con solicitudes BGP al enrutador. Este método funciona en la capa de red del modelo OSI (capa 3).
El administrador debe proporcionar los siguientes elementos para configurar MetalLB con BGP:

- La dirección IP del router.
- El número AS (Sistema Autónomo) del router.
- Un número AS privado para ser utilizado por MetalLB.
- El prefijo CIDR de rango de direcciones IP que utilizará MetalLB.

<a name="item4"></a>
## Que es nginx ingress?

En Kubernetes, un Ingress es un objeto que permite el acceso a sus servicios de Kubernetes desde fuera del clúster de Kubernetes. Configura el acceso creando una colección de reglas que definen qué conexiones entrantes alcanzan qué servicios.

![Diagrama]()

<a name="item5"></a>
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

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-1.JPG)

<a name="item6"></a>
## despligue de manifiestos

Una ves descargado ambos manifiesto procedemos aplicarlo cabe destacar que automaticamente crea su propio namespace 

`Nginx`
```
 kubectl apply -f ingress-nginx-manifest.yaml
```

`Metallb`

```
kubectl apply -f metallb-native.yaml
```

<a name="item7"></a>
## Verificacion de instalacion

Para verificar la instalacion usamos los siguientes comandos:

Aqui se verificara los namespace si se crearon correctamente
```
kubectl get ns
```

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-2.JPG)

Metallb pod y servicios verificacion (por cada nodo tiene que haber un speaker)
```
kubectl get pod -n metallb-system && kubectl get svc -n metallb-system
```
![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-8.JPG)

nginx pod y servicios verificacion 
```
kubectl get pod -n ingress-nginx &&  kubectl get svc -n ingress-nginx
```
![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-9.JPG)

<a name="item8"></a>
## Configuracion metallb

Vamos usar la configuracion Layer2 (arp), para usar esta configuracion se crearan 2 manifiestos :

- El primer manifiesto contendra el pool de las ip `poolIP.yml`
- El segundo manifiesto se encarga de anunciar las ip al swict `L2Advertisement.yml`

verificacions la creacion del pool y el anuncio
```
 kubectl get  l2Advertisement -n metallb-system
```

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-3.JPG)


`Nota :` para verificar el funcinamiente puede crear un servicio como loadbalancer

<a name="item9"></a>
## Configuracion del nginx-ingress

Hay que realizar un pequeño cambio en el servicio de ingress ya que por defecto biene como NodePort hay que cambiarlo a tipo LoadBalancer

```
kubectl edit svc ingress-nginx-controller -n ingress-nginx
```
![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-4.JPG)

Realizamos el cambio

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-5.JPG)

<a name="item10"></a>
## Creacion manifiestos y despliegue 

Una ves configurado vamso a crear los manifiesto para probar toda la configuracion se crearan 3 manifiestos:

- deployment.yml
- service.yml
- ingress.yml

aplicamos los manifiesto y verificamos que funciones 

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-7.JPG)

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/ingress%2Bmetallb/imagenes/ingress-6.JPG)

















