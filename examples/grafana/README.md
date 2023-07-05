# Install Grafana with Kubebb

## Prerequisites

1. Install [kubebb-core](https://github.com/kubebb/components/tree/main/charts/kubebb-core) v0.1.0+

2. Deploy [building base](https://github.com/kubebb/building-base)

After building-base deployed, the oidc issuer url will be `https://portal.{ingressNodeIP}.nip.io/oidc`

3. Create a repo [grafana](https://github.com/kubebb/components/blob/main/repos/repository_kubebb.yaml) if not exists

```shell
    kubectl apply -n kubebb-system -f repos/repository_grafana.yaml
```

4. Get the grafana component

```shell
    kubectl get -nkubebb-system component grafana.grafana
```

## Install Grafana

### 1. Update `ingress.yaml` and `componentplan.yaml`

Replace `{ingressNodeIP}` with real ingress node ip.

### 2. Apply `componentplan.yaml`

```shell
    kubectl apply -f  examples/grafana/componentplan.yaml
```

### 3. Apply `ingress.yaml`

```shell
    kubectl apply -f  examples/grafana/ingress.yaml
```

### 4. Access Grafana

Open `https://grafana.{ingressNodeIP}.nip.io` in browser and login with `Sign in with OAuth`

## FAQ

### 1. How to get the auth url and token url?

```shell
    curl --insecure https://portal.{ingressNodeIP}.nip.io/oidc/.well-known/openid-configuration
```

Response

```json
{
    "issuer": "https://portal.{ingressNodeIP}.nip.io/oidc",
    "authorization_endpoint": "https://portal.{ingressNodeIP}.nip.io/oidc/auth",
    "token_endpoint": "https://portal.{ingressNodeIP}.nip.io/oidc/token",
    "jwks_uri": "https://portal.{ingressNodeIP}.nip.io/oidc/keys",
    "userinfo_endpoint": "https://portal.{ingressNodeIP}.nip.io/oidc/userinfo",
    "device_authorization_endpoint": "https://portal.{ingressNodeIP}.nip.io/oidc/device/code",
    "grant_types_supported": [
        "authorization_code",
        "refresh_token",
        "urn:ietf:params:oauth:grant-type:device_code"
    ],
    "response_types_supported": [
        "code"
    ],
    "subject_types_supported": [
        "public"
    ],
    "id_token_signing_alg_values_supported": [
        "RS256"
    ],
    "code_challenge_methods_supported": [
        "S256",
        "plain"
    ],
    "scopes_supported": [
        "openid",
        "email",
        "groups",
        "profile",
        "offline_access"
    ],
    "token_endpoint_auth_methods_supported": [
        "client_secret_basic",
        "client_secret_post"
    ],
    "claims_supported": [
        "iss",
        "sub",
        "aud",
        "iat",
        "exp",
        "email",
        "email_verified",
        "locale",
        "name",
        "preferred_username",
        "at_hash"
    ]
}
```
