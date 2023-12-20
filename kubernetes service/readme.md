## Que en  es un servicio de kubernetes ?

En Kubernetes, un servicio es un recurso abstracto que define un conjunto lógico de Pods y una política por la cual acceder a ellos. Proporciona una forma estable de acceder a la funcionalidad ofrecida por los conjuntos de Pods, independientemente de su ubicación exacta en la red o de cuántos Pods estén ejecutándose. Los servicios permiten la exposición de aplicaciones y componentes dentro del clúster, así como también pueden ser utilizados para la exposición externa a través de balanceadores de carga.

##  Redes Overlay

Una red superpuesta (en inglés, overlay network)1​ es una red virtual de nodos enlazados lógicamente, que está construida sobre una o más redes subyacentes (underlying network). Se dice que los nodos de la red superpuesta están conectados por enlaces virtuales. Su objetivo es implementar servicios de red que no están disponibles en la/s red/es subyacente/s. Las redes superpuestas pueden apilarse de forma que tenga capas que proporcionen servicios a la capa superior.

Las redes Overlay son aplicadas para crear una red virtual encima de la red principal que seria a le red LAN de los nodos

## Tipos de servicio

Funcion basico de un service se consta de 3 variables

1 Loadbalancer
2 descubrir servicios
3 Exporner los servicios

Hay 3 tipos de servicio en kubernetes:

ClusteIP: es la configuracion por default que trae al crear el servicio este se encarga de balancear la carga de los pod (round robin) , y descubrir los servicios a traves de labels && selector 

NodePort: Se encarga de dar acceso a los pod a traves de los nodos se usa generalmente en una red LAN .

LoadBalancer: Este modo se encarga de dar acceso externo a los pod a traves de un Loadbalancer , esto se aplica 


## Comandos y pruebas

Se va a realizar varias pruebas para verificar las funciones de los tipos de redes y mas


1)Verificacacion de funcion de ClusterIP

IP de los Pod

al destruir el pod como se ve cambia la ip , ahora para descubrir y mapiar ese servicio kubernetes usa los labels & selector como se ven a continuacion





