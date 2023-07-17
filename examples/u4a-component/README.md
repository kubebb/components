# Install u4a-component with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.0+

2. Create a repo [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml)

```shell
    kubectl apply -n kubebbs-sytem -f repos/repository_kubebb.yaml
```

## Install u4a-component

`u4a-component` relies on the certificate management and ingress-nginx proxy capabilities provided by cluster-component.
At the same time `u4a-system` needs to deploy `kube-oidc-proxy` service, also need to choose the node, here we choose `kubebb-core-control-plane`.  

According to the deployment documentation for [cluster-component](../cluster-component/README.md),   
we know that ingress-nginx is also deployed to the node `kubebb-core-control-plane`


**Currently, the u4a-component component is not fully adapted and can only be deployed under u4as-system namespace**

1. checkout kubebb-core-control-plane node ip

```shell
kubectl get node kubebb-core-control-plane -owide
```

2. update values.yaml

In values.yaml, we need to make the following substitutions

`172.18.0.2` and `kind-worker` is the ip and name of the deployment node for ingress-nginx.
`172.18.0.3` and `kind-worker2` is the ip and name of the deployment node of the kube-oidc-proxy.

- `172.18.0.2 -> <kubebb-core-control-plane ip>`
- `172.18.0.3 -> <kubebb-core-control-plane ip>`
- `kind-worker -> kubebb-core-control-plane`
- `kind-worker2 -> kubebb-core-control-plane` 

If we update the name of the ingress created by cluster-component.
i.e. the `ingress-nginx.contoller.ingressClass` and `ingress-nginx.controller.ingressClassResource.name` fields segment

We need to ensure that the field `ingress.name` is consistent with the changes above.

Create a configmap based on the modified values.yaml

```shell
kubectl -nu4a-system create cm u4acm --from-file=values.yaml=/path/to/you-updated-values.yaml
```

3. Apply `componentplan.yaml`

```shell
    kubectl apply -f  examples/u4a-component/componentplan.yaml
```

