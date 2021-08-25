#!/bin/bash

METALLB_VERSION='v0.10.2'

NAMESPACE_URL=https://raw.githubusercontent.com/metallb/metallb/${METALLB_VERSION}/manifests/namespace.yaml
METALLB_URL=https://raw.githubusercontent.com/metallb/metallb/${METALLB_VERSION}/manifests/metallb.yaml

curl ${NAMESPACE_URL} > load_balancer/namespace.yaml
curl ${METALLB_URL} > load_balancer/metallb.yaml

# need to fix grep statement
if  grep -Fxq "404: Not Found" load_balancer/namespace.yaml  ||  grep -Fxq "404: Not Found" load_balancer/metallb.yaml 
then
    echo "error cannot download Metallb files - check urls"
    echo ${NAMESPACE_URL}
    echo ${METALLB_URL}
else
    kubectl apply -f load_balancer/namespace.yaml
    kubectl apply -f load_balancer/metallb.yaml

    kubectl apply -f load_balancer/metallb-config-map.yaml
fi