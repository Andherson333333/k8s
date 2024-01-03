## Requisitos

Antes de instalar se tiene que tener configurado un cluster kubernetes , cabe destacar que que esta instalacion se esta haciendo en bare-metal

## Que es metallb?

MetalLB es una solución de software pura que proporciona una implementación de equilibrador de carga de red para clústeres de Kubernetes que no están implementados en un proveedor de nube compatible que utiliza protocolos de enrutamiento estándar. Al instalar la solución MetalLB, obtiene efectivamente los servicios LoadBalancer dentro de su clúster de Kubernetes.

## Que es nginx ingress?

En Kubernetes, un Ingress es un objeto que permite el acceso a sus servicios de Kubernetes desde fuera del clúster de Kubernetes. Configura el acceso creando una colección de reglas que definen qué conexiones entrantes alcanzan qué servicios.

## Instalacion metallb y nginx

Para ver una los metodos de instalacion por favor ir a la documentacion oficial:

`metallb` https://metallb.org/installation/
`ngnix` https://kubernetes.github.io/ingress-nginx/deploy/

En esta caso lo vamos hacer mediante  Manifests , en el repositorio hay un scrip que descarga el manifiesto con la ultima version disponible

```
lsb_release -a
```
```
lsb_release -a
```
## Instalacion 


