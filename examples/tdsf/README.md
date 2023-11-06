# Install tdsf with Kubebb

**Note:This documentation suppose your cluster deployed by [Sample Cluster](https://kubebb.github.io/website/docs/core/get_started#%E5%87%86%E5%A4%87kubernetes%E9%9B%86%E7%BE%A4)**

## Prerequisites

- [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) installed

- Repository [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml) created and synced

```shell
    kubectl apply -n kubebb-system -f repos/repository_kubebb.yaml
```

- Component [cluster-component](https://github.com/kubebb/components/tree/main/charts/cluster-component) installed with [this `ComponentPlan`](https://github.com/kubebb/components/blob/main/examples/cluster-component/componentplan.yaml)

## Install tdsf in primary cluster

1. Create ConfigMap

```shell
    kubectl create cm tdsf-helm-values --from-file=primary.yaml=tdsf/values.yaml -n mesh-system
```

2. Apply `componentplan_primary.yaml`

```shell
    kubectl apply -f  examples/mesh-anywhere/componentplan_primary.yaml
```

## Install tdsf in remote cluster

1. Create ConfigMap

```shell
    kubectl create cm tdsf-helm-values --from-file=remote.yaml=tdsf/remote-values.yaml -n mesh-system
```

2. Apply `componentplan_remote.yaml`

```shell
    kubectl apply -f  examples/mesh-anywhere/componentplan_remote.yaml