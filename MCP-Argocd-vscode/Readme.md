# ArgoCD MCP Integration for VS Code

Este repositorio contiene la configuración necesaria para integrar ArgoCD con el Model Context Protocol (MCP) en Visual Studio Code en Windows, permitiendo interactuar con tu cluster de Kubernetes y ArgoCD usando lenguaje natural a través de asistentes de IA.

## Índice
- [Requisitos previos](#requisitos-previos)
- [Instalación](#instalación)
- [Configuración Mcp-user](#configuración-mcp-user)
- [Configuración de VS Code](#configuración-de-vs-code)
- [Verificación y Pruebas](#verificación-y-pruebas)
- [Funcionalidades avanzadas](#funcionalidades-avanzadas)
- [Solución de problemas](#solución-de-problemas)
- [Recursos adicionales](#recursos-adicionales)

## Requisitos previos

* Kubernetes cluster funcionando
* ArgoCD instalado en el cluster
* Node.js y NPM instalados en tu máquina local
* Visual Studio Code con una extensión compatible con MCP (GitHub Copilot, Claude, etc.)

## Instalación

### 1. Instalar ArgoCD en Kubernetes

Si aún no tienes ArgoCD instalado, puedes hacerlo con Helm:

```bash
# Agregar el repositorio de Helm para ArgoCD
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Instalar ArgoCD con valores personalizados
helm install argocd argo/argo-cd -n argocd --create-namespace -f argocd-values.yaml
```

Contenido del archivo `values.yaml`:

```yaml
# ArgoCD Helm Chart Values
server:
  service:
    type: NodePort
    nodePortHttp: 30109
    nodePortHttps: 30168

  # Allow HTTP connections
  extraArgs:
    - --insecure
# User and permissions configuration
configs:
  cm:
    # MCP user with minimal capabilities
    accounts.mcp-user: apiKey,login
  rbac:
    policy.csv: |
      # Application Management permissions
      p, role:mcp, applications, get, */*, allow
      p, role:mcp, applications, create, */*, allow
      p, role:mcp, applications, update, */*, allow
      p, role:mcp, applications, delete, */*, allow
      p, role:mcp, applications, sync, */*, allow

      # Resource Management permissions
      p, role:mcp, applications/tree, get, */*, allow
      p, role:mcp, applications/resources, get, */*, allow
      p, role:mcp, logs, get, */*, allow
      p, role:mcp, events, get, */*, allow
      p, role:mcp, applications/resource/actions, get, */*, allow
      p, role:mcp, applications/resource/actions, create, */*, allow

      # Required supporting permissions
      p, role:mcp, clusters, get, *, allow
      p, role:mcp, repositories, get, *, allow
      p, role:mcp, projects, get, *, allow

      # Assign mcp-user to mcp role
      g, mcp-user, role:mcp
      g, admin, role:admin

    # Default policy for users not assigned to any role
    policy.default: role:readonly
```

### 2. Obtener las credenciales iniciales de ArgoCD

```bash
# Obtener la contraseña inicial para el usuario admin
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Configuración Mcp-user

### 1. Configurar usuarios y permisos para mcp-user

El archivo `argocd-values.yaml` ya incluye la configuración de usuarios y permisos necesaria. Si necesitas realizar cambios adicionales, puedes editar este archivo y actualizar la instalación de ArgoCD:

```bash
helm upgrade argocd argo/argo-cd -n argocd -f argocd-values.yaml
```

### 2. Establecer contraseña para el usuario MCP

```bash
# Iniciar sesión con admin
argocd login <ARGOCD_SERVER>:<PORT> --username admin --password <ADMIN_PASSWORD> --plaintext

# Establecer contraseña para mcp-user
argocd account update-password \
  --account mcp-user \
  --current-password <ADMIN_PASSWORD> \
  --new-password <MCP_USER_PASSWORD>
```

### 3. Generar un token API para MCP

```bash
# Iniciar sesión con mcp-user
argocd login <ARGOCD_SERVER>:<PORT> --username mcp-user --password <MCP_USER_PASSWORD> --plaintext

# Generar token sin expiración
argocd account generate-token --expires-in 0s
```

## Configuración de VS Code

### 1. Crear archivo de configuración MCP

Crea un archivo `.vscode/mcp.json` en la raíz de tu proyecto o actualiza la configuración global de VS Code:

```json
{
  "mcpServers": {
    "argocd-mcp": {
      "command": "cmd.exe",
      "args": [
        "/c",
        "npx",
        "argocd-mcp@latest",
        "stdio"
      ],
      "env": {
        "ARGOCD_BASE_URL": "<argocd_url>",
        "ARGOCD_API_TOKEN": "<argocd_token>"
      }
    }
  }
}
```

### 2. Reiniciar VS Code

Reinicia Visual Studio Code para que cargue la nueva configuración.

## Verificación y Pruebas

### 1. Verificar la configuración

Puedes verificar que la configuración se haya aplicado correctamente usando estos comandos:

```bash
# Verificar configuración de usuarios en argocd-cm
kubectl get configmap argocd-cm -n argocd -o yaml | grep mcp-user

# Verificar configuración RBAC
kubectl get configmap argocd-rbac-cm -n argocd -o yaml

# Verificar permisos específicos con la herramienta RBAC de ArgoCD
echo 'g, mcp-user, role:mcp' > /tmp/rbac-test.csv
argocd admin settings rbac can --policy-file /tmp/rbac-test.csv mcp-user get applications
```

### 2. Probar la integración

Abre VS Code y chatear con el asistente de IA compatible con MCP. Puedes probar con las siguientes consultas:

1. **Listar aplicaciones**:
   "Muéstrame todas las aplicaciones en mi ArgoCD"

2. **Crear una aplicación**:
   "Crea una aplicación llamada test-app usando el repositorio https://github.com/argoproj/argocd-example-apps.git"

3. **Sincronizar una aplicación**:
   "Sincroniza la aplicación test-app"

4. **Ver detalles de una aplicación**:
   "Dame información detallada sobre la aplicación test-app"

## Capturas de pantalla de la integración

### Creación de aplicaciones desde VS Code

![Creación de aplicación desde VS Code](./images/create-app-vscode.png)

### Aplicaciones en ArgoCD

![Aplicaciones en ArgoCD](./images/applications-argocd.png)

### Integración con VS Code

![Integración con VS Code](./images/integration-vscode.png)

## Funcionalidades avanzadas

El servidor MCP para ArgoCD proporciona las siguientes funcionalidades:

### Application Management
* `list_applications`: Listar y filtrar aplicaciones
* `get_application`: Obtener información detallada de una aplicación
* `create_application`: Crear una nueva aplicación
* `update_application`: Actualizar una aplicación existente
* `delete_application`: Eliminar una aplicación
* `sync_application`: Sincronizar una aplicación

### Resource Management
* `get_application_resource_tree`: Obtener el árbol de recursos de una aplicación
* `get_application_managed_resources`: Obtener recursos administrados de una aplicación
* `get_application_workload_logs`: Obtener logs de workloads (Pods, Deployments, etc.)
* `get_resource_events`: Obtener eventos de recursos gestionados por una aplicación
* `get_resource_actions`: Obtener acciones disponibles para recursos
* `run_resource_action`: Ejecutar una acción en un recurso

## Solución de problemas

### 1. Problemas de permisos

Si encuentras errores de permisos:

- Verifica que el usuario `mcp-user` esté configurado correctamente en `argocd-cm`
- Asegúrate de que las políticas RBAC estén correctamente definidas en `argocd-rbac-cm`
- Genera un nuevo token API si es necesario


## Recursos adicionales

* [Documentación oficial de ArgoCD](https://argo-cd.readthedocs.io/)
* [Repositorio de argocd-mcp](https://github.com/akuity/argocd-mcp)
* [Modelo Context Protocol](https://modelcontextprotocol.io)
