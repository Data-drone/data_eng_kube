# Spark on K8s

Testing out spark clusters on kubernetes

## Tools used

- Kind
- k3d
  - Check: https://github.com/kf5i/k3ai as well

## Stack

- Jupyterhub for data science
- Minio for Cloud storage
  - Needs 4 nodes by default config

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
- k3d comes with Traefik but an outdated one
