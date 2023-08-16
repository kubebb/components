# MinIO Helm Chart(KubeBB optimized)

This chart bootstraps a Minio deployment on a Kubernetes cluster using the Helm package manager. This chart comes from [minio charts](https://github.com/minio/minio/tree/master/helm/minio),but optimized for kubebb!

## Usage

### With Helm

```shell
    helm repo add kubebb https://kubebb.github.io/components
    helm install minio kubebb/minio
```

### With Kubebb

1. Prerequisites

Install the [kubebb core](https://kubebb.github.io/website/docs/quick-start/core_quickstart).

2. Add repository `kubebb`

```shell
    kubectl apply -f https://raw.githubusercontent.com/kubebb/components/main/repos/repository_kubebb.yaml
```

3. Plan a `Minio`

> For more details on minio configuration,see [link](./README_origin.md)

For example:

```shell
apiVersion: core.kubebb.k8s.com.cn/v1alpha1
kind: ComponentPlan
metadata:
  name: my-minio
  namespace: default
spec:
  approved: true
  name: my-minio # similar to helm release name
  version: 5.0.7
  component:
    name: kubebb.minio
    namespace: kubebb-system
  override:
    set:
      - rootUser=admin
      - rootPassword=Passw0rd!
```

NOTE: After applied this `ComponentPlan`,you will get a minio cluster with 3 instances.The default username and password will be `admin/Passw0rd!`
