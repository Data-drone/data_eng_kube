# Quick Hacks

With Kind GPU isn't supported

#### TODO

check out how to manage large images with this setup

check out why the local provisioner keeps having issues?
it is affecting the CrunchyData Postgres Operator
## Setup Systems and Admin tools

We need to create a kubernetes dashboard and metallb.
- kubectl for working with kubernetes - setup first

Automated with sh scripts
- kubernetes dashboard for seeing the status of the kube system
- Metallb is to allow for local server to have LoadBalancers

## Proxying Connections with kubectl

-- kubectl proxying ingress to access endpoints

```bash
kubectl proxy --port 8011
```

After setting up dashboard as per kubernetes docs (installed 2.3.1 in this case)
use url
http://127.0.0.1:8011/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

port 8011 was set via the `kubectl proxy`

### Traefik

To setup Traefik v2 see: https://community.traefik.io/t/traefik-v2-helm-a-tour-of-the-traefik-2-helm-chart/6126
Dashboard URL after the the hostname requires `/dashboard/` trailing slash is important too

See also: https://traefik.io/blog/from-zero-to-hero-getting-started-with-k0s-and-traefik/

Enabling Traefik dashboard

```{bash}

kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9011:9000

```

then go to: http://127.0.0.1:9011/dashboard/#/

### Starting a Jupyterhub

TODO: Check up on the ingress topic a bit more maybe it's better to define an ingress config file rather than use the config.yaml flag?

Loading images into k3d;
```{bash}
k3d image -c test import datadrone/deeplearn_pytorch:cuda-11.1
```


See: https://zero-to-jupyterhub.readthedocs.io/en/latest/jupyterhub/installation.html

```{bash}

# release name is test1
# namespace was custom
# version is custom
helm upgrade --cleanup-on-fail \
  --install jhub1 jupyterhub/jupyterhub \
  --namespace jhub \
  --create-namespace \
  --version=1 \
  --values jupyterhub/config.yaml

```

- Jupyter hub with spark on k8s
 -See:  https://towardsdatascience.com/jupyter-notebook-spark-on-kubernetes-880af7e06351

### Minio

1) Operator
Follow docu as per: https://docs.min.io/minio/k8s/deployment/deploy-minio-operator.html#deploy-operator-kubernetes

2) Create the storage mount with `minio/storage_drives.yaml`

3) create the namespace for the tenant

```{bash}

kubectl create namespace minio-tenant-1

```

4) create the tenant

Note we need to have 4 drives per server

```{bash}

kubectl minio tenant create minio-tenant-1       \
  --servers                 1                    \
  --volumes                 4                   \
  --capacity                40G                 \
  --storage-class           local-storage    \
  --namespace               minio-tenant-1

```

5) Ingress to operator dashboard with proxy

```{bash}

#get token
kubectl minio proxy


```

### Adding Kubeflow

- it sets up it's own minio can we use the one we setup separately?
  - need to hack the pipelines config as per the AWS setup
