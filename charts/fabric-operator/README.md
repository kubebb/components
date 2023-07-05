# Fabric Operator Chart

## Installation

Quick start to deploy `FabricOperator` by `kubebb/core`.

### Prerequisites

Before installing fabric-operator, make sure that the `u4a-component` have been deployed.

#### Install chart using ComponentPlan

1. First create the Repository

```yaml
apiVersion: core.kubebb.k8s.com.cn/v1alpha1
kind: Repository
metadata:
  name: sample-test
  namespace: kubebb-system
spec:
  url: http://127.0.0.1:9999/def
  pullStategy:
    intervalSeconds: 120
    retry: 5
```

2. Check if the component is created

```shell
$ kubectl get component.core.kubebb.k8s.com.cn -nkubebb-system
NAME                                  AGE
sample-test.fabric-operator           1m
```

3. Create ComponentPlan installation operator

According to the contents of `values.yaml`, there are three positions that need to be replaced


- namespace
- iamServer
- minio.host
- minio.accesskey
- minio.secretKey

```yaml
apiVersion: core.kubebb.k8s.com.cn/v1alpha1
kind: ComponentPlan
metadata:
  name: fabric-operator
  namespace: kubebb-system
spec:
  approved: true
  name: fabric-operator
  version: 0.1.0
  override:
    set:
    - iamServer=https://oidc-server.u4a-system.svc.cluster.local
    - minio.host=http://localhost
    - minio.accessKey=accesskey
    - minio.secretKey=secretkey 
  component:
    name: sample-test.fabric-operator
    namespace: kubebb-system
```

#### Verify pods are running properly.

```shell
$ kubectl get po -nkubebb-system
NAME                                  READY   STATUS              RESTARTS   AGE
controller-manager-5cdf6d7d8b-jmklt   0/1     ContainerCreating   0          23s
```

### Configuration

The following table lists the configurable parameters of fabric-operator chart and their default values.

| Parameter                                   | Description                                 | Default                                                          |
| ------------------------------------------- | ------------------------------------------- | ---------------------------------------------------------------- |
| `namespace`                               | which namespace the operator will be deployed.   | default `baas-system`. |
| `ingressDomain`                           | ingress domain.    | default `empty`, **you must set it**.       |
| `ingressClassName`                        | default ingress class name in fabric-operator and bc-apis  | default `portal-ingress` which installed by `installer`,  **you must set it**    |
| `storageClassName`                        | default storage class name in fabric-operator and bc-apis   | default `empty`      |
| `minio.host`                              | The minio host   | default `minio.bestchains-addons.svc.cluster.local`   |
| `minio.accessKey`                         | The access key for accessing Minio  | default   |
| `minio.secretKey`                         | The secret key for accessing Minio   | default   |
| `tekton.namespace`                        | The namespace where bestchains' taks/pipeline/taskrun/pipelinerun will be deployed   | default `bestchains-pipelinerun`   |
| `tekton.dockerConfigSecret`               |  The docker config secret which will be used to push/pull built images  | default `dockerhub-secret`   |
| `operator.watchNamespace`                 | The namespace under which the CR is created can trigger the operator's logic.   | default `empty`, means all namespace. |
| `operator.clusterType`                    | K8S, or OPENSHIFT. | default `K8S`.                |
| `operator.iamServer`                      | iam provider address.                            | default `emtpy`, **you must set it**.   |
| `operator.image`                          | The image that the operator deployment will use. | default `hyperledgerk8s/fabric-operator:latest`   |
| `operator.imagePullPolicy`                | image pull policy.          | default `IfNotPresent`. Other optional values for reference [image pull policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy)  |
| `operator.clusterRoleName`                |  cluster role name. | The clusterrole contains the permissions required by the operator's serviceaccount. default `manager-role` |
| `operator.clusterRoleBindingName`         | cluster role binding   | default `operator` |
| `operator.resources`                      | request resource.  | default request cpu is `100m`, default request memory is `200Mi` |
| `operator.readinessProbe`                 | readiness probe        |                |
| `operator.tolerations`                    | Pod tolerated stains   | Tolerate all stains by default    |
| `operator.affinity`                       | How pods are scheduled |                                   |
| `leaderElection.roleName`                 | The name of the role that contains the permissions needed for operator elections | default `leader-election-role` |
| `leaderElection.roleNameBinding`          | role binding   | default `leader-election-rolebinding`  |
| `authProxy.authProxyServiceName`          | service name   | default `controller-manager-metrics-service` |
| `authProxy.proxyClusterRoleName`          | cluster role name                  | default `proxy-role`           |
| `authProxy.proxyClusterRoleBindingName`   | cluster rolebinding name           | default `proxy-rolebinding`    |
| `authProxy.metricReaderClusterRoleName`   | metrics reader cluster role name   | default `metrics-reader`        |

## Uninstall

Just delete `ComponentPlan`
