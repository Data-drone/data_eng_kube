#!/bin/bash

# We need local path for multiple things so lets break it out
echo "deploy the local-path provisioner"
kubectl apply -f local-path-config/local-path-deploy.yaml

kubectl apply -f local-path-config/local-path-config.yaml

