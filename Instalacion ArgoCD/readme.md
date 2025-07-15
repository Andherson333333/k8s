# ArgoCD: Implementación de GitOps en Kubernetes 

## Descripción

Este repositorio contiene información y guías sobre ArgoCD, una herramienta poderosa para implementar GitOps en clústeres de Kubernetes. ArgoCD facilita la gestión y despliegue continuo de aplicaciones, permitiendo sincronizar automáticamente el estado de las aplicaciones en Kubernetes con las definiciones almacenadas en repositorios Git. Esta guía cubre los conceptos básicos de GitOps, la instalación y configuración de ArgoCD, y proporciona una visión general de su arquitectura y funcionamiento.

## Índice de contenidos
1. [¿Qué es GitOps?](#qué-es-gitops)
2. [¿Qué es ArgoCD?](#qué-es-argocd)
3. [Formas de instalar ArgoCD](#formas-de-instalar-argocd)
4. [Arquitectura de ArgoCD](#arquitectura-de-argocd)
5. [Configuración inicial](#configuración-inicial)
6. [Verificación de la instalación](#verificación-de-la-instalación)

## ¿Qué es GitOps?

GitOps es un enfoque para el despliegue de infraestructuras y aplicaciones que aprovecha Git como sistema de control de versiones distribuido. En GitOps, la infraestructura se define como código y se almacena en un repositorio Git. Los cambios en el código activan acciones automatizadas que despliegan esos cambios en el entorno de destino, facilitando el mantenimiento y la coherencia en los entornos de desarrollo, pruebas y producción.

![Diagrama GitOps](https://github.com/Andherson333333/k8s/blob/main/Instalacion%20ArgoCD/imagenes/argocd-sync-flow.png)

## ¿Qué es ArgoCD?

ArgoCD es una herramienta que permite adoptar metodologías GitOps para el despliegue continuo de aplicaciones en clústers de Kubernetes. Su principal característica es la sincronización del estado de las aplicaciones desplegadas con sus respectivos manifiestos declarados en Git. Esto permite a los desarrolladores realizar cambios en la aplicación modificando solo el contenido en Git, ya sea con commits a ramas de desarrollo o modificaciones directas.

## Formas de instalar ArgoCD

Existen tres formas principales de instalar ArgoCD:

1. Usando manifiestos:
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

2. Usando Helm:
   ```bash
   helm repo add argo https://argoproj.github.io/argo-helm
   helm install my-argocd-apps argo/argocd-apps --version 1.6.1
   ```

3. Usando el operador (no se proporciona comando específico en el documento original)

## Arquitectura de ArgoCD

ArgoCD se compone de 7 microservicios principales, cada uno asociado a un pod y un servicio:

1. argocd-application-controller: Controla y gestiona las aplicaciones dentro de ArgoCD.
2. argocd-applicationset-controller: Controla conjuntos de aplicaciones en ArgoCD.
3. argocd-dex-server: Servidor Dex para autenticación y autorización.
4. argocd-notifications-controller: Controlador de notificaciones para eventos relacionados con aplicaciones.
5. argocd-redis: Ejecuta el servidor Redis para almacenamiento temporal.
6. argocd-repo-server: Servidor de repositorios para gestionar definiciones de aplicaciones.
7. argocd-server: Servidor principal de ArgoCD.

![Arquitectura de ArgoCD](https://github.com/Andherson333333/k8s/blob/main/Instalacion%20ArgoCD/imagenes/argocd-archictectura.PNG)

## Configuración inicial

Para iniciar ArgoCD:

1. Habilitar acceso web UI:
   ```bash
   kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
   ```

2. Obtener la contraseña inicial del usuario admin:
   ```bash
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
   ```

## Verificación de la instalación

Para verificar la instalación, ejecute los siguientes comandos:

```bash
kubectl get svc -n argocd
kubectl get pod -n argocd
```

![Verificación de ArgoCD](https://github.com/Andherson333333/k8s/blob/main/Instalacion%20ArgoCD/imagenes/argocd-4.PNG)

---

Para más información, consulte la [documentación oficial de ArgoCD](https://argo-cd.readthedocs.io/en/stable/).


