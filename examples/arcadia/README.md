# Install Arcadia with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.3+

2. Create a repo [arcadia](https://github.com/kubebb/components/blob/main/repos/repository_arcadia.yaml)

```shell
    kubectl apply -n kubebb-system -f repos/repository_arcadia.yaml
```

## Install Arcadia with `ComponentPlan`

Apply `componentplan.yaml`

```shell
    kubectl apply -f examples/arcadia/componentplan.yaml
```

## Install Arcadia with `Subscription`

> `Subscription` will deploy the latest `Arcadia` automatically and update it when new version is released.

Apply `subscription.yaml`

```shell
    kubectl apply -f  examples/arcadia/subscription.yaml
```
