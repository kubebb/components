# TMF微服务治理平台
## TMF简介
TMF（TenxCloud Microservice Framework）是一个托管式的企业级微服务应用流量统一管理平台。以开源框架 Spring Cloud、Nacos为核心基础组件，支持主流微服务框架SpringCloud、Dubbo，轻松完成原生SpringCloud，Dubbo上云。
## 部署tmf组件

### 前提依赖

1. TMF 依赖如下组件（部署 Kubebb 时已同步部署）：

- [u4a-component](https://github.com/kubebb/components/tree/main/charts/u4a-component)
- logging-component
- monitor-component

2. 创建namespace:

进入[管理工作台/租户管理]，找到系统租户，即tenant_ID是system-tenant。进入此租户详情页，创建部署TMF所需项目，项目名称建议填写”微服务组件“，命名空间须填写 ”msa-system“，其他按需填写即可。

### 部署
1. 进入组件市场，找到微服务组件，点击”安装“
2. ”安装位置“选择”系统租户(system-tenant)“和”微服务组件(msa-system)“
3. 配置文件（value.yaml）的参数说明：

| 参数                                            | 说明                        | 默认值 |
|-----------------------------------------------|---------------------------|---------|
| `global.host`                                 | 是否主集群（备用字段，保持默认true即可）    | true   |
| `global.registry`                             | harbor仓库地址                |         |
| `global.ingressHostName`                      | ingress的hostname        |         |
| `global.clusterReaderNameOverride`            | 访问集群的serviceaccount名称，一般保持默认      |         |
| `gloabl.clusterReaderNameSpaceOverride`       | 上面serviceaccount所在的namespace，一般保持默认 |         |

其它参数一般保持默认即可。