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

**Revisar la documentacion oficial** 
- https://docs.k0sproject.io/v1.28.4+k0s.0/system-requirements/
- https://docs.k0sproject.io/v1.28.4+k0s.0/networking/
, nombrare los mas resaltantes .

![Diagrama]()
![Diagrama]()
![Diagrama]()

| Protocolo | Puerto | Servicio          | Dirección                    | Notas                                                                                               |
|-----------|--------|-------------------|------------------------------|-----------------------------------------------------------------------------------------------------|
| TCP       | 2380   | etcd peers        | controller <-> controller    | Se utiliza para la comunicación entre los nodos controladores (controllers) de etcd.               |
| TCP       | 6443   | kube-apiserver     | worker, CLI => controller    | El kube-apiserver, componente del servidor de la API de Kubernetes, utiliza este puerto. Comunicación autenticada con certificados TLS de cliente de Kube y tokens de ServiceAccount con RBAC. |
| TCP       | 179    | kube-router        | worker <-> worker             | Sesiones de enrutamiento BGP entre pares de nodos de trabajador.                                      |
| UDP       | 4789   | Calico            | worker <-> worker             | Se utiliza para la capa de superposición VXLAN de Calico.                                             |
| TCP       | 10250  | kubelet            | controller, worker => host * | API autenticada de kubelet para la comunicación entre el nodo controlador, los nodos de trabajador y el host. |
| TCP       | 9443   | k0s-api            | controller <-> controller    | API de unión del controlador k0s, autenticación mediante token con TLS.                               |
| TCP       | 8132   | konnectivity       | worker <-> controller         | Konnectivity se utiliza como un túnel "inverso" entre el kube-apiserver y los kubelets de los nodos de trabajador. |


## Creacion de llave ssh

Antes de empezar la configuracion hay que crear la llave ssh desde host donde se va realizar la configuracion
```
ssh-keygen
```
Una ves creada la llave ssh realizamos la configuracion de llave en los diferentes host , puede copiarla en los host correspodientes o hacer la configuracion  `ssh-copy-id`

![Diagrama]()

## Instalacion k0sctl y kubectl

Para mayor facilidad puede ejecutar el scrip del repositorio esto ayudara a instalar k0sctl y kubectl en el host que controlara el cluster kubernetes
```
touch install-binary-and-kubeclt.sh
chmod +x install-binary-and-kubeclt.sh
```
Una ves creado y darle los permisos necesarios podemos ejecutar el scrip

```
./install-binary-and-kubeclt.sh
```

## Configuracion k0sctl






