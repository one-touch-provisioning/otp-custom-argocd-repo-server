FROM $(oc get -n openshift-gitops deployment openshift-gitops-cntk-repo-server -o=jsonpath='{@.spec.template.spec.containers[0].image}') 
ENV KUSTOMIZE_PLUGIN_HOME=/etc/kustomize/plugin \
    POLICY_GENERATOR_VERSION=v1.2.2
USER 0
RUN mkdir -p $KUSTOMIZE_PLUGIN_HOME/policy.open-cluster-management.io/v1/policygenerator && \
    curl -L \
      -o $KUSTOMIZE_PLUGIN_HOME/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator \
      https://github.com/open-cluster-management/policy-generator-plugin/releases/download/$POLICY_GENERATOR_VERSION/linux-amd64-PolicyGenerator && \
    chmod +x $KUSTOMIZE_PLUGIN_HOME/policy.open-cluster-management.io/v1/policygenerator/PolicyGenerator
USER argocd
