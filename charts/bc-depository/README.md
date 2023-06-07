# bc-depository

Helm charts to install bestchain depository service to kubernetes!

## Pre-install

### Prepare blockchain network's conneciton profile for `Secret`

Download connection profile into `files/network.json`

- Download conneciton profile via `bestchains console`
- Download connnection profile via [`bc-cli`](https://bestchains.github.io/website/docs/tools/cli#%E8%8E%B7%E5%8F%96%E9%80%9A%E9%81%93%E8%BF%9E%E6%8E%A5%E6%96%87%E4%BB%B6)

### Prepare oidc secrets if use `oidc` auth

To enable `oidc` auth in bc-depository, you need to create two secrets under same namespace:

- oidc-server-root-secret
- kube-oidc-proxy-config

If you are using oidc service by [building-base](https://github.com/kubebb/building-base),you can create secrets by:

```shell
kubectl get secret kube-oidc-proxy-config -n u4a-system -o json \
 | jq 'del(.metadata["namespace","creationTimestamp","resourceVersion","selfLink","uid"])' \
 | kubectl apply -n baas-system -f -

kubectl get secret oidc-server-root-secret -n u4a-system -o json \
 | jq 'del(.metadata["namespace","creationTimestamp","resourceVersion","selfLink","uid"])' \
 | kubectl apply -n baas-system -f -
```

## Install bc-depository

> NOTE: Use `bc-depository` as release name

### In Kubebb

To be detailed!

### In Helm

```shell
    helm install bc-depository kubebb/bc-depository
```

## Upgrade bc-depository

### In Kubebb

To be detailed!

### In Helm

```shell
    helm upgrade bc-depository kubebb/bc-depository
```

## Uninstall bc-depository

### In Kubebb

To be detailed!

### In Helm

```shell
    helm delete bc-depository
```

## Configuration

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `fullnameOverride`                                | Full name of this deployment                          | `bc-depository`                                                     |
| `deployment.image`                                | Image of  bc-depository                             | `hyperledgerk8s/bc-saas:v0.0.1-20230524`                                                     |
| `ingress.enabled`                                | Enable ingress                            | `false`                                                     |
| `ingress.ingressClassName`                                | Ingress class used in bc-depository                            | `portal-ingress`                                                     |
| `ingress.ingressDomain`                                | Ingress domain used in bc-depository                            | `172.18.0.2.nip.io`                                                     |
| `runtimeArgs.auth`                                | Auth mode in bc-depository.Support `none` and `oidc` two modes.                            | `none`                |
| `runtimeArgs.oidc.serverRootSecret`                                | OIDC server root secret if Auth mode is `oidc`                          | `oidc-server-root-secret`                                                     |
| `runtimeArgs.oidc.proxyConfigSecret`                                | OIDC proxy config secret if Auth mode is `oidc`                          | `kube-oidc-proxy-config`                                                     |
| `runtimeArgs.contract`                                | Contract name which is running with [depository contract](https://github.com/bestchains/bestchains-contracts/tree/main/contracts/depository)                         | `depository`                                                     |
| `runtimeArgs.db`                                | Database type which stores depository info.Support `log` and `pg` two dbs.                        | `pg`                                                     |
| `runtimeArgs.dsn`                                | Database connection string(`Must required when db is pg`)                       | `postgres://bestchains:Passw0rd!@bc-explorer-postgresql.baas-system.svc.cluster.local:5432/bc-saas?sslmode=disable`                                                     |
