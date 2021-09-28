#!/bin/bash

# Automation for the jupyterhub deploy
REGISTRY_PORT=$1

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/

helm repo update

## Process to push images to k3d registry
# is it better we do this first that the helm chart deploys faster
#push_image() {
#  docker tag $1 localhost:$2/$1
#  docker push localhost:$2/$1
#}
#
#for IMAGE in 'datadrone/deeplearn_minimal:cuda-11.1-base' 'datadrone/spark_notebook_kube:latest' 'datadrone/spark-worker:3.1.2-hadoop3.2-rapids'
#do
#  push_image $IMAGE $REGISTRY_PORT
#done

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

