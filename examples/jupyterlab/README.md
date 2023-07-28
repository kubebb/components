# Jupyterlab

A example to deploy a arcadia `JupyterLab` component with kubebb. After this component deployed, you can get a `jupyterlab` instance.

Please refer to [arcadia-jupyter](https://github.com/kubeagi/arcadia/tree/main/charts/jupyterlab) for more details.

## Prerequisites

1. Installed [kubebb](https://github.com/kubebb) v0.1.2+ by following this [guide](https://kubebb.github.io/website/docs/category/快速开始) which includes:

- kubebb/core (Required)
- `building-base` which contains`cluster-component` and `u4a-component`

After `building-base` deployed,you will get a `ingressNodeIP` which is used in the `Install` step.

2. Create a repo [arcadia](https://github.com/kubebb/components/blob/main/repos/repository_arcadia.yaml) if not exists

```shell
    kubectl apply -n kubebb-system -f repos/repository_arcadia.yaml
```

3. Get the arcadia jupyterlab component

```shell
    kubectl get -nkubebb-system component arcadia.jupyterlab
```

## Install jupyterlab

1. Edit `componentplan.yaml`

- replace `{ingressNodeIP}` with the real one

2. Apply `componentplan.yaml`

```shell
    kubectl apply -f  examples/jupyterlab/componentplan.yaml
```

3. Open `https://jupyterlab.{ingressNodeIP}.nip.io` in browser and login with `Passw0rd!`
