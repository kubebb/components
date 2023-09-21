# Install chartmuseum Component with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.3+

2. Create a repo [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml)

```shell
    kubectl apply -n kubebb-system -f repos/repository_kubebb.yaml
```

## Install chartmuseum Component 

### Without basic auth enabled

1. Apply `componentplan.yaml`

```shell
    kubectl apply -f  examples/chartmuseum/componentplan.yaml
```

2. Get service for CLUSTER-IP

```shell
    kubectl get svc -n kubebb-addons
    NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    chartmuseum   ClusterIP   10.96.116.173   <none>        8080/TCP   17h 
```

### With basici auth enabled

1. Apply `componentplan_auth.yaml`(basic_auth enabled)

```shell
    kubectl apply -f  examples/chartmuseum/componentplan_auth.yaml
```

2. Get service for CLUSTER-IP

```shell
    kubectl get svc -n kubebb-addons
    NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    chartmuseum_auth   ClusterIP   10.96.116.173   <none>        8080/TCP   17h 
```

## Use chartmuseum service  as a kubebb Repository

After installing the chartmuseum component, we can use it as a kubebb repository. 

Based on the componentplan used for chartmuseum deployment, you should use different repository chartmuseum.yaml.

- If basic auth is enabled, apply `repository_chartmuseum_auth.yaml`

```shell
    kubectl apply -f examples/chartmuseum/repository_chartmuseum_auth.yaml
```

- If basic auth is disabled, apply `repository_chartmuseum.yaml`

```shell
    kubectl apply -f examples/chartmuseum/repository_chartmuseum.yaml
```