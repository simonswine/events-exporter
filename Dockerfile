FROM alpine:3.7

RUN apk --update add curl jq

ENV KUBECTL_VERSION=1.10.2
ENV KUBECTL_HASH=524766fa2b88d64cff3276f4284107519f3cdd233692f08935aafa03b570f3ea

RUN curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
 && echo "524766fa2b88d64cff3276f4284107519f3cdd233692f08935aafa03b570f3ea  /usr/local/bin/kubectl" | sha256sum -c \
 && chmod +x /usr/local/bin/kubectl

USER nobody

# This will log an kubernetes event per line in json format
CMD ["/bin/sh", "-c", "kubectl get events --all-namespaces --watch-only -o json | jq -c -M ."]
