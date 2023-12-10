# docker vs kubernetes

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


# ¿Que es kubernetes?

Kubernetes es una plataforma de código abierto diseñada para la automatización, implementación, escalabilidad y operación de aplicaciones en contenedores. Desarrollada por Google, Kubernetes facilita la gestión de contenedores en entornos de producción, permitiendo a los usuarios orquestar y coordinar la ejecución de aplicaciones en clústeres de máquinas.

# Arquitectura

![Diagrama]()
