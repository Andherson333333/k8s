## Índice de contenidos
* [Que es kubectl](#item1)
* [Que es admin.conf?](#item2)
* [Que es kubeconfig?](#item3)
* [Creacion de usuarios en kubernetes?](#item4)
* [Que es RBAC?](#item5)
* [Que es Role y  Rolebind?](#item6)
* [Que es ClusterRole ClusterRoleBind?](#item7)
* [Service account](#item8)
* [Verificacion y aplicacion](#item9)

<a name="item1"></a>
## Que es kubectl?

Es una herramienta de linea de comandos que se encarga de interactuar con el cluster de kubernetes, cabe destacar que es una herramienta que se instala en el lado del cliente 

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-3.PNG)

<a name="item2"></a>
## Que es admin.conf?

El archivo admin.conf es un archivo de configuración de Kubernetes que contiene información sobre cómo conectarse al clúster de Kubernetes y las credenciales necesarias para realizar operaciones administrativas. Este archivo puede varia en  diferentes ubicaciones dependiendo el tipo de instalacion distro ect . Para encontralo puede usar este comando `find / -name admin.conf` en linux

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-4.PNG)

<a name="item3"></a>
## Que es kubeconfig?

Kubeconfig es un archivo de configuración fundamental en Kubernetes que especifica cómo la herramienta kubectl se comunica con un clúster de Kubernetes. En términos sencillos, kubeconfig y admin.conf se refieren al mismo archivo. Aunque este archivo puede ubicarse en cualquier lugar, por convención, kubectl lo utiliza comúnmente desde ~/.kube/config. Es posible modificar la ubicación mediante la exportación de una variable en sistemas basados en Linux

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-2.PNG)

<a name="item4"></a>
## Creacion de usuarios en kubernetes?

En Kubernetes, se dice que no se crean usuarios directamente debido a su modelo de autenticación y autorización. En lugar de gestionar usuarios a nivel de Kubernetes, el enfoque principal se centra en la autenticación a través de identidades y tokens

- Autenticación basada en Certificados o Tokens
- Integración con Sistemas Externos
- RBAC (Control de Acceso Basado en Roles)

Estos certificacods y token se encuentran dentro del archivo admin.conf .

<a name="item5"></a>
## Que es RBAC?

RBAC, o Control de Acceso Basado en Roles (Role-Based Access Control), es un sistema de gestión de acceso que se utiliza en Kubernetes para definir y gestionar permisos de acceso a los recursos del clúster. Proporciona un marco para controlar qué usuarios, cuentas de servicio o procesos pueden realizar operaciones específicas en el clúster.

<a name="item6"></a>
## Que es Role y  Rolebind?

Estos son manifiestos que se crean en cluster de kubernetes para administrar acceso a los mismo , cuando se habla de role significa darle permiso sobre un namespace 

Roles (Roles): Los roles son un conjunto de reglas que definen permisos específicos en un espacio de nombres determinado. Pueden especificar acciones como crear, leer, actualizar o eliminar (CRUD) sobre diferentes tipos de recursos, como pods, servicios o despliegues.

RoleBindings (Asociaciones de Roles): Las asociaciones de roles vinculan roles a usuarios, cuentas de servicio o grupos. Un RoleBinding asocia un role a una identidad específica, especificando qué permisos tiene esa identidad en el espacio de nombres correspondiente.

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-5.PNG)

<a name="item7"></a>
## Que es ClusterRole ClusterRoleBind?

ClusterRoles y ClusterRoleBindings: Además de los Roles y RoleBindings a nivel de espacio de nombres, Kubernetes también permite definir roles y asociaciones de roles a nivel de clúster. Los ClusterRoles son roles aplicables a nivel de clúster, y los ClusterRoleBindings vinculan estos roles a identidades a nivel de clúster.

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-6.PNG)

<a name="item8"></a>
## Service account 

Un Service Account en Kubernetes se utiliza para proporcionar una identidad a los Pods y, al hacerlo, les concede permisos para interactuar con el clúster de Kubernetes. Los Service Accounts pueden tener asociados Roles o ClusterRoles que especifican los permisos que tienen en términos de acciones permitidas sobre recursos en el clúster.

Entonces, un Pod que utiliza un Service Account en particular hereda los permisos asociados con ese Service Account. Esto incluye la capacidad de crear, modificar y eliminar recursos en el clúster, dependiendo de los roles o cluster roles asignados a ese Service Account.

<a name="item9"></a>
## Verificacion y aplicacion

En esta seccion se va realiza la configuracion y verificacion de los diferentes metodos de RBAC role, clusterole y service-account

Nota: Estas configuraciones se van a realizar en un entorno on prime no en una nube . Sin embargo el principio es el mismo .


### Metodo configuracion de administracion 1 default admin.conf

En este caso solo se va pasar el archiv admin.conf a la estacion de trabajo 

**Cluster kubernetes (maquina que contiene cluster)**

- 1 buscar el archivo admin.conf `find / -name admin.conf`
  
  ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-9.PNG)
  
- 2 enviar el archivo a la estacion trabajo `scp admin.conf workstation@X.X.X.X:/Ruta/`

**Workstation (estacion de trabajo)**

- 1 Instalar kubectl en la maquina de trabajo
  
  ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-11.PNG)
  
- 2 Una ves verifcado el archivo admin.conf enviar a la ruta .kube/ con el nombre que quieras pero con terminacion yml ..
  
  ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-12.PNG)
  
- 3 Luego exportar el archivo para que kubectl trabaje `export KUBECONFIG=/home/soadmin/.kube/admin-config.yml`
  
   ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-13.PNG)
  
