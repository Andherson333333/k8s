## Índice de contenidos 
* [docker vs kubernetes](#item1)
* [¿Que es kubernetes](#item2)
* [Arquitectura](#item3)

<a name="item1"></a>
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

<a name="item2"></a>
## ¿Que es kubernetes?

Kubernetes es una plataforma de código abierto diseñada para la automatización, implementación, escalabilidad y operación de aplicaciones en contenedores. Desarrollada por Google, Kubernetes facilita la gestión de contenedores en entornos de producción, permitiendo a los usuarios orquestar y coordinar la ejecución de aplicaciones en clústeres de máquinas.

<a name="item3"></a>
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

### Plano de Control (Control Plane):

1. **kube-apiserver:**
   - **Descripción:** Es la API de Kubernetes que actúa como interfaz para la comunicación entre los componentes del plano de control y los usuarios o aplicaciones. Recibe comandos del cliente y los procesa para realizar acciones en el clúster.

2. **etcd:**
   - **Descripción:** Es un almacén de datos distribuido que mantiene la configuración del clúster, el estado actual y otras metadatos. Almacena información de configuración que representa el estado deseado del clúster.

3. **kube-controller-manager:**
   - **Descripción:** Es responsable de supervisar continuamente el estado del clúster mediante el kube-apiserver. Controladores específicos (como el controlador de nodos, de réplicas, de servicios, etc.) son ejecutados por el kube-controller-manager para garantizar que el estado actual coincida con el estado deseado.

4. **kube-scheduler:**
   - **Descripción:** Asigna automáticamente los pods a nodos del clúster en función de ciertos criterios, como la capacidad de recursos, restricciones de afinidad, y otras políticas. Ayuda a garantizar una distribución equitativa de carga y recursos.

### Plano de Datos (Data Plane):

1. **Kubelet:**
   - **Descripción:** Es un agente que se ejecuta en cada nodo del clúster y se comunica con el kube-apiserver. Se encarga de garantizar que los contenedores definidos en los pods estén ejecutándose y saludables en el nodo.

2. **kube-proxy:**
   - **Descripción:** Mantiene las reglas de red en los nodos. Facilita la comunicación de red entre los pods y el mundo exterior. Implementa el reenvío de red y el balanceo de carga, asegurando la conectividad y el equilibrio de carga.

3. **Container Runtime:**
   - **Descripción:** Es el software responsable de ejecutar los contenedores. Kubernetes es compatible con varias runtimes, como Docker, containerd, y otros. Se encarga de descargar las imágenes de contenedores, iniciar y detener contenedores, y gestionar los recursos del sistema.

En conjunto, el plano de control y el plano de datos trabajan para proporcionar una plataforma robusta y flexible para la orquestación y gestión de contenedores en un entorno de producción. La comunicación entre los componentes se realiza a través de la API de Kubernetes y el almacenamiento centralizado de datos en etcd garantiza la coherencia y consistencia del estado del clúster.
