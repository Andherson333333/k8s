## Referencias

**Documentacion oficial**
- https://docs.k0sproject.io/v1.28.4+k0s.0/
- https://docs.k0sproject.io/v1.28.4+k0s.0/k0sctl-install/

## Que es k0s

k0s es una distribución de Kubernetes con todo incluido y de código abierto, que está configurada con todas las funciones necesarias para crear un clúster de Kubernetes.k0s se distribuye como un único binario sin dependencias del sistema operativo del host además del kernel del sistema operativo del host. Funciona con cualquier Linux sin paquetes de software ni configuración adicionales.

## Arquictetura

En este caso vamso a instalar con la arquictectura multi-node

![Diagrama]()

## Requerimientos

## Creacion de llave ssh

Antes de empezar la configuracion hay que crear la llave ssh desde host donde se va realizar la configuracion
```
ssh-keygen
```
Una ves creada la llave ssh realizamos la configuracion de llave en los diferentes host , puede copiarla en los host correspodientes o hacer la configuracion  `ssh-copy-id`

![Diagrama]()

## Instalacion k0sctl y kubectl

## Configuracion k0sctl

