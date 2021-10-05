#!/bin/bash

kubectl create namespace postgres-operator

helm install postgres-operator -n postgres-operator postgres-operator-examples/helm/install