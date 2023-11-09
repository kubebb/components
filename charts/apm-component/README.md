# TAPM应用性能监控平台
## TAPM简介
TAPM（TenxCloud MApplication Performance Monitor）是一个托管式的企业级应用性能监控平台，能帮助用户理解系统行为，通过对系统运行数据的分析，当系统发生故障时，快速定位故障。
## 部署TAPM组件

### 前提依赖

1. TAPM 依赖如下组件（部署 Kubebb 时已同步部署）：

- [u4a-component](https://github.com/kubebb/components/tree/main/charts/u4a-component)
- logging-component
- monitor-component

2. 创建namespace:

进入[管理工作台/租户管理]，选择要部署TAPM的。进入此租户详情页，创建部署TAPM所需项目，项目名称建议填写”性能监控组件“，填写命名空间名称等其它参数。

### 部署
1. 进入组件市场，找到应用性能监控平台组件，点击”安装“
2. ”安装位置“选择上面创建好的租户和项目
3. 配置文件（value.yaml）的参数说明：

| 参数                                            | 说明                        | 默认值 |
|-----------------------------------------------|---------------------------|---------|
| `global.host`                                 | 是否主集群（备用字段，保持默认true即可）    | true   |
| `global.registry`                             | harbor仓库地址                |         |
| `global.ingressHostName`                      | ingress的hostname        |         |
| `global.clusterReaderNameOverride`            | 访问集群的serviceaccount名称，一般保持默认      |         |
| `gloabl.clusterReaderNameSpaceOverride`       | 上面serviceaccount所在的namespace，一般保持默认 |         |

其它参数一般保持默认即可。