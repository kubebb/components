# Install u4a-component with Kubebb

**Note:This documentation suppose your cluster deployed by [Sample Cluster](https://kubebb.github.io/website/docs/core/get_started#%E5%87%86%E5%A4%87kubernetes%E9%9B%86%E7%BE%A4)**

## Prerequisites

- [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) installed

- Repository [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml) created and synced

```shell
    kubectl apply -n kubebb-system -f repos/repository_kubebb.yaml
```

- Component [cluster-component](https://github.com/kubebb/components/tree/main/charts/cluster-component) installed with [this `ComponentPlan`](https://github.com/kubebb/components/blob/main/examples/cluster-component/componentplan.yaml)

## Install u4a-component

**Currently, the u4a-component component is not fully adapted and can only be deployed under u4as-system namespace**

1. Checkout ingress node ip

> Get the ingress node from [componentplan for cluster-component](https://github.com/kubebb/components/blob/main/examples/cluster-component/componentplan.yaml#L13).For the [Sample Cluster](https://kubebb.github.io/website/docs/core/get_started#%E5%87%86%E5%A4%87kubernetes%E9%9B%86%E7%BE%A4), `kubebb-core-control-plane` is the ingress node

```shell
kubectl get node kubebb-core-control-plane -owide
```


2. Update values.yaml

In values.yaml, we need to make the following substitutions

If `172.18.0.2` is the ip for ingress-nginx,then replace `<replaced-ingress-nginx-ip>` with `172.18.0.2`

> If the name of the ingress created by cluster-component has been changed,
(i.e. the `ingress-nginx.contoller.ingressClass` and `ingress-nginx.controller.ingressClassResource.name` fields segment)

We need to ensure that the field `ingress.name` is consistent with the changes above.

3. Create a configmap based on the modified values.yaml

```shell
kubectl -nu4a-system create cm u4acm --from-file=values.yaml=/path/to/you-updated-values.yaml
```

4. Apply `componentplan.yaml`

```shell
    kubectl apply -f  examples/u4a-component/componentplan.yaml
```

