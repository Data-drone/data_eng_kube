#!/bin/bash

MINIO_SPACE=minio-tenant


kubectl create namespace ${MINIO_SPACE}

echo "this requires installing minio operator plugin first and ensuring it is on path"
kubectl minio init

echo "Wait for Minio Operator to start"
kubectl wait --for=condition=available --timeout=600s deployment/minio-operator -n minio-operator 

kubectl apply -f minio/minio_storageClass.yaml

kubectl apply -f minio/storage_drives.yaml

echo "deploy tenant now"
# still to test this clause
#kubectl apply -f minio/minio_tenant.yaml --namespace=minio-tenant




