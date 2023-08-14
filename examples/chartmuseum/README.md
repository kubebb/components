# Install chartmuseum Component with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.3+

2. Create a repo [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml)

```shell
    kubectl apply -n kubebb-system -f repos/repository_kubebb.yaml
```

## Install chartmuseum Component 


1. Apply `componentplan.yaml` or `componentplan_auth.yaml` support basic_auth

```shell
    kubectl apply -f  examples/chartmuseum/componentplan.yaml  or  kubectl apply -f  examples/chartmuseum/componentplan_auth.yaml
```

2. Get service for CLUSTER-IP

```shell
    kubectl get svc -n kubebb-system
    NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    chartmuseum   ClusterIP   10.96.116.173   <none>        8080/TCP   17h 
```

## Use chartmuseum Component as Service

After installing the chartmuseum component, we can use it as service. 

Modify the following `spec.url` according to the clusterIP of the service `chartmuseum` and save it to `repository_chartmuseum.yaml` (chartmuseum with basic authentication can be found in `examples/chartmuseum/repository_chartmuseum.yaml`)

```yaml
apiVersion: core.kubebb.k8s.com.cn/v1alpha1
kind: Repository
metadata:
  name: chartmuseum
  namespace: kubebb-system
spec:
  url: http://10.96.116.173:8080
  pullStategy:
    intervalSeconds: 120
    retry: 5
```

1. Apply `repository_chartmuseum.yaml`

```shell
    kubectl apply -f examples/chartmuseum/repository_chartmuseum.yaml
```