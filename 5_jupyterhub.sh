#!/bin/bash

# Automation for the jupyterhub deploy

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/

helm repo update

echo "we need to push the image from our local in"
k3d image import -c test datadrone/deeplearn_minimal:cuda-11.1-base

helm upgrade --cleanup-on-fail \
  --install jhub1 jupyterhub/jupyterhub \
  --namespace jhub \
  --create-namespace \
  --version=1.1.3 \
  --values jupyterhub/config.yaml


### Notes from https://discourse.jupyter.org/t/jupyterhub-on-k8s-with-traefik/1605
