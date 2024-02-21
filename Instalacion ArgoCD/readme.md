## Índice de contenidos
* [¿Que es gitops?](#item1)
* [ ¿Que es argocd ??](#item2)
* [Hay 3 formas de instalar argocd](#item3)
* [Arquictectura de argocd](#item4)
* [Configuracion para iniciar ](#item5)
* [Verificacion](#item6)
  
<a name="item1"></a>
## ¿Que es gitops ?

GitOps es un enfoque para el despliegue de infraestructuras y aplicaciones que aprovecha Git, un popular sistema de control de versiones distribuido. En GitOps, la infraestructura se define como código y se almacena en un repositorio Git. Los cambios en el código activan unas acciones automatizadas que despliegan esos cambios en el entorno de destino, lo que facilita el mantenimiento y la coherencia en los entornos de desarrollo, pruebas y producción.  

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/Instalacion%20ArgoCD/imagenes/argocd-sync-flow.png)

 <a name="item2"></a>
## ¿Que es argocd ?
ArgoCD es una herramienta que nos permite adoptar metodologías GitOps para el despliegue continuo de aplicaciones en clústers de kubernetes.
La principal característica es que ArgoCD sincroniza el estado de las aplicaciones desplegadas con sus respectivos manifiestos declarados en git.
Permitiendo así a los desarrolladores realizar cambios en la aplicación con solo modificar el contenido de git, ya sea con commits a ramas de desarrollo o modificando. Una vez modificado el código en git, ArgoCD detecta, mediante webhook o comprobación periódica cada 3 minutos, que ha habido cambios en los manifiestos de las aplicaciones. Seguidamente, compara los manifiestos declarados en git con los que hay aplicados en los clústers y actualiza estos últimos hasta sincronizarlos.

<a name="item3"></a>
## Hay 3 formas de instalar argocd

 - 1 manifiestos
```
      kubectl create namespace argocd
      kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
 - 2 helm
```
    helm repo add argo https://argoproj.github.io/argo-helm
    helm install my-argocd-apps argo/argocd-apps --version 1.6.1
```
  - 3 operator

<a name="item4"></a>
## Arquictectura de argocd

 Al crear un argocd tiene 7 micro servicios , que es igual a 7 pod cada uno de ellos asociados a un servicio

`argocd-application-controller-0:`
Rol: Controla y gestiona las aplicaciones dentro de ArgoCD.
Función: Supervisa y maneja la implementación, actualización y eliminación de aplicaciones en el clúster de Kubernetes.
  
`argocd-applicationset-controller-64c77cff5d-tkcs2:`
Rol: Controla conjuntos de aplicaciones en ArgoCD.
Función: Permite gestionar conjuntos de aplicaciones, facilitando la implementación y gestión de aplicaciones a escala.

`argocd-dex-server:`
Rol: Servidor Dex para autenticación y autorización.
Función: Proporciona servicios de autenticación y autorización para usuarios y servicios en ArgoCD.
  
`argocd-notifications-controller:`
Rol: Controlador de notificaciones para eventos relacionados con aplicaciones.
Función: Gestiona notificaciones para eventos específicos de aplicaciones, permitiendo a los usuarios recibir alertas sobre cambios importantes.
  
`argocd-redis:`
Rol: Ejecuta el servidor Redis para almacenamiento temporal.
Función: Almacena datos temporales y proporciona un almacenamiento efímero para ciertos procesos en ArgoCD.
  
`argocd-repo-server:`
Rol: Servidor de repositorios para gestionar definiciones de aplicaciones.
Función: Gestiona el almacenamiento y recuperación de las definiciones de aplicaciones almacenadas en el repositorio Git.
  
`argocd-server:`
Rol: Servidor principal de ArgoCD.
Función: Coordina las operaciones en el clúster de Kubernetes y proporciona la interfaz de usuario web para gestionar y desplegar aplicaciones.
Instalacion argocd

![Diagrama]()

<a name="item5"></a>
## Configuracion para iniciar 

- Pasar el service para poder logiar de forma web UI
```
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
```
- Conseguir clave del usuario admin
 ```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

<a name="item6"></a>
## Verificacion 

En este apartado verificaremos la instalacion si funciona , asi que vamos a realizar una serie de comandos 

```
kubectl get svc -n argocd
kubectl get pod -n argocd
```

![Diagrama]()


