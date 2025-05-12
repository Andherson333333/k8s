# kubectl-ai

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/GoogleCloudPlatform/kubectl-ai.svg?style=social&label=Star&maxAge=2592000)](https://github.com/GoogleCloudPlatform/kubectl-ai/stargazers/)

## What is kubectl-ai?

kubectl-ai is a command-line tool that integrates Artificial Intelligence models with Kubernetes. It allows you to generate, transform, and optimize Kubernetes manifests using natural language instructions, greatly simplifying cluster management and resource creation.

This tool acts as an AI-powered Kubernetes assistant, capable of:
- 🚀 Generating complete YAML manifests
- 🔍 Explaining concepts and troubleshooting problems
- 🔄 Transforming existing configurations
- ✅ Automatically providing best practices

## What is MCP (Model, Control, Presentation)?

MCP (Model, Control, Presentation) is the architectural pattern used by kubectl-ai. This pattern divides the application into three main components:

1. **Model**: Handles the integration with different AI providers (Google Gemini, OpenAI, etc.) and data processing.
2. **Control**: Manages business logic, coordinates requests between the user and AI models, and handles the Kubernetes context.
3. **Presentation**: Provides the user interface through the command line, formats responses, and manages interaction.

The `--mcp-server` parameter in kubectl-ai starts the tool in server mode, allowing it to act as a service that can receive requests, process them through the MCP architecture, and return responses.

## Architecture

kubectl-ai follows a modular architecture that enables communication between Kubernetes, AI models, and the user:

```
┌───────────────┐     ┌────────────────────┐     ┌────────────────┐
│   User        │     │  Processing        │     │   AI Model     │
│   Input       │────▶│  and Transformation│────▶│   Providers    │
│   (CLI)       │     │  (kubectl-ai)      │     │                │
└───────────────┘     └────────────────────┘     └────────────────┘
       ▲                        │                        │
       │                        ▼                        │
       │               ┌────────────────┐                │
       │               │  Kubernetes    │                │
       └───────────────│  API Server    │◀───────────────┘
                       └────────────────┘
```

The typical workflow is:
1. The user enters a command in natural language.
2. kubectl-ai processes this input and sends it to the selected AI model.
3. The AI model generates a response (manifest, command, or explanation).
4. kubectl-ai validates and formats the response.
5. The output is presented to the user or directly applied to the cluster.

## Requirements

### System Requirements
- Kubernetes v1.19 or higher
- Kubectl installed and configured
- Go 1.19+ (only for installation from source)
- Internet access for communication with AI APIs

### API Requirements
To use kubectl-ai, you need at least one of the following APIs configured:
- Google Gemini API (default)
- OpenAI API
- Anthropic API (Claude)
- Cohere API

### Resource Requirements
- Minimum: 200MB RAM and 100MB disk space
- Recommended: 512MB RAM and 200MB disk space

## Installation

### Method 1: Using quick-start (recommended)

```bash
curl -sSL https://raw.githubusercontent.com/GoogleCloudPlatform/kubectl-ai/main/install.sh | bash
```

### Method 2: Installation by downloading

```bash
VERSION=$(curl -s https://api.github.com/repos/GoogleCloudPlatform/kubectl-ai/releases/latest | grep "tag_name" | cut -d '"' -f 4) && wget https://github.com/GoogleCloudPlatform/kubectl-ai/releases/download/${VERSION}/kubectl-ai_Linux_x86_64.tar.gz
```

Build and install:
```bash
tar -xzvf kubectl-ai_Linux_x86_64.tar.gz
chmod +x kubectl-ai
sudo mv kubectl-ai /usr/local/bin/
```

## Configuration

After installation, you must configure kubectl-ai with your API credentials:

### For Google Gemini (recommended for beginners)

It has the capability for different API keys, but we'll use Google Gemini's

```bash
# Set the Google API key
export GOOGLE_API_KEY=your_api_key_here

# Or configure it permanently
echo "export GOOGLE_API_KEY=your_api_key_here" >> ~/.bashrc
source ~/.bashrc
```

## Verification

To verify that kubectl-ai is installed and configured correctly, run these commands:

### 1. Verify the installation

```bash
kubectl ai --help
```

You should see kubectl-ai help with all available options.

### 2. Test basic functionality

```bash
kubectl ai --model gemini-2.5-pro-exp-03-25 "create a deployment with 3 replicas using nginx"
```

If everything is configured correctly, you should receive a YAML manifest for an nginx pod.

![kubectl-ai example 1](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-1.png)
![kubectl-ai example 2](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-2.png)
![kubectl-ai example 3](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-3.png)
![kubectl-ai example 4](https://github.com/Andherson333333/k8s/blob/main/MCP-kubectl-ai/imagenes/kubeclt-ai-4.png)

### 3. Verify model configuration

If the namespace is created correctly, kubectl-ai is working perfectly.

## Common Troubleshooting

### Quota Exceeded Error
If you receive an error like "Error 429, Message: ... doesn't have a free quota tier", try:
1. Using a recommended experimental model: `--model gemini-2.5-pro-exp-03-25`
2. Waiting for your daily quota to reset
3. Setting up a paid account

### API Communication Failures
If the tool cannot connect to the API, verify:
1. That your API key is correct
2. That you have an internet connection
3. That there are no proxy or firewall conflicts

### Resource Generation Errors
If the generated resources are incorrect:
1. Be more specific in your requests
2. Manually verify the manifests before applying them
3. Try with a more advanced model

## Additional Resources

- [Official kubectl-ai Repository](https://github.com/GoogleCloudPlatform/kubectl-ai)
- [Google Gemini API Documentation](https://ai.google.dev/docs/gemini_api)
- [Best Practices for AI Prompts](https://cloud.google.com/vertex-ai/docs/generative-ai/learn/prompting)

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
