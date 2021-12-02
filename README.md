# Custom ArgoCD Repo Server image for OTP

As part of the One Touch Provisioning asset, we leverage a custom argocd repo server to enable the use of Policy Generator within OpenShift GitOps.

To build the Docker image, you must first be logged into your OpenShift Cluster as it pulls the image location of the OpenShift GitOps Operator that is running. This image will change each time the Operator is updated.

At the moment, this will require a manual build each time a new version is released, the aim is to automate this in the future.

## Image Registry

The current image is pushed to : quay.io/benswinneyau/openshift-gitops-repo-server:latest

## Build

Execute build.sh
