#!/bin/bash

## Kube dashboard version to deploy
DASHBOARD_VERSION='v2.3.1'

DASHBOARD_URL=https://raw.githubusercontent.com/kubernetes/dashboard/${DASHBOARD_VERSION}/aio/deploy/recommended.yaml

curl ${DASHBOARD_URL} > kube_dashboard/dashboard_deploy.yaml

if grep -Fxq "404: Not Found" kube_dashboard/dashboard_deploy.yaml
then
    echo "error cannot download kubernetes dashboard apply - check url"
    echo ${DASHBOARD_URL}
else
    kubectl apply -f kube_dashboard/dashboard_deploy.yaml
    kubectl apply -f kube_dashboard/dashboard-admin.yaml
fi

echo "Wait for Kube Dashboard to start"
kubectl wait --for=condition=available --timeout=600s deployment/kubernetes-dashboard -n kubernetes-dashboard

echo "Done"
#if curl  > kube_dashboard/dashboard_deploy.yaml
#then 
#else echo "Failed to download dashboard deployment script"
#fi
