# TDSF 

`TDSF` provides a very simple example on how to develop/deploy a component with lowcode kit.

## Special Notes

1. Dependent Components

- [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core)
- [cluster-component](https://github.com/kubebb/components/tree/main/charts/cluster-component)
- [u4a-component](https://github.com/kubebb/components/tree/main/charts/u4a-component)

2. Restricted Tenants

> Defined at annotation "core.kubebb.k8s.com.cn/restricted-tenants" in Chart.yaml

-  core.kubebb.k8s.com.cn/restricted-tenants: "system-tenant"

3. Restricted Namespaces

> Defined at annotation "core.kubebb.k8s.com.cn/restricted-namespaces" in Chart.yaml


## Getting started

1. Add this repo

This repo has been created when kubebb-core installed by default. In case it don't, you can add it manually with below command:  

```shell
    kubectl apply -f https://raw.githubusercontent.com/kubebb/components/main/repos/repository_kubebb.yaml
```

2. Install this component

> Update the `ingress.ingressDomain` if needed 

```shell
    # primary cluster
    kubectl apply -f https://raw.githubusercontent.com/kubebb/components/main/examples/tdsf/componentplan_primary.yaml
    # remote cluster
    kubectl apply -f https://raw.githubusercontent.com/kubebb/components/main/examples/tdsf/componentplan_remote.yaml
```

3. Check the installation status

```shell
    kubectl get pod -n mesh-system
```

### Configuration

| Parameter                               | Description                                                | Default |
|-----------------------------------------|------------------------------------------------------------|---------|
| `global.host`                           | Cluster is primary or remote                               | false   |
| `global.clusterReaderNameOverride`      | the name of secret that accesses the cluster               |         |
| `gloabl.clusterReaderNameSpaceOverride` | the namespace of secret that accesses the cluster          |         |
| `mesh-operator.enabled`                 | Enable the mesh-operator                                   | true    |
| `mesh-api.enabled`                      | Enable the mesh-api                                        | true    |
| `tdsf-portal.enabled`                   | Enable the tdsf-portal                                     | true    |
| `remote-role-component`                 | Enable the mesh-api                                        | true    |

**Note: See the README-tdsf.md**
