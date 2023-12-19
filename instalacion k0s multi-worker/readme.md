## Índice de contenidos
* [Referencias](#item1)
* [Que es k0s?](#item2)
* [Arquictetura](#item4)
* [Requerimientos](#item5)
* [Configuracion k0sctl](#item6)

<a name="item1"></a>
## Referencias

**Documentacion oficial**
- https://docs.k0sproject.io/v1.28.4+k0s.0/
- https://docs.k0sproject.io/v1.28.4+k0s.0/k0sctl-install/
- 
<a name="item2"></a>
## Que es k0s?

k0s es una distribución de Kubernetes con todo incluido y de código abierto, que está configurada con todas las funciones necesarias para crear un clúster de Kubernetes.k0s se distribuye como un único binario sin dependencias del sistema operativo del host además del kernel del sistema operativo del host. Funciona con cualquier Linux sin paquetes de software ni configuración adicionales.

<a name="item3"></a>
## Arquictetura

En este caso vamso a instalar con la arquictectura multi-node

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/instalacion%20k0s%20multi-worker/imagenes/ssh-key-config.JPG)

<a name="item4"></a>
## Requerimientos

**Revisar la documentacion oficial** 
- https://docs.k0sproject.io/v1.28.4+k0s.0/system-requirements/
- https://docs.k0sproject.io/v1.28.4+k0s.0/networking/
, nombrare los mas resaltantes .

Arquictetura soportada

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/instalacion%20k0s%20multi-worker/imagenes/arquitectura.JPG)

Memoria minuma requeridad

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/instalacion%20k0s%20multi-worker/imagenes/requerimientos-1.JPG)

Minimo almacenamiento necesario

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/instalacion%20k0s%20multi-worker/imagenes/storage.JPG)

Puertos necesarios

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/instalacion%20k0s%20multi-worker/imagenes/puertos.JPG)

<a name="item5"></a>
## Creacion de llave ssh

Antes de empezar la configuracion hay que crear la llave ssh desde host donde se va realizar la configuracion
```
ssh-keygen
```
Una ves creada la llave ssh realizamos la configuracion de llave en los diferentes host , puede copiarla en los host correspodientes o hacer la configuracion  `ssh-copy-id`

![Diagrama]()

<a name="item6"></a>
## Instalacion k0sctl y kubectl

k0sctl es una herramienta de línea de comandos para iniciar y administrar clústeres k0s. k0sctl se conecta a los hosts proporcionados mediante SSH y recopila información sobre los hosts, con los que forma un clúster configurando los hosts, implementando k0s y luego conectando los nodos k0s.

Para mayor facilidad puede ejecutar el scrip del repositorio esto ayudara a instalar k0sctl y kubectl en el host que controlara el cluster kubernetes
```
touch install-binary-and-kubeclt.sh
chmod +x install-binary-and-kubeclt.sh
```
Una ves creado y darle los permisos necesarios podemos ejecutar el scrip

```
./install-binary-and-kubeclt.sh
```

<a name="item7"></a>
## Configuracion k0sctl

Generar el archivo k0sctl.yaml este archivo contiene las configuraciones que realizara

```
k0sctl init > k0sctl.yaml
```
Antes de aplicar las configuraciones editar su archivo k0sctl.yaml, una ves realizada los nuevos parametros podemos aplicar la configuracion

```
k0sctl apply --config k0sctl.yaml
```
Luego generamos nuestro archivo kubeconfig 

```
k0sctl kubeconfig > kubeconfig
```
Ya luego de esto podemos acceder a nuestro recursos para verificar la informacion de la instalacion puede ejecutar el siguiente comando

```
kubectl get pods --kubeconfig kubeconfig -A
```
y para mayor comodidad puede exportar la ubicacion de su archivo kubeconfig para solo realizar las consultas con kubectl

```
export KUBECONFIG="$(pwd)/kubeconfig"
```






