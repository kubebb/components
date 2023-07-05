# Install Minio with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.0+

2. Create a repo [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml)

```shell
    kubectl apply -n kubebb-system -f repos/repository_kubebb.yaml
```

## Install Minio

1. Apply `componentplan.yaml`

```shell
    kubectl apply -f  examples/minio/componentplan.yaml
```
