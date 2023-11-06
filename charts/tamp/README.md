## 前提依赖

以下组件已经在集群中部署：

- u4a-component
- logging-component
- monitor-component

## 使用 kubebb 部署 API 网关
部署时，配置文件（value.yaml）相关参数按实际情况修改。
- 替换其中minio的值，包括key,secret和endpoint
-  global.minio.key
-  global.minio.secret
-  global.minio.endpoint
- ingress相关配置，根据实际情况填写即可，替换其中hostName的值
-  tamp-portal.ingress.hostName
-  gateway-management.ingress.hostName
 

## Helm方式部署 API 网关
- 先部署minio，再部署gateway-management、tamp-portal
 
### 管理集群安装
- 先部署minio，再部署gateway-management、tamp-portal

### 创建namespace
```
kubectl --as=admin --as-group=iam.tenxcloud.com create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  labels:
     capsule.clastix.io/tenant: system-tenant
  name: tamp-system
EOF
```
### 安装minio(如果已有 minio 可跳过此步)

- 根据实际情况修改 charts/minio/values.yaml中的值，如下所示：
```
image:
  registry: xx # 仓库地址
  repository: xx # 仓库名称
  # Overrides the image tag whose default is the chart appVersion.
  tag: xxx # 镜像版本标识
mountPath:
  path: xxx  # 宿主机数据挂载路径
nodeSelector:
  # minio为有状态服务，需事先在指定节点上打上label
  # 节点打标签操作： kubectl label nodes nodeName tamp-app=minio
  tamp-app: minio 
# 其他采用默认值即可
```
- 使用如下命令进行验证、安装
```
# 使用dry run 方式进行验证
helm install tamp-minio . -n tamp-system -f values-minio.yaml --dry-run
# 正式安装
helm install tamp-minio . -n tamp-system -f values-minio.yaml
```

### 以上只是提供了minio的部署示例，后续可采用自行维护的minio实例

- minio部署完之后，将minio的访问地址赋值到根目录下的values.yaml中global.minio.endpoint中(http://clusterIp:port(9000))
改根路径下values.yaml文件中global.minio.key 和 secret值，进行自定义设置。



### 安装gateway-management和tamp-portal
- 根据实际情况修改 charts/gateway-management/values.yaml，具体如下：
```
image: # 镜像相关配置，按照实际情况填写即可
  registry: xx
  repository: xx
  pullPolicy: Always
  # Overrides the image tag whose default is the chart appVersion.
  tag: xxx

serviceAccount:
  # The name of the service account to use.
  # If not set and create is true, a name is generated using the fullname template
  name: "gateway-api" # pod所采用的的sa名称

# 关于cluster的权限配置
cluster:
  namespace: "addon-system" # 使用默认值即可
  serviceAccount: "host-cluster-reader" # 使用默认值即可

clusterRole:
  name: "gateway-api-host-cluster-reader"

ingress: # ingress相关配置，根据实际情况填写即可
  className: "portal-ingress" # 使用默认值即可
  hostName: "portal.192.168.90.189.nip.io"
  path: /tamp-api # 使用默认值即可
  pathType: ImplementationSpecific # 使用默认值即可

```
- 根据实际情况修改 charts/tamp-portal/values.yaml，具体如下：
```
image: # 镜像相关配置
  registry: xx
  repository: xx
  pullPolicy: Always
  # Overrides the image tag whose default is the chart appVersion.
  tag: xx

ingress: # ingress相关配置，根据实际情况填写即可
  className: "portal-ingress" # 使用默认值即可
  hostName: "portal.172.22.50.142.nip.io"
  path: /tamp-public # 使用默认值即可
  pathType: ImplementationSpecific # 使用默认值即可
```

### 使用dry run方式进行验证
```
helm install tamp . -n tamp-system -f values.yaml --dry-run
# 正式部署
helm install tamp . -n tamp-system -f values.yaml
```
## 卸载步骤
```
# 可在指定命名空间下查看安装的chart包名称
helm list -n tamp-system
# 选择指定的chart包进行卸载
helm uninstall name -n tamp-system
```

## 纳管集群的权限配置
- 使用如下命令进行验证、安装
```
# 使用dry run 方式进行验证
helm install tamp-remote . -n tamp-system -f remote-values.yaml --dry-run
# 正式安装
helm install tamp-remote . -n tamp-system -f remote-values.yaml
```
