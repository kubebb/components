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

-  core.kubebb.k8s.com.cn/restricted-namespaces: "mesh-system"

**Note: 需要在system-tenant租户下手动创建mesh-system命名空间**


## 使用Kubebb部署服务网格

### Configuration

安装组件时，配置文件(values.yaml)中需要修改说明

| Parameter                               | Description                                                | Default                                |
|-----------------------------------------|------------------------------------------------------------|----------------------------------------|
| `global.host`                           | Cluster is primary or remote                               | 管理集群true 纳管集群false                     |
| `global.clusterReaderNameOverride`      | the name of secret that accesses the cluster               | 与管理工作台部署时的 clusterReaderName 保持一致      |
| `gloabl.clusterReaderNameSpaceOverride` | the namespace of secret that accesses the cluster          | 与管理工作台部署时的 clusterReaderNamespace 保持一致 |
| `mesh-operator.enabled`                 | Enable the mesh-operator                                   | 管理集群true 纳管集群false                     |
| `mesh-api.enabled`                      | Enable the mesh-api                                        | 管理集群true 纳管集群false                     |
| `tdsf-portal.enabled`                   | Enable the tdsf-portal                                     | 管理集群true 纳管集群false                     |
| `remote-role-component`                 | Enable the mesh-api                                        | true                                   |
| `mesh-api.ingress.className`            | the name of ingress class                                  | 与管理控制台部署的 ingress 的参数保持一致                                       |
| `mesh-api.ingress.hostName`             | the name of ingress host                                   | 与管理控制台部署的 ingress 的参数保持一致                                       |
| `tdsf-portal.ingress.className`         | the name of ingress class                                  | 与管理控制台部署的 ingress 的参数保持一致                                       |
| `tdsf-portal.ingress.hostName`          | the name of ingress host                                   | 与管理控制台部署的 ingress 的参数保持一致                                       |

## 使用Helm部署服务网格


集群间节点时间同步

```bash
# 每个集群节点进行安装
yum install -y chrony
systemctl enable chronyd && systemctl start chronyd
```

### 在“管理集群”部署管理平台

管理集群指的是mesh-api和tdsf-portal所在的k8s集群

给管理集群的 cluster 添加 label 标识

```bash
# cluster-xxxx 为要设置为管理集群的集群名称，在集群管理页面中可查看到集群名称
kubectl label cluster cluster-xxxx t7d.io/host=""
```

网格的部分功能依赖监控组件，部署 TDSF 前需预先在集群部署监控组件。

#### 1. 创建namespace

管理集群上需要创建namespace

- mesh-system

```bash
kubectl --as=admin --as-group=iam.tenxcloud.com create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  labels:
     capsule.clastix.io/tenant: system-tenant
  name: mesh-system
EOF
```

#### 2. 调整values.yaml

1. 根据需要对host-values.yaml进行修改。其中global.host值设置为true，表明这是管理集群

2. global.clusterReaderNameOverride 字段，此处与管理工作台部署时的 clusterReaderName 保持一致

   获取 clusterReaderName 的方式：kubectl get sa -n u4a-system|grep cluster-reader

3. image.registry 表示仓库地址，根据需要调整

4. global.ingress.className 和 global.ingress.hostName 需与管理控制台部署的 ingress 的参数保持一致

查看这两个参数的方式：kubectl get ingress -n u4a-system bff-server-ingress -oyaml：

* global.ingress.className 为 annotations.kubernetes.io/ingress.class 的值
* global.ingress.hostName 为 spec.rules.host 的值

5. 在 mesh-api.env 中，根据需要对管理控制台的 license 所在的 namespace 进行调整，默认在 u4a-system

6. 如果集群关闭了 psp 准入控制，或者 k8s version >= 1.25，需将 mesh-operator.env 里的 ENABLE_PSP 置为 false

7. 根据 k8s 版本选择默认部署的 istio 版本

