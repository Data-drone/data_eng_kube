#!/bin/bash

set -euxo pipefail

K3S_TAG=${K3S_TAG:="v1.21.3-k3s1"} # replace + with -, if needed
IMAGE_REGISTRY=${IMAGE_REGISTRY:="docker.io"} # MY_REGISTRY
IMAGE_REPOSITORY=${IMAGE_REPOSITORY:="datadrone/k3d-gpu"} # rancher/k3s
IMAGE_TAG="$K3S_TAG-cuda-11-2"
CUDA_TAG=${CUDA_TAG:="11.2.0-base-ubuntu18.04"}
IMAGE=${IMAGE:="$IMAGE_REGISTRY/$IMAGE_REPOSITORY:$IMAGE_TAG"}

NVIDIA_CONTAINER_RUNTIME_VERSION=${NVIDIA_CONTAINER_RUNTIME_VERSION:="3.5.0-1"}

echo "IMAGE=$IMAGE"

# due to some unknown reason, copying symlinks fails with buildkit enabled
DOCKER_BUILDKIT=0 docker build \
  --build-arg K3S_TAG=$K3S_TAG \
  --build-arg NVIDIA_CONTAINER_RUNTIME_VERSION=$NVIDIA_CONTAINER_RUNTIME_VERSION \
  --build-arg CUDA_TAG=$CUDA_TAG \
  -t $IMAGE .
docker push $IMAGE
echo "Done!"