#!/bin/bash

function apply {
  for _ in `seq 1 ${2:-1}`; do kustomize build --enable-helm $1 | kubectl apply -f -; done
}

function wait {
  kubectl wait --for=condition=ready pod --timeout=5m "$@"
}

[ -f ./vernal-keys.secret.yaml ] || { >&2 echo 'error: ./vernal-keys.secret.yaml not found'; exit 1; }

k3d cluster create --config ./k3dcluster.yaml

kubectl apply -f vernal-keys.secret.yaml
apply projects/core/sealed-secrets

apply projects/core/coredns

apply projects/core/gateway-api
apply projects/core/istio
wait -l app=istiod -n istio-system

apply projects/core/reflector

# apply projects/core/cert-manager
# wait -l app=webhook -n cert-manager
# apply projects/core/cert-manager

kubectl apply -f projects/core/cert-manager/namespace.yaml
kubectl apply -f projects/core/cert-manager/local-lan-vernal-dev-tls.sealedsecret.yaml

apply projects/core/crossplane
wait -l app=crossplane -n crossplane-system

apply projects/core/cnpg
wait -l app.kubernetes.io/name=cloudnative-pg -n cnpg-system

kubectl apply -f projects/core/keycloak/namespace.yaml
apply projects/core/keycloak/postgres
kubectl wait --for=condition=Ready=True clusters.postgresql.cnpg.io --timeout=10m -l app=keycloak -n keycloak
apply projects/core/keycloak/keycloak
wait -l app=keycloak -n keycloak

apply projects/core/keycloak/keycloak-config-cli
wait -l app=keycloak-config-cli -n keycloak

apply projects/core/keycloak/provider
kubectl wait --for=condition=Healthy=True --timeout=5m providers.pkg.crossplane.io/provider-keycloak
apply projects/core/keycloak/resources
kubectl wait --for=condition=Ready=True --timeout=5m realms.realm.keycloak.crossplane.io/vernal
apply projects/core/keycloak/internal

kubectl apply -f projects/core/argocd/namespace.yaml
apply projects/core/argocd/infra
kubectl wait --for=condition=Ready=True --timeout=10m clients.openidclient.keycloak.crossplane.io/argocd
apply projects/core/argocd 2
apply projects/root/bootstrap

echo 'Local Vernal Kubernetes cluster is up and running 🎉'
