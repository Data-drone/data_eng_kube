#!/bin/bash

kubectl create namespace mlflow

# create the backing database
kubectl apply -k mlflow/postgres

## temp need to work out how to wait for kubernetes to check if postgres ready
# sleep 30
kubectl wait --for=condition=Ready --timeout=600s pod -l postgres-operator.crunchydata.com/cluster=mlflow -n mlflow

# create the mlflow instance
kubectl apply -f mlflow/mlflow_setup.py