#!/bin/bash

MINIO_SPACE=minio-tenant

## Create folders for minio
make_dir() {
    if [[ ! -e $1 ]]; then
        mkdir -p $1
    elif [[ ! -d $1 ]]; then
        echo "$1 already exists but is not a directory" 1>&2
    fi
}

COMMON_STORE='/opt/data/common-storage'
MINIO_DRIVE1='/opt/data/minio/drive1'
MINIO_DRIVE2='/opt/data/minio/drive2'
MINIO_DRIVE3='/opt/data/minio/drive3'
MINIO_DRIVE4='/opt/data/minio/drive4'

for FOLDER_PATH in $COMMON_STORE $MINIO_DRIVE1 $MINIO_DRIVE2 $MINIO_DRIVE3 $MINIO_DRIVE4
do
    make_dir $FOLDER_PATH
done

### Now that the folders we need are created, start the kube process
kubectl create namespace ${MINIO_SPACE}

echo "this requires installing minio operator plugin first and ensuring it is on path"
kubectl minio init

echo "Wait for Minio Operator to start"
kubectl wait --for=condition=available --timeout=600s deployment/minio-operator -n minio-operator 

kubectl apply -f minio/minio_storageClass.yaml

kubectl apply -f minio/storage_drives.yaml

echo "deploy tenant now"
# still to test this clause
kubectl apply -f minio/minio_tenant.yaml --namespace=minio-tenant

