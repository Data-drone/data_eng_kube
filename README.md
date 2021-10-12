# Build a Data Platform on k8s

Building out a full ML Platform on k8s

## Tools used

- Kind
- k3d
    For k3d setting up kubeconfig see:
    https://k3d.io/usage/kubeconfig/


    ```{bash}

    # k3d quick test
    export CLUSTER_NAME=cputest && k3d cluster create $CLUSTER_NAME

    # k3d quick gpu test
    export CLUSTER_NAME=gputest && k3d cluster create $CLUSTER_NAME \
    --image=datadrone/k3d-gpu:v1.21.3-k3s1-cuda-11-2 --gpus=all

    kubectl apply -f cluster_host_images/k3d_cuda_image/cuda-vector-add.yaml

    # k3d setup with yaml - 5.0 - Also display the default local path provisioner
    k3d cluster create data-platform \
    --k3s-arg "--disable=local-storage@server:* \
    --config k3d_config/data_eng_cluster_v2.yaml

    # if we need to update kubeconfig later
    k3d kubeconfig merge test --kubeconfig-merge-default 

    ```
## Stack

- Jupyterhub for data science
- k3d traefik replaced with traefik v2
- Metallb for local load balancer
- Minio for Cloud storage
  - Needs 4 nodes by current config

- Processing Frameworks:
  - Spark
    - via Jupyter

- Processing Frameworks to test:
  - Dask
    - try using `KubeCluster` method for adhoc compute 
  - Ray
    - https://docs.ray.io/en/master/cluster/kubernetes.html#ray-operator
  - Seldon
    - https://docs.seldon.io/projects/seldon-core/en/latest/workflow/install.html

## Notes

- Seldon requires `Istio` or `Ambassador` Ingress