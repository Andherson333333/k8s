## Índice de contenidos 
* [Que es un servicio de kubernetes ?](#item1)
* [Redes Overlay](#item2)
* [Tipos de servicio](#item4)
* [Comandos y pruebas](#item5)


<a name="item1"></a>
## Que es un servicio de kubernetes ?

En Kubernetes, un servicio es un recurso abstracto que define un conjunto lógico de Pods y una política por la cual acceder a ellos. Proporciona una forma estable de acceder a la funcionalidad ofrecida por los conjuntos de Pods, independientemente de su ubicación exacta en la red o de cuántos Pods estén ejecutándose. Los servicios permiten la exposición de aplicaciones y componentes dentro del clúster, así como también pueden ser utilizados para la exposición externa a través de balanceadores de carga.

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/service-9.JPG)

<a name="item2"></a>
##  Redes Overlay

Una red superpuesta (en inglés, overlay network)1​ es una red virtual de nodos enlazados lógicamente, que está construida sobre una o más redes subyacentes (underlying network). Se dice que los nodos de la red superpuesta están conectados por enlaces virtuales. Su objetivo es implementar servicios de red que no están disponibles en la/s red/es subyacente/s. Las redes superpuestas pueden apilarse de forma que tenga capas que proporcionen servicios a la capa superior.

Las redes Overlay son aplicadas para crear una red virtual encima de la red principal que seria a le red LAN de los nodos

<a name="item3"></a>
## Tipos de servicio

**Funcion basico de un service se consta de 3 variables**
 - Loadbalancer
 - Descubrir servicios
 - Exporner los servicios

Hay 3 tipos de servicio en kubernetes:

`ClusteIP:` es la configuracion por default que trae al crear el servicio este se encarga de balancear la carga de los pod (round robin) , y descubrir los servicios a traves de labels && selector 

`NodePort:` Se encarga de dar acceso a los pod a traves de los nodos se usa generalmente en una red LAN .

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/node-port2.2.JPG)

`LoadBalancer:` Este modo se encarga de dar acceso externo a los pod a traves de un Loadbalancer , esto se aplica 

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/load-balancer-1.JPG)

<a name="item4"></a>
## Comandos y pruebas

Se va a realizar varias pruebas para verificar las funciones de los tipos de redes:

`ClusterIP`

IP de los Pod

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/service-1.JPG)

al destruir el pod como se ve cambia la ip ,

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/service-2.JPG)


 ahora para descubrir y mapiar ese servicio kubernetes usa los labels & selector como se ven a continuacion
 
![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/service-3.JPG)

`NodePort`

En esta prueba se verifica que pasa al aplicar NodePort comparado con el ClusterIP , como se ve por defecto la red Overlay se mantiene como ClusterIP
pero , el modo cambia al NodePort y se crean unos puertos para poder acceder a los pod cabe destacar que por defecto se crear puerto por encima del 30000

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/service-5.JPG)

`LoadBalancer`

Al realizar el modo Loadbalancer deberia crearse una Ip externa pero en este caso estamso trabajando sobre maquinas EC2 , por eso no da una ip externa al menos que se le configure un loadbalancer externo (esto se puede hacer con herramientos como Metallb entre otras).

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/service-6.JPG)

Configurado con metalb

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/kubernetes%20service/imagenes/Captura%20desde%202023-12-20%2019-52-38.png)


