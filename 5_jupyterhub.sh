#!/bin/bash

# Automation for the jupyterhub deploy
echo "tag and push images into registry first"
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

# Load the helm chart

helm upgrade --cleanup-on-fail \
  --install jupyterhub jupyterhub/jupyterhub \
  --namespace jhub \
  --create-namespace \
  --version=1.1.3 \
  --timeout 10m \
  --values jupyterhub/config.yaml

# rollback: 
# helm 

echo "adding service account for spawning spark workers"
kubectl apply -f jupyterhub/spark-service-user.yaml

echo "Apply Ingress script"
kubectl apply -f jupyterhub/jupyter-ingress.yaml

### Notes from https://discourse.jupyter.org/t/jupyterhub-on-k8s-with-traefik/1605

