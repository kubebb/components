# Hello-world 

`Hello-world` provides a very simple example on how to develop/deploy a component with lowcode kit.

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

**None**

## Getting started

1. Add this repo

This repo has been created when kubebb-core installed by default. In case it don't, you can add it manually with below command:  

```shell
    kubectl apply -f https://raw.githubusercontent.com/kubebb/components/main/repos/repository_kubebb.yaml
```

2. Install this component

> Update the `ingress.ingressDomain` if needed 

```shell
    kubectl apply -f https://raw.githubusercontent.com/kubebb/components/main/examples/hello-world/componentplan.yaml
```

3. Check the installation status

```shell

```

4. Access this component service

Open browser and access the following URL `https://portal.{ingress_domain}/umi-demo-public`


### Configuration

| Parameter           | Description                  | Default                           |
|---------------------|------------------------------|-----------------------------------|
| `ingress.enable`     | Enable ingress or not       |       false                       |
| `ingress.ingressClassName`  | Ingress Class        | `portal-ingress`                  |
| `ingress.ingressDomain`     | Ingress Domain       |      172.18.0.2.nip.io            |
| `image`             | Image of the component-store | `kubebb/hello-world:0.1.0`   |
| `imagePullPolicy`   | Image Pull Policy            | `IfNotPresent`                    |
| `resources`         | Resources of the container   |                                   |