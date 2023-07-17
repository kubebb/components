# Install Cluster Component with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.0+

2. Create a repo [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml)

```shell
    kubectl apply -n kubebbs-sytem -f repos/repository_kubebb.yaml
```

## Install Cluster Component

According to the documentation [kind-cluster](https://kubebb.github.io/website/docs/core/get_started#kind%E5%BC%80%E5%8F%91%E9%9B%86%E7%BE%A4), 
we know that the cluster has only one node named `kubebb-core-control-plane`.
Select `kubebb-core-control-plane` as the deployment node for ingress.

**Currently, the u4a-component component is not fully adapted and can only be deployed under u4as-system namespace**

1. Apply `componentplan.yaml`

```shell
    kubectl apply -f  examples/cluster-component/componentplan.yaml
```
