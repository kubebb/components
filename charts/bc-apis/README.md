# BC APIS Helm Chart

This Helm chart installs the `bc-apis` into your Kubernetes (v1.16+) or Openshift cluster (v4.3+).

## In Helm

### Install bc-apis

> NOTE: Use `bc-apis` as release name

```shell
    helm install bc-apis kubebb/bc-apis
```

### Upgrade bc-apis

```shell
    helm upgrade bc-apis kubebb/bc-apis
```

### Uninstall bc-apis

```shell
    helm delete bc-apis
```

## Configuration

| Parameter                    | Description                       | Default                                       |
|------------------------------|-----------------------------------|-----------------------------------------------|
| `ingressDomain`              | Ingress Domain                    |                                               |
| `ingressClassName`           | Ingress Class                     | `portal-ingress`                              |
| `storageClassName`           | Storage Class                     | `standard`                                    |
| `iamServer`                  | Service address of IAM            | `https://oidc-server.u4a-system`              |
| `env.k8sOIDCProxyURL`        | OIDC Proxy Url                    |                                               |
| `env.OIDCServerURL`          | OIDC Server Url                   |                                               |
| `env.OIDCServerClientID`     | OIDC Server Client ID             |                                               |
| `env.OIDCServerClientSecret` | OIDC Server Client Secret         |                                               |
| `env.imageNamespace`         | Image namespace in Docker hub     | `hyperledgerk8s`                              |
| `env.imageFabricCATag`       | Image Tag of the FabricCA         | `iam-20230131`                                |
| `env.imageFabricOrdererTag`  | Image Tag of the FabricOrderer    | `2.4.7`                                       |
| `env.imageFabricPeerTag`     | Image Tag of the FabricPeer       | `2.4.7-external`                              |
| `env.logLevels`              | Log Levels                        | `log,error,warn`                              |
| `env.minioAccessKey`         | Minio Access Key                  |                                               |
| `env.minioSecretKey`         | Minio Secret Key                  |                                               |
| `env.minioEndpoint`          | Minio Endpoint                    | `fabric-minio.baas-system.svc.cluster.local`  |
| `image`                      | Image of bc-apis                  | `hyperledgerk8s/bc-apis:20230703.143401.87`   |
| `imagePullPolicy`            | Image Pull Policy                 | `IfNotPresent`                                |
| `hostAliases[0].hostnames`   | HostAliases of the deploy bc-apis |                                               |
| `hostAliases[0].ip`          | Ingress nginx ip                  |                                               |
