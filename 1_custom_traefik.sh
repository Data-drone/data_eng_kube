#!/bin/bash

TRAEFIK_SPACE=traefik

helm repo add traefik https://containous.github.io/traefik-helm-chart

helm repo update

kubectl create namespace ${TRAEFIK_SPACE}

helm install traefik traefik/traefik --namespace=${TRAEFIK_SPACE}