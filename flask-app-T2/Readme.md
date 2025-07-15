## Table of Contents 
* [Using this Repository](#item1)
* [Requirements](#item2)
* [Cluster Architecture](#item3)
* [Flask Application](#item4)
* [Files and Folders](#item5)
* [Docker](#item6)
* [Kubernetes](#item7)
* [Helm](#item8)

<a name="item1"></a>
## Using this Repository

This repository contains a Tier 2 application that can be deployed in multiple ways:

- Dockerfile
- Kubernetes manifests
- Helm charts

<a name="item2"></a>
## Requirements

- Docker and Docker Compose installation
- Kubernetes cluster installation
- Helm installation

<a name="item3"></a>
## Cluster Architecture

The cluster where this application was deployed has the following design:

- Bastion host
- Kubernetes cluster with 2 nodes and 1 master
- NFS server

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/bastion-6.png)

<a name="item4"></a>  
## Flask Application

This is a simple Flask application that interacts with a MySQL database. The application allows users to submit messages, which are then stored in the database and displayed on the interface.

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/bastion-8.png)

<a name="item5"></a>
## Files and Folders

- `helm`: Helm chart and values
- `k8s-manifesto`: Kubernetes manifests
- `Dockerfile`: Dockerization of the application
- `docker-compose`: Deployment with Docker Compose
- `message.sql`: Database creation script

<a name="item6"></a>
## Docker

To deploy with Docker Compose, use the following command:

```
docker-compose up
```

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/docker-ps.png)

<a name="item7"></a>
## Kubernetes

To deploy with manifests, navigate to the folder named `k8s-manifesto`. Inside, there are two folders with the following names:

- flask-app
- mysql

Then, enter each folder and run the following command:

```
kubectl apply -f .
```

### Deployment Verification

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/bastion-7.png)

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/bastion-5.png)

Note: This deployment can be carried out on any Kubernetes cluster. Please note that the PV location needs to be adjusted according to your preference.

<a name="item8"></a>
## Helm

There are two separate Helm charts. To modify the values, you can find the Python application’s values file at `flask-app-T2/flask-app-T2/helm/values.yaml`, and the MySQL values file at `flask-app-T2/flask-app-T2/helm/mysql-statefulset/values.yaml`.

To deploy with Helm charts, navigate to the folder named `helm` and use the following commands:

```
helm install flask-app-mysql mysql-statefulset/ && helm install flask-app-two-tier two-tier-flask-app/
```

### Deployment Verification

```
helm list
```

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/bastion-2.png)

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/bastion-4.png)

![Diagram](https://github.com/Andherson333333/k8s/blob/main/flask-app-T2/imagenes/bastuion-1.png)

Note: This deployment can be carried out on any Kubernetes cluster. Please note that the PV location needs to be adjusted according to your preference.


