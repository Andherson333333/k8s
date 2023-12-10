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

3. **Contenedores:**
   - Las aplicaciones se empaquetan en contenedores, que son unidades portátiles y livianas que contienen todo lo necesario para ejecutar una aplicación.

4. **Objetos y Declaración de Estado:**
   - Kubernetes trabaja con objetos, que son descripciones de lo que deseas que suceda en el clúster.
   - Los objetos pueden definirse en archivos YAML y especifican el estado deseado del sistema, como despliegues, servicios, volúmenes, etc.

5. **Controladores:**
   - Los controladores son procesos en el nodo Master que observan el estado del clúster y trabajan para que el estado coincida con el deseado.

6. **Programa de Resolución:**
   - Kubernetes ofrece servicios a través de una IP única. El servicio kube-proxy en cada nodo asegura que estos servicios estén disponibles y balancea la carga.

7. **Orquestación:**
   - Kubernetes orquesta la ejecución de aplicaciones a través de la programación y distribución de contenedores en los nodos disponibles.

8. **Escalabilidad y Autoescalado:**
   - Kubernetes puede aumentar o disminuir automáticamente el número de réplicas de una aplicación según la demanda de carga de trabajo.

9. **Autoreparación:**
   - Si un contenedor o nodo falla, Kubernetes puede autorepararse, reiniciando contenedores o reprogramando tareas.

10. **Configuración y Secretos:**
    - Kubernetes gestiona la configuración de las aplicaciones y secretos de manera centralizada, lo que facilita la gestión de información sensible.

En resumen, Kubernetes proporciona una plataforma para automatizar, gestionar y escalar aplicaciones en contenedores. Su arquitectura distribuida y sus diversos componentes trabajan en conjunto para garantizar la eficiencia y la confiabilidad en la gestión de aplicaciones en entornos de producción.

![Diagrama](https://github.com/Andherson333333/k8s/blob/main/arquictectura/imagenes/kubernetes-2.JPG)
