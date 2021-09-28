## Notes on creating and versioning 

Initialise Jupyterhub:

```{bash}

helm upgrade --cleanup-on-fail \
  --install jhub1 jupyterhub/jupyterhub \
  --namespace jhub \
  --create-namespace \
  --version=1 \
  --values jupyterhub/config.yaml

```

Updating the Jupyterhub config:
Changing the `config.yaml` doesn't require updating the version?


```{bash}

helm upgrade --cleanup-on-fail \
  test1 jupyterhub/jupyterhub \
  --namespace jhub \
  --version=1 \
  --values jupyterhub/config.yaml

```

# Helm rollback and history list

```{bash}

helm rollback jupyterhub 1 --namespace jhub

helm history jupyterhub -n jhub

```


# TODO

Current Issues:

- Default Jhub includes klipper-lb can we replace with metallb?

- Registry port for k3d is random at the moment we need to try and automate this so that we don't need to update the docker port all the time
  - big images causes the helm chart to fail, tested large timeouts but no consistent success so far