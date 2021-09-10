# Spark on K8s

Testing out spark clusters on kubernetes

## Tools used

- Kind
- k3d
  - Check: https://github.com/kf5i/k3ai as well

    Startup with a Registry and an ingress port

    For k3d setting up kubeconfig see:
    https://k3d.io/usage/kubeconfig/


    ```{bash}

    # k3d setup with yaml
    export CLUSTER_NAME=test && k3d cluster create $CLUSTER_NAME \
    --config k3d_config/data_eng_cluster.yaml 

    # registry.gitlab.com/vainkop1/k3s-gpu:v1.21.2-k3s1
    export CLUSTER_NAME=test && k3d cluster create $CLUSTER_NAME \
    --image=datadrone/k3d-gpu:latest \
    -p "8081:80@loadbalancer" \
    --gpus=all --registry-create \
    --kubeconfig-update-default

    # if we need to update kubeconfig later
    k3d kubeconfig merge test --kubeconfig-merge-default 

    ```

  Checking k3d ingress:
  - Build k3d with the node count we need for Minio with traefik

  ```{bash}

  export CLUSTER_NAME=test && \
  k3d cluster create $CLUSTER_NAME \
    --config k3d_config/data_eng_cluster.yaml

  ```
## Stack

- Jupyterhub for data science
- k3d traefik replaced with traefik v2
- Metallb for local load balancer
- Minio for Cloud storage
  - Needs 4 nodes by current config

- Processing Frameworks to test:
  - Dask
    - try using `KubeCluster` method for adhoc compute 
  - Ray
    - https://docs.ray.io/en/master/cluster/kubernetes.html#ray-operator
  - Spark
    - Can test this one too: https://github.com/radanalyticsio/spark-operator
  - Seldon
    - https://docs.seldon.io/projects/seldon-core/en/latest/workflow/install.html

## Notes

- Seldon requires `Istio` or `Ambassador` Ingress