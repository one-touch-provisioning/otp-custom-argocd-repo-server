#!/bin/bash -x

# Get Image location
#IMAGE=`oc get -n openshift-gitops deployment openshift-gitops-cntk-repo-server -o=jsonpath='{@.spec.template.spec.containers[0].image}'`
IMAGE="registry.redhat.io/openshift-gitops-1/argocd-rhel8"
IMAGE_VER="v1.5.2"
POLICY_GENERATOR_VERSION="v1.7.0"

# Build Dockerfile
echo "Building Dockerfile"

cat <<EOF > Dockerfile
FROM $IMAGE:$IMAGE_VER

ENV KUSTOMIZE_PLUGIN_HOME=/etc/kustomize/plugin

USER 0
RUN mkdir -p /etc/kustomize/plugin/policy.open-cluster-management.io/v1/policygenerator && \
    curl -L \
      -o /etc/kustomize/plugin/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator \
      https://github.com/open-cluster-management/policy-generator-plugin/releases/download/$POLICY_GENERATOR_VERSION/linux-amd64-PolicyGenerator && \
    chmod +x /etc/kustomize/plugin/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator
USER 999 
EOF

# Build Image
echo "Building Image"
IMAGE_TAG="v1.5.2" # Tracks OpenShift GitOps version
podman build -f Dockerfile --no-cache -t quay.io/benswinneyau/openshift-gitops-repo-server:$IMAGE_TAG .

echo "Tag Image with latest"
podman tag quay.io/benswinneyau/openshift-gitops-repo-server:$IMAGE_TAG quay.io/benswinneyau/openshift-gitops-repo-server:latest

# Push Image
echo "Pushing image to registry"
podman push quay.io/benswinneyau/openshift-gitops-repo-server:$IMAGE_TAG
podman push quay.io/benswinneyau/openshift-gitops-repo-server:latest

echo "Build and Push Complete"

exit 0