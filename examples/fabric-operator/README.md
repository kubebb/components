# Install Fabric Operator with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.0+

2. Create a repo [kubebb](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml)

```shell
    kubectl apply -n kubebbs-sytem -f repos/repository_kubebb.yaml
```

## Install Fabric Operator

The fabric-operator component depends on `cluster-component`, `u4a-system component`, `minio` and `tekton-operator` 4 components.

1. Adjust parameters

A few parameters to adjust for fabric-operator deployment:

- minio.host

The minio component is deployed in the defautl namespace, just find his svc name and port.

- minio.accessKey, minio.secretKey
These two parameters are used to connect to the minio service and are stored in the secret under the namespace where minio is deployed.

```yaml
root@macbookpro:~/step/components/examples/minio# kubectl get secret 
NAME           TYPE     DATA   AGE
fabric-minio   Opaque   2      42s
root@macbookpro:~/step/components/examples/minio# kubectl get secret  -oyaml
apiVersion: v1
items:
- apiVersion: v1
  data:
    rootPassword: Z2pLZWg0RkFPRHRla0hlNW1DckRwT0g4d2Q0VTVycDhLa290dDc0WQ==
    rootUser: Q3Q3MTZDMTBkeUI0NERodmZyNDM=
  kind: Secret
  metadata:
    creationTimestamp: "2023-07-06T09:31:39Z"
    labels:
      app: minio
      chart: minio-5.0.7
      core.kubebb.k8s.com.cn/componentplan: fabric-minio
      heritage: Helm
      release: fabric-minio
    name: fabric-minio
    namespace: default
    resourceVersion: "18647"
    uid: 881ed632-1fa9-4514-abf0-fb93a03870e3
  type: Opaque
kind: List
metadata:
  resourceVersion: ""
```

2. Create secret for dockerhub

We need to create a secret named `dockerhub-secret` to store dockerhub's authentication information.

```shell
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: dockerhub-secret
data:
  config.json: $(echo -n "{\"auths\":{\"https://index.docker.io/v1/\":{\"auth\":\"$(echo -n 'hyperledgerk8stest:Passw0rd!' | base64)\"}}}" | base64 | tr -d \\n)
EOF

```

3. Apply `componentplan.yaml`

```shell
apiVersion: core.kubebb.k8s.com.cn/v1alpha1
kind: ComponentPlan
metadata:
  name: fabric-operator
  namespace: baas-system
spec:
  approved: true
  name: fabric-operator
  version: 0.1.0
  override:
    set:
    - namespace=kubebb-system
    - ingressDomain=<your-ingress-nginx-node-ip>.nip.io
    - minio.secretKey=somesecretkey
    - minio.accessKey=someaccesskey
    - minio.host=<minio-svc-name>.<minio-namespace>.svc.cluster.local:9000
  component:
    name: kubebb.fabric-operator
    namespace: kubebb-system
```

