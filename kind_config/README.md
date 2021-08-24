# Experimenting with Kind

## Notes

kind doesn't support gpu at this stage
kind doesn't support updating cluster in place and likely won't ever


useful commands:

```{bash}

# get cluster list
kind get clusters

# setup the kubeconfig for kubectl
## Name is optional will default to the generic kind cluster
kind export kubeconfig --name <xxxx>

# loading an image into the docker registery
kind load docker-image my-custom-image-0

```
