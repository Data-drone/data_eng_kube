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
Chaging the `config.yaml` doesn't require updating the version?


```{bash}

helm upgrade --cleanup-on-fail \
  test1 jupyterhub/jupyterhub \
  --namespace jhub \
  --version=1 \
  --values config.yaml

```

# TODO

Current Issues:

- Nvidia images seem to be having issues
  - Maybe issues with moving /var/lib/docker
  - Maybe issue with installed jhub version (versions must align)
  - Doesn't seem to be an issue with kubeflow?

- Default Jhub includes klipper-lb can we replace with metallb?

- Should we look into making is possible to setup custom conda envs as per the guide?

- Registry port for k3d is random at the moment we need to try and automate this so that we don't need to update the docker port all the time