#!/bin/bash

# Get Image location
IMAGE=`oc get -n openshift-gitops deployment openshift-gitops-cntk-repo-server -o=jsonpath='{@.spec.template.spec.containers[0].image}'`

# Build Dockerfile
echo "Building Dockerfile"

cat <<EOF > Dockerfile
FROM $IMAGE
ENV KUSTOMIZE_PLUGIN_HOME=/etc/kustomize/plugin \
    POLICY_GENERATOR_VERSION=v1.2.2
USER 0
RUN mkdir -p $KUSTOMIZE_PLUGIN_HOME/policy.open-cluster-management.io/v1/policygenerator && \
    curl -L \
      -o $KUSTOMIZE_PLUGIN_HOME/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator \
      https://github.com/open-cluster-management/policy-generator-plugin/releases/download/$POLICY_GENERATOR_VERSION/linux-amd64-PolicyGenerator && \
    chmod +x $KUSTOMIZE_PLUGIN_HOME/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator
USER argocd
EOF

# Build Image
echo "Building Image"
podman build -f Dockerfile --no-cache -t quay.io/benswinneyau/openshift-gitops-repo-server:latest .

# Push Image
echo "Pushing image to registry"
podman push quay.io/benswinneyau/openshift-gitops-repo-server:latest

echo "Build and Push Complete"

exit 0