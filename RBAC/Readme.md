## Que es kubectl?

Es una herramienta de linea de comandos que se encarga de interactuar con el cluster de kubernetes, cabe destacar que es una herramienta que se instala en el lado del cliente 

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-3.PNG)

## Que es admin.conf?

El archivo admin.conf es un archivo de configuración de Kubernetes que contiene información sobre cómo conectarse al clúster de Kubernetes y las credenciales necesarias para realizar operaciones administrativas. Este archivo puede varia en  diferentes ubicaciones dependiendo el tipo de instalacion distro ect . Para encontralo puede usar este comando `find / -name admin.conf` en linux

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-4.PNG)

## Que es kubeconfig?

Kubeconfig es un archivo de configuración fundamental en Kubernetes que especifica cómo la herramienta kubectl se comunica con un clúster de Kubernetes. En términos sencillos, kubeconfig y admin.conf se refieren al mismo archivo. Aunque este archivo puede ubicarse en cualquier lugar, por convención, kubectl lo utiliza comúnmente desde ~/.kube/config. Es posible modificar la ubicación mediante la exportación de una variable en sistemas basados en Linux

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-2.PNG)

## Creacion de usuarios en kubernetes?

En Kubernetes, se dice que no se crean usuarios directamente debido a su modelo de autenticación y autorización. En lugar de gestionar usuarios a nivel de Kubernetes, el enfoque principal se centra en la autenticación a través de identidades y tokens

- Autenticación basada en Certificados o Tokens
- Integración con Sistemas Externos
- RBAC (Control de Acceso Basado en Roles)

Estos certificacods y token se encuentran dentro del archivo admin.conf .

## Que es RBAC?

RBAC, o Control de Acceso Basado en Roles (Role-Based Access Control), es un sistema de gestión de acceso que se utiliza en Kubernetes para definir y gestionar permisos de acceso a los recursos del clúster. Proporciona un marco para controlar qué usuarios, cuentas de servicio o procesos pueden realizar operaciones específicas en el clúster.

## Que es Role y  Rolebind?

Estos son manifiestos que se crean en cluster de kubernetes para administrar acceso a los mismo , cuando se habla de role significa darle permiso sobre un namespace 

Roles (Roles): Los roles son un conjunto de reglas que definen permisos específicos en un espacio de nombres determinado. Pueden especificar acciones como crear, leer, actualizar o eliminar (CRUD) sobre diferentes tipos de recursos, como pods, servicios o despliegues.

RoleBindings (Asociaciones de Roles): Las asociaciones de roles vinculan roles a usuarios, cuentas de servicio o grupos. Un RoleBinding asocia un role a una identidad específica, especificando qué permisos tiene esa identidad en el espacio de nombres correspondiente.

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-5.PNG)

## Que es ClusterRole ClusterRoleBind?

ClusterRoles y ClusterRoleBindings: Además de los Roles y RoleBindings a nivel de espacio de nombres, Kubernetes también permite definir roles y asociaciones de roles a nivel de clúster. Los ClusterRoles son roles aplicables a nivel de clúster, y los ClusterRoleBindings vinculan estos roles a identidades a nivel de clúster.

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/RBAC/imagenes/rbac-6.PNG)

## Comandos de verificacion

## Verificacion y practicas

En esta seccion se va realiza la configuracion y verificacion de los roles y clusterRole , se van a realizar 2 configuraciones una con rol por defecto administrativo y otra con RBAC .

Nota: Estas configuraciones se van a realizar en un entorno on prime no en una nube . Sin embargo el principio es el mismo .

### Rol administrativo o por defecto

#### Practica 1 default admin.conf

En este caso solo se va pasar el archiv admin.conf a la estacion de trabajo 

** Cluster kubernetes (maquina que contiene cluster)

- 1 buscar el archivo admin.conf `find / -name admin.conf`
- 2 enviar el archivo a la estacion trabajo `scp admin.conf workstation@X.X.X.X:/Ruta/`

** Workstation (estacion de trabajo)

- 1 Instalar kubectl en la maquina de trabajo
- 2 Una ves verifcado el archivo admin.conf enviar a la ruta .kube/ con el nombre que quieras pero con terminacion yml ..
- 3 Luego exportar el archivo para que kubectl trabaje `export KUBECONFIG=/home/soadmin/.kube/admin-config.yml`
- 4 Verificar que funciono

### Practica 2 RBAC

En esta practica se va usar la filosofia de RBAC mediante certificados y permisos por role es decir namespace

** Cluster kubernetes (maquina que contiene cluster)


- 1 Instalar kubectl en la maquina de trabajo
- 2 Recibir el certificado del solicitante 
- 3 Firmar el el certificado  `openssl x509 -req -in soadmin.csr -CA /var/lib/k0s/pki/ca.crt -CAkey /var/lib/k0s/pki/ca.key -CAcreateserial -out soadmin.crt -days 50`
- 4 Crear el manifiesto role y aplicarlo 
- 5 Crear el manifiesto rolebind y asociarlo

** Workstation (estacion de trabajo)

- 1 Instalar kubectl en la cluster o maquina de admin
- 2 Generar certificados mediante la herramienta openssl `openssl genrsa -out soadmin.key 2048`
- 3 Generar certificado publico `openssl req -new -key soadmin.key -out soadmin.csr -subj "/CN=soadmin"`
- 4 Enviar el certificado para la firma al cluster kubernetes al admin
- 5 Recibir 2 archivos la llave firmada y el archivo config (en este caso ya el contexto esta agregado en el archivo config)
- 6 Agregar las certificado al archiv `config kubectl config set-credentials soadmin --client-certificate=soadmin.crt --client-key=soadmin.key`
- 7 Verificar el funcionamiento














