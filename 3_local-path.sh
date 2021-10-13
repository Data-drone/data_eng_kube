#!/bin/bash

# We need local path for multiple things so lets break it out
echo "deploy the local-path provisioner"
#kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
kubectl apply -f local-path-config/local-path-config.yaml

# I don't think we need this anymore?
#kubectl apply -f local-path-config/role-local-path.yaml

# Make local-path the default
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
