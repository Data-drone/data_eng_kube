# Quick Hacks

With Kind GPU isn't supported

## Setup Systems and Admin tools

We need to create a kubernetes dashboard and metallb.
- kubernetes dashboard for seeing the status of the kube system
- Metallb is to allow for local server to have LoadBalancers
- kubectl for working with kubernetes


## Creating a kube user for accessing kube dashboard

See `admin`

```{bash}

kubectl apply -f dashboard-admin.yaml

kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

```

### Proxying Connections with kubectl

-- kubectl proxying ingress to access endpoints

```bash

kubectl proxy --port 8011

```

After setting up dashboard as per kubernetes docs (installed 2.3.1 in this case)

use url
http://127.0.0.1:8011/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

port 8011 was set via the `kubectl proxy`

### Metallb

See: https://kind.sigs.k8s.io/docs/user/loadbalancer/

Need to edit `admin/metallb-config-map.yaml` so that ip matches what get from metallb

```{bash}

docker network inspect -f '{{.IPAM.Config}}' kind

```

### Starting a Jupyterhub

See: https://zero-to-jupyterhub.readthedocs.io/en/latest/jupyterhub/installation.html

```{bash}

# release name is test1
# namespace was custom
# version is custom
helm upgrade --cleanup-on-fail \
  --install test1 jupyterhub/jupyterhub \
  --namespace jhub \
  --create-namespace \
  --version=1 \
  --values config.yaml

```