# argocd

## Multi-arch build

```sh
export REGISTRY=...
export REG_USER=...
export REG_PWD=...
❯ podman login --username $REG_USER --password $REG_PWD $REGISTRY
podman build -t $REGISTRY/$REG_USER/argocd:manifest-arm64 --build-arg ARCH=arm64 .
podman push $REGISTRY/$REG_USER/argocd:manifest-arm64
podman build -t $REGISTRY/$REG_USER/argocd:manifest-amd64 --build-arg ARCH=amd64 .
podman push $REGISTRY/$REG_USER/argocd:manifest-amd64
podman manifest create $REGISTRY/$REG_USER/argocd:manifest-latest \
  --amend $REGISTRY/$REG_USER/argocd:manifest-amd64 \
  --amend $REGISTRY/$REG_USER/argocd:manifest-arm64
podman push $REGISTRY/$REG_USER/argocd:manifest-latest
```
