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
This local development clusters comes pre-configured and bundled with:

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

## Requirements
The following tools below are required in order to deploy a local development cluster.

- [Docker](https://docs.docker.com/get-docker/)
- [K3d](https://k3d.io/v5.6.0/#installation)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/)
- [Helm](https://helm.sh/docs/intro/install/)

## Deployment
To deploy and bootstrap a local development cluster, run the provided script.

```sh
./bootstrap.sh
```
*Note: This process may take upwards of 15 minutes to complete.*
