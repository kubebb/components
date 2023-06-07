# Components

Host officially verified components/repositories which can be used in our kubebb!

- `charts` host verified components(`helm chart`)
- `repos` host verified repositories

## Usage

### In kubebb

1. Add the kubebb component repository

```shell
    kubectl apply -n kubebb-system -f repos/repository_kubebb.yaml
```

2. Search components under this repository

```shell
    kubectl get components -n kubebb-system -l kubebb.component.repository=kubebb
```

3. Schedule a `ComponentPlan` and subscribe updates

To be detailed!

### In helm

1. Add the kubebb charts repository

```shell
    helm repo add kubebb https://kubebb.github.io/components
```

2. Update the helm repo

```shell
    helm repo update
```

3. Search the helm charts

```shell
    helm search repo kubebb
```

4. Install chart

```shell
    helm install {release_name} kubebb/{chart}
```

## Contribute to Kubebb Components

If you want to contribute to Kubb Core, refer to [contribute guide](CONTRIBUTING.md).

## Support

If you need support, start with the troubleshooting guide, or create github [issues](https://github.com/kubebb/components/issues/new)
