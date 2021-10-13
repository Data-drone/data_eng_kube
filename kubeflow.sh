#!/bin/bash

#kubectl apply -f kubeflow/create-pvs.yaml

# this is installing pipelines only

#export PIPELINE_VERSION=1.7.0
#kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
#kubectl wait --for condition=established --timeout=60s crd/applications.app.k8s.io
#kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/env/platform-agnostic-pns?ref=$PIPELINE_VERSION"

### new test
kustomize build kubeflow/manifests/common/cert-manager/cert-manager/base | kubectl apply -f -
kustomize build kubeflow/manifests/common/cert-manager/kubeflow-issuer/base | kubectl apply -f -

kustomize build kubeflow/manifests/common/istio-1-9/istio-crds/base | kubectl apply -f -
kustomize build kubeflow/manifests/common/istio-1-9/istio-namespace/base | kubectl apply -f -
kustomize build kubeflow/manifests/common/istio-1-9/istio-install/base | kubectl apply -f -

kustomize build kubeflow/manifests/common/dex/overlays/istio | kubectl apply -f -

kustomize build kubeflow/manifests/common/oidc-authservice/base | kubectl apply -f -

##### issue at this step - ## error: unable to recognize "STDIN": no matches for kind "Image" in version "caching.internal.knative.dev/v1alpha1"
kustomize build kubeflow/manifests/common/knative/knative-serving/base | kubectl apply -f -

kustomize build kubeflow/manifests/common/istio-1-9/cluster-local-gateway/base | kubectl apply -f -

#### Optional
kustomize build kubeflow/manifests/common/knative/knative-eventing/base | kubectl apply -f -

###### Start of Kubeflow parts ###### - Rest is infra components

kustomize build kubeflow/manifests/common/kubeflow-namespace/base | kubectl apply -f -

kustomize build kubeflow/manifests/common/kubeflow-roles/base | kubectl apply -f -

kustomize build kubeflow/manifests/common/istio-1-9/kubeflow-istio-resources/base | kubectl apply -f -

#### Error Here with error: unable to recognize "STDIN": no matches for kind "CompositeController" in version "metacontroller.k8s.io/v1alpha1"
kustomize build kubeflow/manifests/apps/pipeline/upstream/env/platform-agnostic-multi-user | kubectl apply -f -

kustomize build kubeflow/manifests/apps/kfserving/upstream/overlays/kubeflow | kubectl apply -f -

kustomize build kubeflow/manifests/apps/katib/upstream/installs/katib-with-kubeflow | kubectl apply -f -

kustomize build kubeflow/manifests/apps/centraldashboard/upstream/overlays/istio | kubectl apply -f -

kustomize build kubeflow/manifests/apps/admission-webhook/upstream/overlays/cert-manager | kubectl apply -f -

kustomize build kubeflow/manifests/apps/jupyter/notebook-controller/upstream/overlays/kubeflow | kubectl apply -f -
kustomize build kubeflow/manifests/apps/jupyter/jupyter-web-app/upstream/overlays/istio | kubectl apply -f -
kustomize build kubeflow/manifests/apps/profiles/upstream/overlays/kubeflow | kubectl apply -f -
kustomize build kubeflow/manifests/apps/volumes-web-app/upstream/overlays/istio | kubectl apply -f -
kustomize build kubeflow/manifests/apps/tensorboard/tensorboards-web-app/upstream/overlays/istio | kubectl apply -f -
kustomize build kubeflow/manifests/apps/tensorboard/tensorboard-controller/upstream/overlays/kubeflow | kubectl apply -f -
kustomize build kubeflow/manifests/apps/training-operator/upstream/overlays/kubeflow | kubectl apply -f -
kustomize build kubeflow/manifests/apps/mpi-job/upstream/overlays/kubeflow | kubectl apply -f -
kustomize build kubeflow/manifests/common/user-namespace/base | kubectl apply -f -