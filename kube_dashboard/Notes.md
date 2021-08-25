Steps:
- deploy the dashboard
```{bash}

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.3.1/aio/deploy/recommended.yaml


```

- add the cluster user

- get the token
- run kubeectl proxy for access
- use token for access

https://upcloud.com/community/tutorials/deploy-kubernetes-dashboard/


Getting the token

```{bash}

# one way
kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

## another way
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'

```