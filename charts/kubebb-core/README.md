# Kubebb Core Helm Chart

This chart bootstraps a Kubebb Core deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Usage

```shell
    helm repo add kubebb https://kubebb.github.io/components
    kubectl create ns kubebb-system
    helm install -nkubebb-system kubebb-core kubebb/kubebb-core
```

## Configuration

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `deployment.image`                        |  Image for kubebb core controller             |  `kubebb/core:v0.1.1`                                   |
| `deployment.imagePullPolcy`               |  Image pull policy for kubebb core controller |  `IfNotPresent`                                         |
| `deployment.resources`                    |  Resouce request and limits for kubebb core controller    |  see the values.yaml                        |
