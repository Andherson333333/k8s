## Que es kubectl?

Es una herramienta de linea de comandos que se encarga de interactuar con el cluster de kubernetes, cabe destacar que es una herramienta que se instala en el lado del cliente 

## Que es admin.conf?

El archivo admin.conf es un archivo de configuración de Kubernetes que contiene información sobre cómo conectarse al clúster de Kubernetes y las credenciales necesarias para realizar operaciones administrativas. Este archivo puede varia en  diferentes ubicaciones dependiendo el tipo de instalacion distro ect . Para encontralo puede usar este comando `find / -name admin.conf` en linux

## Que es kubeconfig?

Kubeconfig es un archivo de configuración fundamental en Kubernetes que especifica cómo la herramienta kubectl se comunica con un clúster de Kubernetes. En términos sencillos, kubeconfig y admin.conf se refieren al mismo archivo. Aunque este archivo puede ubicarse en cualquier lugar, por convención, kubectl lo utiliza comúnmente desde ~/.kube/config. Es posible modificar la ubicación mediante la exportación de una variable en sistemas basados en Linux

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


## Que es ClusterRole ClusterRoleBind?

