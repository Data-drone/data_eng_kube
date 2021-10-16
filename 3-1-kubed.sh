#!/bin/bash

# adding in the kubed service for syncing secrets
helm repo add appscode https://charts.appscode.com/stable/

helm repo update

helm search repo appscode/kubed --version v0.12.0

helm install kubed appscode/kubed \
  --version v0.12.0 \
  --namespace kube-system