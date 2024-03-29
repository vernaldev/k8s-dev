<div align="center">
  <a align="center" href="https://vernal.dev">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="./assets/vernal-dark.png">
      <img src="./assets/vernal-light.png" align="center" alt="Vernal" height="320" />
    </picture>
  </a>
  <hr />
  <p align="center">Seamlessly deploy and manage all of your applications in one place.</p>
</div>

# Quick Start
This local development cluster comes pre-configured and bundled with:

- Argo CD
- Cert-Manager
- CloudNativePG
- CoreDNS
- Crossplane
- Gateway API
- Istio
- Keycloak
- Reflector
- Sealed Secrets
- Whoami

The following alerting, monitoring, and observability services will be coming soon:
- Alert Manager
- Blackbox Exporter
- Grafana
- Kiali
- Kube State Metrics
- Kube Watch
- Loki
- Node Exporter
- Prometheus
- Promtail

## Requirements
The following tools below are required to deploy a local development cluster.

- [Docker](https://docs.docker.com/get-docker/)
- [K3d](https://k3d.io/v5.6.0/#installation)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/)
- [Helm](https://helm.sh/docs/intro/install/)

Additionally, secret keys are necessary in order to decrypt the sensitive values that are stored in this repository. Paste the contents of the provided secret (*Ask Dennis*) into a file named `vernal-keys.secret.yaml` in the root of this repository.

It should look something like this:

```yaml
apiVersion: v1
kind: Secret
metadata:
  labels:
    sealedsecrets.bitnami.com/sealed-secrets-key: active
  name: vernal-keys
  namespace: kube-system
data:
  tls.crt: ...
  tls.key: ...
type: kubernetes.io/tls
```

## Deployment
To deploy and bootstrap a local development cluster, run the provided script.

```sh
./bootstrap.sh
```
*Note: This process may take upwards of 15 minutes to complete.*

## Post Deployment
Once the deployment and bootstrapping process is complete, it is best practice to permanently delete the `vernal-keys.secret.yaml` file in order to prevent any security issues.

Several services should now be accessible from the browser.

| Service  | URL                                 |
|----------|-------------------------------------|
| Argo CD  | https://argocd.local.lan.vernal.dev |
| Grafana  | (coming soon)                       |
| Keycloak | https://sso.local.lan.vernal.dev    |
| Kiali    | (coming soon)                       |
| Whoami   | https://whoami.local.lan.vernal.dev |
