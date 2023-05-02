# argocd

## Multi-arch build

```sh
export REGISTRY=...
export REG_USER=...
export REG_PWD=...
VERSION=v2.7.0
podman login --username $REG_USER --password $REG_PWD $REGISTRY
podman build --platform linux/arm64/v8 -t $REGISTRY/$REG_USER/argocd:$VERSION-arm64 --build-arg ARCH=arm64 .
podman push $REGISTRY/$REG_USER/argocd:$VERSION-arm64
podman build --platform linux/amd64 -t $REGISTRY/$REG_USER/argocd:$VERSION-amd64 --build-arg ARCH=amd64 .
podman push $REGISTRY/$REG_USER/argocd:$VERSION-amd64
podman manifest create $REGISTRY/$REG_USER/argocd:$VERSION \
  --amend $REGISTRY/$REG_USER/argocd:$VERSION-amd64 \
  --amend $REGISTRY/$REG_USER/argocd:$VERSION-arm64
podman push $REGISTRY/$REG_USER/argocd:$VERSION
podman manifest inspect --verbose $REGISTRY/$REG_USER/argocd:$VERSION
```
