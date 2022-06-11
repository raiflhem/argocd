FROM argoproj/argocd:v2.3.4

ARG SOPS_VERSION="v3.7.3"
ARG HELM_SECRETS_VERSION="3.12.0"
ARG AGE_VERSION="v1.0.0"

USER root
COPY helm-wrapper.sh /usr/local/bin/
RUN apt-get update && \
    apt-get install -y \
    curl \
    gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -Lo /tmp/age.tar.gz https://github.com/FiloSottile/age/releases/download/${AGE_VERSION}/age-${AGE_VERSION}-linux-amd64.tar.gz && \
    tar -xvf /tmp/age.tar.gz && \
    mv age age/age* /usr/local/bin/ && \
    curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux && \
    chmod +x /usr/local/bin/sops && \
    cd /usr/local/bin && \
    mv helm helm.bin && \
    mv helm2 helm2.bin && \
    mv helm-wrapper.sh helm && \
    ln helm helm2 && \
    chmod +x helm helm2

USER argocd
RUN /usr/local/bin/helm.bin plugin install https://github.com/zendesk/helm-secrets --version ${HELM_SECRETS_VERSION}
ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
