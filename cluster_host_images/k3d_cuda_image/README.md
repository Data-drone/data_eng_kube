# Cuda based image fo k3d

See: https://k3d.io/usage/guides/cuda/

Updated the daemonset yaml to the one from:
https://github.com/NVIDIA/k8s-device-plugin/blob/master/nvidia-device-plugin.yml

## docker build command

```{bash}

docker build --build-arg NVIDIA_CONTAINER_RUNTIME_VERSION=3.5.0-1 -t datadrone/k3d-gpu:latest .

```