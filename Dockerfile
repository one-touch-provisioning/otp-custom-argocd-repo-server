FROM registry.redhat.io/openshift-gitops-1/argocd-rhel8:v1.4.2
ENV KUSTOMIZE_PLUGIN_HOME=/etc/kustomize/plugin     POLICY_GENERATOR_VERSION=v1.4.1
USER 0
RUN mkdir -p /policy.open-cluster-management.io/v1/policygenerator &&     curl -L       -o /policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator       https://github.com/open-cluster-management/policy-generator-plugin/releases/download//linux-amd64-PolicyGenerator &&     chmod +x /policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator
USER argocd
