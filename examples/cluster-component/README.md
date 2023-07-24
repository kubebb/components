# Install Cluster Component with Kubebb

## Prerequisites

- [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) installed

- Repository [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml) created and synced

```shell
    kubectl apply -n kubebb-system -f repos/repository_kubebb.yaml
```

## Install Cluster Component with KubeBB Core

**Currently, the u4a-component component is not fully adapted and can only be deployed under u4as-system namespace**

1. Create namespace `u4a-system` if not exists

```shell
    kubectl create namespace u4a-system
```

2. Get the deployment node for `ingress-nginx` which exposes port `80` a nd `443`

For example,if your kubernetes cluster deployed according to the documentation [kind-cluster](https://kubebb.github.io/website/docs/core/get_started#kind%E5%BC%80%E5%8F%91%E9%9B%86%E7%BE%A4), the deployment node would be `kubebb-core-control-plane`.

3. Edit `componentplan.yaml`

- set the cluster-component `version` based on your needs
- replace `overrides` with the deployment node 

```yaml
  override:
    set:
    - ingress-nginx.controller.nodeSelector.kubernetes\.io/hostname=kubebb-core-control-plane
```

4. Apply `componentplan.yaml`

```shell
    kubectl apply -f examples/cluster-component/componentplan.yaml
```
