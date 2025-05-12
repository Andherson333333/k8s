# kubectl-ai

## ¿Qué es kubectl-ai?

kubectl-ai es una herramienta de línea de comandos que integra modelos de Inteligencia Artificial con Kubernetes. Permite generar, transformar y optimizar manifiestos de Kubernetes mediante instrucciones en lenguaje natural, simplificando enormemente la administración de clústeres y la creación de recursos.

Esta herramienta actúa como un asistente de Kubernetes impulsado por IA, capaz de:
- Generar manifiestos YAML completos
- Explicar conceptos y solucionar problemas
- Transformar configuraciones existentes
- Proporcionar mejores prácticas de forma automática

## ¿Qué es MCP (Model, Control, Presentation)?

MCP (Model, Control, Presentation) es el patrón de arquitectura utilizado por kubectl-ai. Este patrón divide la aplicación en tres componentes principales:

1. **Model (Modelo)**: Se encarga de la integración con los diferentes proveedores de IA (Google Gemini, OpenAI, etc.) y el procesamiento de datos.
2. **Control**: Gestiona la lógica de negocio, coordina las solicitudes entre el usuario y los modelos de IA, y maneja el contexto de Kubernetes.
3. **Presentation (Presentación)**: Proporciona la interfaz de usuario a través de la línea de comandos, formatea las respuestas, y gestiona la interacción.

El parámetro `--mcp-server` en kubectl-ai inicia la herramienta en modo servidor, permitiendo que actúe como un servicio que puede recibir peticiones, procesarlas a través de la arquitectura MCP, y devolver respuestas.

## Arquitectura

kubectl-ai sigue una arquitectura modular que permite la comunicación entre Kubernetes, los modelos de IA y el usuario:

```
┌───────────────┐     ┌────────────────────┐     ┌────────────────┐
│  Entrada del  │     │  Procesamiento     │     │  Proveedores   │
│   Usuario     │────▶│  y Transformación  │────▶│  de Modelos    │
│   (CLI)       │     │  (kubectl-ai)      │     │  de IA         │
└───────────────┘     └────────────────────┘     └────────────────┘
       ▲                        │                        │
       │                        ▼                        │
       │               ┌────────────────┐                │
       │               │  Kubernetes    │                │
       └───────────────│  API Server    │◀───────────────┘
                       └────────────────┘
```

El flujo de trabajo típico es:
1. El usuario introduce un comando en lenguaje natural.
2. kubectl-ai procesa esta entrada y la envía al modelo de IA seleccionado.
3. El modelo de IA genera una respuesta (manifiesto, comando o explicación).
4. kubectl-ai valida y formatea la respuesta.
5. La salida se presenta al usuario o se aplica directamente al clúster.

## Requisitos

### Requisitos de Sistema
- Kubernetes v1.19 o superior
- Kubectl instalado y configurado
- Go 1.19+ (solo para instalación desde fuente)
- Acceso a internet para comunicación con APIs de IA

### Requisitos de API
Para utilizar kubectl-ai, necesitas al menos una de las siguientes APIs configuradas:
- Google Gemini API (predeterminada)
- OpenAI API
- Anthropic API (Claude)
- Cohere API

### Requisitos de Recursos
- Mínimo: 200MB de RAM y 100MB de espacio en disco
- Recomendado: 512MB de RAM y 200MB de espacio en disco

## Instalación

### Método 1: Usando quick-star (recomendado)

```bash
curl -sSL https://raw.githubusercontent.com/GoogleCloudPlatform/kubectl-ai/main/install.sh | bash
```

### Método 2: Instalación descargando 

```bash
VERSION=$(curl -s https://api.github.com/repos/GoogleCloudPlatform/kubectl-ai/releases/latest | grep "tag_name" | cut -d '"' -f 4) && wget https://github.com/GoogleCloudPlatform/kubectl-ai/releases/download/${VERSION}/kubectl-ai_Linux_x86_64.tar.gz
```

# Compilar e instalar
```
tar -xzvf kubectl-ai_Linux_x86_64.tar.gz
chmod +x kubectl-ai
sudo mv kubectl-ai /usr/local/bin/
```

## Configuración

Después de la instalación, debes configurar kubectl-ai con tus credenciales de API:

### Para Google Gemini (recomendado para comenzar)

Tiene la capicidad para diferentes apijey pero vamos a usar la de google gememinis 

```bash
# Establecer la API key de Google
export GOOGLE_API_KEY=tu_api_key_aquí

# O configurarlo permanentemente
echo "export GOOGLE_API_KEY=tu_api_key_aquí" >> ~/.bashrc
source ~/.bashrc
```

## Verificación

Para verificar que kubectl-ai esté instalado y configurado correctamente, ejecuta estos comandos:

### 1. Verificar la instalación

```bash
kubectl ai --help
```

Deberías ver la ayuda de kubectl-ai con todas las opciones disponibles.

### 2. Probar funcionalidad básica

```bash
kubectl ai --model gemini-2.5-pro-exp-03-25 "crear un deployment con 3 réplicas que use nginx"
```

Si todo está configurado correctamente, deberías recibir un manifiesto YAML para un pod de nginx.

[nginx](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-1.png)
[nginx](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-2.png)
[nginx](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-3.png)
[nginx](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-4.png)

### 3. Verificar la configuración del modelo

Si el namespace se crea correctamente, kubectl-ai está funcionando perfectamente.

## Solución de problemas comunes

### Error de cuota excedida
Si recibes un error como "Error 429, Message: ... doesn't have a free quota tier", intenta:
1. Usar un modelo experimental recomendado: `--model gemini-2.5-pro-exp-03-25`
2. Esperar a que se restablezca tu cuota diaria
3. Configurar una cuenta de pago

### Fallos de comunicación con la API
Si la herramienta no puede conectarse a la API, verifica:
1. Que tu clave API sea correcta
2. Que tengas conexión a internet
3. Que no haya conflictos de proxy o firewall

### Errores en la generación de recursos
Si los recursos generados son incorrectos:
1. Sé más específico en tus peticiones
2. Verifica manualmente los manifiestos antes de aplicarlos
3. Intenta con un modelo más avanzado

## Recursos adicionales

- [Repositorio oficial de kubectl-ai](https://github.com/GoogleCloudPlatform/kubectl-ai)
- [Documentación de Google Gemini API](https://ai.google.dev/docs/gemini_api)
- [Mejores prácticas para prompts de IA](https://cloud.google.com/vertex-ai/docs/generative-ai/learn/prompting)