- 4 Verificar que funciono
  
   ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-14.PNG)

### Metodo a traves de RBAC

En esta practica se va usar la filosofia de RBAC mediante certificados y permisos por role es decir namespace. Se creara un namespace llamado test , donde el usuario soadmin solo podra crear pod en este namespace y no tendra mas permisos en el cluster

**Cluster kubernetes (maquina que contiene cluster)**

- 1 Instalar kubectl en la maquina de trabajo
- 2 Recibir el certificado del solicitante

 ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-15%20-%20copia.PNG)

- 3 Firmar el el certificado  `openssl x509 -req -in soadmin.csr -CA /var/lib/k0s/pki/ca.crt -CAkey /var/lib/k0s/pki/ca.key -CAcreateserial -out soadmin.crt -days 50`
  
  ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-16%20-%20copia.PNG)
  
- 4 Crear el manifiesto role y rolebind
  
  ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-17.PNG)
  
- 5 Aplicar ambos manifiestos
  
  ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-18.PNG)

**Workstation (estacion de trabajo)**

- 1 Instalar kubectl en la cluster o maquina de admin
- 2 Generar certificados mediante la herramienta openssl `openssl genrsa -out soadmin.key 2048`
- 3 Generar certificado publico `openssl req -new -key soadmin.key -out soadmin.csr -subj "/CN=soadmin"`
  
   ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-19.PNG)
  
- 4 Enviar el certificado para la firma al cluster kubernetes al admin
- 5 Recibir 2 archivos la llave firmada y el archivo config (en este caso ya el contexto esta agregado en el archivo config)
- 6 Enviar el archivo config a la ubicacion de .kube 
  
   ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-20.PNG)
  
- 7 Agregar las certificado al archiv `config kubectl config set-credentials soadmin --client-certificate=soadmin.crt --client-key=soadmin.key`

 ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-21.PNG)

- 8 Verificar el funcionamiento
   ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rba-23.PNG)

### Clusterrole y clusterolebind

Clusterole como se meciono anteriormente se hace para dar permisos a todos el cluster , como ya tenemos el archivo config y firmas configuradas solo hace falta borrar el role, rolebinding y aplicar el clusterole,clusterrolebinding en nuesto kubernetes.

- 1 Borrar el role y rolebinding en nuesto kubernetes
  
`kubectl delete -f role-pod.yml`

`kubectl delete -f rolebind-pod.yml`

- 2 Aplicar los nuevos manifiesto de clusterrole y clusterrolebinding

`kubectl apply -f cluster-role.yml`

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/cluster-role.PNG)

`kubectl apply -f cluster-role-bind.yml`

 ![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/cluster-biding.PNG)

Veificamos 

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/cluster-ns.PNG)

### Service account 













