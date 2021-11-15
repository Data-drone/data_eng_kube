#!/bin/bash

REGISTRY_PORT=5051

kubectl create namespace tensorboard

### Setup the docker

docker build -f tensorboard/docker/Dockerfile ./tensorboard/docker -t datadrone/tfio_tensorboard:latest
docker tag datadrone/tfio_tensorboard:latest localhost:$REGISTRY_PORT/datadrone/tfio_tensorboard:latest
docker push localhost:$REGISTRY_PORT/datadrone/tfio_tensorboard:latest

### apply the image
kubectl apply -f tensorboard/tensorboard_setup.yaml 

