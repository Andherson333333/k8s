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


## Que es RBAC?

## Que es Role y  Rolebind?

## Que es ClusterRole ClusterRoleBind?

