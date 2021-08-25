# Cuda based image fo k3d

See: https://k3d.io/usage/guides/cuda/

## docker build command

```{bash}

docker build --build-arg NVIDIA_CONTAINER_RUNTIME_VERSION=3.5.0-1 -t datadrone/k3d-gpu:latest .

```