* 如果 1.22 <= k8s version <= 1.25，将 mesh-api.env 里的 ISTIO_DEFAULT_VERSION 配置为 1.16.7
* 如果 1.24 <= k8s version <= 1.27，将 ISTIO_DEFAULT_VERSION 配置为 1.18.3
* 上面两个 k8s 版本范围有重合的部分，则选择 istio 默认版本为 1.16.7 或 1.18.3 都可以

```yaml
global:
  host: true
  clusterReaderNameSpaceOverride: "u4a-system"
  clusterReaderNameOverride: "host-cluster-reader"
mesh-operator:
  image:
    registry: docker.io
    repository: kubebb/mesh-operator
    tag: v5.7.0
  env:
    - name: LEADER_ELECTION_NAMESPACE
      valueFrom:
        fieldRef:
          fieldPath: metadata.namespace
    - name: CA_ISSUER
      value: istio-ca-issuer
    - name: ENABLE_PSP
      value: true
    - name: ISTIO_HUB_REPO
      value: "kubebb"      
mesh-api:
  image:
    registry: docker.io
    repository: kubebb/mesh-api
    tag: v5.7.0
  env:
    - name: app.license.namespaceOfLicense
      value: "u4a-system"
    - name: MESH_AGENT_IMAGE_SUFFIX
      value: "/kubebb/istio-vm-init"
    - name: NS_MESH
      value: "mesh-system"
    - name: NS_ISTIO
      value: "istio-system"
    - name: NS_MONITORING
      value: "monitoring-system"
    - name: ISTIO_DEFAULT_VERSION
      value: "1.16.7"
  ingress:
     className: "portal-ingress"
     hostName: "portal.172.22.96.136.nip.io"
tdsf-portal:
  image:
    registry: docker.io
    repository: dev-branch/tdsf-portal
    tag: v5.7.0
  ingress:
     className: "portal-ingress"
     hostName: "portal.172.22.96.136.nip.io"
```

#### 3. 运行helm命令部署

正式部署：

```bash
helm install tdsf . -n mesh-system -f values.yaml
```

#### 4. 安装socat

socat需要安装到istiod服务部署所在的集群和节点，未安装时，将影响网格卸载、网格升级、“sidecar管理”中查看xDS配置和同步Pilot功能。（如果已有明确的部署规划，当前集群今后不会作为网格控制面Primary集群，可以跳过）

建议 *在所有节点上都安装socat* ，因为pod可能会分配到任意节点。安装命令如下：

```bash
# RHEL/CentOS
yum install -y socat

# Debian/Ubuntu
apt install -y socat
```

### 加入“纳管集群”

纳管集群指的是平台上管理的其他k8s集群，非mesh-api和tdsf-portal所在的集群

网格的部分功能依赖监控组件，部署 TDSF 前需预先在集群内部署监控组件。

如果存在多个纳管集群，每个集群分别都要执行下列操作


#### 1. 调整remote-values.yaml

1. 根据需要对 remote-values.yaml 进行修改，其中global.host值设置为false，表明这不是管理集群

2. global.clusterReaderNameOverride 字段，此处与管理工作台部署时的 clusterReaderName 保持一致

获取 clusterReaderName 的方式：kubectl get sa -n u4a-system|grep cluster-reader


```yaml
global:
  host: false
  clusterReaderNameOverride: ""
remote-role-component:
   enabled: true
mesh-operator:
   enabled: false
tdsf-portal:
   enabled: false
mesh-api:
   enabled: false
```

#### 2. 运行helm命令部署

正式部署：

```bash
helm install tdsf . -f remote-values.yaml
```

#### 3. 安装socat

socat需要安装到istiod服务部署所在的集群和节点，未安装时，将影响网格卸载、网格升级、“sidecar管理”中查看xDS配置和同步Pilot功能。（如果已有明确的部署规划，当前集群今后不会作为网格控制面Primary集群，可以跳过）

建议 *在所有节点上都安装socat* ，因为pod可能会分配到任意节点。安装命令如下：

```bash
# RHEL/CentOS
yum install -y socat

# Debian/Ubuntu
apt install -y socat
```
