# Configuración de MCP-Grafana para VS Code en Windows

Este repositorio contiene instrucciones para configurar e implementar mcp-grafana, un servidor Model Context Protocol (MCP) que permite a asistentes de IA como Claude interactuar con instancias de Grafana desde Windows.

## Índice

- [Requisitos previos](#requisitos-previos)
- [Instalación](#instalación)
- [Configuración para entorno local](#configuración-para-entorno-local-en-windows)
- [Configuración de VS Code](#configuración-de-vs-code-en-windows)
- [Pruebas](#pruebas)
- [Funcionalidades avanzadas](#funcionalidades-avanzadas-de-mcp-grafana)
- [Solución de problemas](#solución-de-problemas-en-windows)

## Requisitos previos

- Sistema operativo Windows 10 o Windows 11
- Una instancia de Grafana en funcionamiento
- Un token de API de Grafana con los permisos necesarios
- VS Code con una extensión compatible con MCP (como Claude AI)

## Instalación

### Descargar el binario precompilado para Windows

1. Descarga la última versión de mcp-grafana para Windows desde la [página de releases](https://github.com/grafana/mcp-grafana/releases)
   - Selecciona el archivo `mcp-grafana_Windows_x86_64.zip` para sistemas Windows de 64 bits (más común)
   - Alternativamente, selecciona `mcp-grafana_Windows_i386.zip` para sistemas de 32 bits

2. Extrae el archivo ZIP en una ubicación de fácil acceso (por ejemplo, `C:\Users\TuUsuario\Desktop\mcp-grafana`)

3. No se requiere una instalación formal; el ejecutable `mcp-grafana.exe` funciona directamente desde la carpeta extraída

## Configuración para entorno local en Windows

### 1. Crear un token de API en Grafana

1. En Grafana, ve a Configuración > Cuentas de servicio
2. Crea una nueva cuenta de servicio con los permisos necesarios
3. Genera un nuevo token para esta cuenta de servicio
4. Copia el token para usarlo en la configuración

### 2. Ejecutar el servidor MCP en Windows

#### Usando CMD:

```batch
cd C:\ruta\a\mcp-grafana
set GRAFANA_URL=http://tu-ip-grafana:puerto
set GRAFANA_API_KEY=tu-token-de-grafana
mcp-grafana.exe -debug -transport=sse -sse-address=localhost:8000
```

#### Usando PowerShell:

```powershell
cd C:\ruta\a\mcp-grafana
$env:GRAFANA_URL = "http://tu-ip-grafana:puerto"
$env:GRAFANA_API_KEY = "tu-token-de-grafana"
.\mcp-grafana.exe -debug -transport=sse -sse-address=localhost:8000
```

Mantén esta ventana de terminal abierta mientras trabajas con VS Code, ya que el servidor MCP necesita estar en ejecución.

## Configuración de VS Code en Windows

### 1. Crear archivo de configuración

Crea o edita el archivo `.vscode/settings.json` en tu proyecto:

```json
{
  "mcp": {
    "servers": {
      "grafana": {
        "type": "sse",
        "url": "http://localhost:8000/sse"
      }
    }
  }
}
```

### 2. Usando la interfaz gráfica en VS Code

Alternativamente, puedes configurar el servidor MCP mediante la interfaz gráfica:

1. Haz clic en el botón "Add MCP Server..." en VS Code (generalmente visible en la barra lateral)
2. Selecciona "HTTP (HTTP or Server-Sent Events)"
3. En "Enter ID", escribe `grafana`
4. En "Enter URL", escribe `http://localhost:8000/sse`
5. Haz clic en OK para guardar la configuración

Si todo está correctamente configurado, verás un indicador "Running" junto al servidor MCP en VS Code.

## Ejemplo de configuración en VS Code

La configuración de MCP-Grafana en VS Code es sencilla. A continuación se muestra cómo debería verse tu archivo settings.json y la interfaz cuando está funcionando correctamente:

```json
{
  "mcp": {
    "servers": {
      "grafana": {
        "type": "sse",
        "url": "http://localhost:8000/sse"
      }
    }
  }
}
```

Cuando el servidor está correctamente configurado, verás un indicador "Running" junto a la entrada de Grafana en la interfaz de VS Code, como se muestra en la siguiente imagen:

![MCP-Grafana Running en VS Code](ruta-a-tu-imagen.png)

## Pruebas

Una vez configurado, puedes probar que el servidor MCP funciona correctamente:

### 1. Verificar que el servidor está ejecutándose

Deberías ver mensajes de log en la terminal donde ejecutaste mcp-grafana, similares a estos:

```
time=2025-05-14T00:00:00.000-04:00 level=INFO msg="Starting Grafana MCP server using SSE transport" address=localhost:8000
time=2025-05-14T00:00:00.000-04:00 level=INFO msg="Grafana transport debug mode enabled"
```

Cuando se realicen consultas, verás registros adicionales que muestran las solicitudes a la API de Grafana.

### 2. Comprobar la funcionalidad en VS Code

Prueba estas consultas con la extensión Claude AI en VS Code:

- "Muéstrame los dashboards disponibles en mi instancia de Grafana"
- "Lista mis fuentes de datos en Grafana"
- "Consulta la métrica de uso de CPU del último día"

### 3. Crear y actualizar dashboards

MCP-Grafana te permite crear y actualizar dashboards a través de su herramienta `update_dashboard`. Para probar esta funcionalidad, puedes pedirle a Claude AI en VS Code:

- "Crea un nuevo dashboard en Grafana que muestre el uso de CPU y memoria"
- "Actualiza el dashboard X para añadir un panel con el uso de disco"
- "Crea un dashboard para monitorizar el rendimiento de mi aplicación"

**Nota importante**: Al crear dashboards, ten en cuenta que la herramienta tiene algunas limitaciones con respecto al tamaño del contexto. Para dashboards complejos o muy grandes, es posible que debas dividir la creación en múltiples pasos.

## Funcionalidades avanzadas de MCP-Grafana

MCP-Grafana ofrece un amplio conjunto de funcionalidades que van más allá de las operaciones básicas. A continuación se detallan algunas de las capacidades más avanzadas:

### Integración con Kubernetes

MCP-Grafana permite interactuar con dashboards y métricas de Kubernetes, permitiéndote:

- **Visualizar recursos de Kubernetes**: Explorar clusters, namespaces, pods, workloads, etc.
- **Monitorizar el rendimiento del cluster**: Métricas de CPU, memoria, red y almacenamiento
- **Analizar logs de Kubernetes**: Buscar problemas en logs de pods y contenedores
- **Crear dashboards específicos para Kubernetes**: Visualizaciones para diferentes componentes:
  - Compute Resources (Cluster, Namespace, Pods, Node)
  - Networking
  - Persistent Volumes
  - Controllers y Scheduler

### Análisis avanzado con Prometheus y Loki

- **Construcción de queries complejas**: Claude puede ayudarte a construir consultas PromQL o LogQL complejas
- **Correlación de métricas y logs**: Encontrar relaciones entre eventos en logs y cambios en métricas
- **Detección de anomalías**: Identificar patrones inusuales en métricas
- **Alertas personalizadas**: Crear reglas de alertas basadas en condiciones específicas

### Automatización y administración

- **Gestión programática de dashboards**: Crear, actualizar y organizar dashboards mediante código
- **Versionado de dashboards**: Mantener un histórico de cambios en dashboards
- **Compartir configuraciones**: Exportar e importar dashboards entre instancias de Grafana
- **Administración de usuarios y roles**: Gestionar permisos y accesos

### Personalización de visualizaciones

- **Creación de paneles personalizados**: Diseñar visualizaciones adaptadas a necesidades específicas
- **Personalización de temas y estilos**: Modificar la apariencia de los dashboards
- **Configuración de variables de plantilla**: Crear dashboards dinámicos que se adaptan a diferentes selecciones
- **Anotaciones y eventos**: Marcar eventos importantes en los gráficos

### Integración con GitOps

- **Almacenamiento de dashboards en Git**: Mantener configuraciones en control de versiones
- **Flujos de trabajo CI/CD**: Automatizar la implementación de dashboards
- **Revisión de cambios**: Comparar modificaciones antes de aplicarlas
- **Recuperación ante desastres**: Restaurar configuraciones desde repositorios Git

## Referencias

- [Repositorio oficial de mcp-grafana](https://github.com/grafana/mcp-grafana)
- [Documentación de Grafana sobre cuentas de servicio](https://grafana.com/docs/grafana/latest/administration/service-accounts/)
- [Protocolo MCP (Model Context Protocol)](https://modelcontextprotocol.io/)
