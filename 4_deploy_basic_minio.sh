#!/bin/bash

# create the storage class that we need
kubectl apply -f minio/minio_storageClass.yaml

#kubectl apply -f basic_minio/minio-pv.yaml

kubectl apply -k basic_minio/basic_minio


