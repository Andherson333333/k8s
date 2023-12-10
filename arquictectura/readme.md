## docker vs kubernetes

| Característica            | Docker              | Kubernetes                |
|---------------------------|---------------------|---------------------------|
| Definición                | Contenerización     | Orquestación de Contenedores|
| Uso Típico                | Desarrollo local    | Implementación en producción|
| Escalabilidad             | Limitada (Compose)  | Horizontal y automática    |
| Autoescalado              | No nativo           | Sí, basado en la carga     |
| Autohealing               | No nativo           | Sí, autoreparación        |
| Orquestación              | Docker Swarm        | Completa con Kubernetes   |
| Configuración Declarativa | Dockerfile, Compose | Archivos YAML             |
| Gestión de Recursos       | Básica (Compose)     | Completa con Kubernetes   |
| Gestión de Red            | Básica               | Avanzada con servicios    |
| Despliegue/Actualización  | Docker Compose, Swarm| Kubernetes Deployments    |
| Almacenamiento Persistente| Admite volúmenes     | Soluciones avanzadas      |
| Ecosistema y Comunidad     | Docker Hub           | Amplio en Kubernetes       |
| Seguridad                 | Aislamiento          | RBAC en Kubernetes        |
| Adopción en la Industria  | Desarrollo y prueba  | Estándar en producción    |
| Tiempo de Vida            | Desde 2013           | Desde 2014                |


## ¿Que es kubernetes?

Kubernetes es una plataforma de código abierto diseñada para la automatización, implementación, escalabilidad y operación de aplicaciones en contenedores. Desarrollada por Google, Kubernetes facilita la gestión de contenedores en entornos de producción, permitiendo a los usuarios orquestar y coordinar la ejecución de aplicaciones en clústeres de máquinas.

## Arquitectura

Kubernetes trabaja de manera eficiente utilizando una arquitectura distribuida y modular. Aquí hay una descripción simplificada de cómo Kubernetes trabaja:

1. **Cluster:**
   - Un clúster de Kubernetes está compuesto por nodos. Un nodo puede ser una máquina física o una máquina virtual.

2. **Nodos:**
   - Hay dos tipos de nodos en Kubernetes: Master y Worker.
      - **Master:**
         - Controla el clúster y toma decisiones sobre qué hacer y dónde hacerlo.
         - Compuesto por varios componentes, incluyendo kube-api-server, kube-controller-manager, kube-scheduler y etcd.
      - **Worker:**
         - Ejecuta aplicaciones (contenedores) y gestiona los recursos locales.
         - Compuesto por el Container Runtime, Kubelet y Kube-proxy.

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/arquictectura/imagenes/kubernetes-2.JPG)
