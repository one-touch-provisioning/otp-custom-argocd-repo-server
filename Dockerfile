FROM registry.redhat.io/openshift-gitops-1/argocd-rhel8:v1.5.3

ENV KUSTOMIZE_PLUGIN_HOME=/etc/kustomize/plugin

USER 0
RUN mkdir -p /etc/kustomize/plugin/policy.open-cluster-management.io/v1/policygenerator &&     curl -L       -o /etc/kustomize/plugin/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator       https://github.com/open-cluster-management/policy-generator-plugin/releases/download/v1.7.0/linux-amd64-PolicyGenerator &&     chmod +x /etc/kustomize/plugin/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator
USER 999 
