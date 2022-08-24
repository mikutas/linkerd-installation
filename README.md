# linkerd-installation

## Generating certificates

```sh
step certificate create root.linkerd.cluster.local linkerd-control-plane/ca.crt linkerd-control-plane/ca.key \
--profile root-ca --no-password --insecure
```

```sh
step certificate create identity.linkerd.cluster.local linkerd-control-plane/issuer.crt linkerd-control-plane/issuer.key \
--profile intermediate-ca --not-after 8760h --no-password --insecure \
--ca linkerd-control-plane/ca.crt --ca-key linkerd-control-plane/ca.key
```

## Install

```
helmfile -f helmfile.yaml apply
```

## Demo app

```
kubectl apply -f https://run.linkerd.io/emojivoto.yml
```

```
kubectl annotate ns emojivoto linkerd.io/inject=enabled
```

```
kubectl rollout restart deploy -n emojivoto
```

## Dashboard

```
linkerd viz dashboard
```

---

cf.

- [Generating your own mTLS root certificates | Linkerd](https://linkerd.io/2.12/tasks/generate-certificates/)
- [Installing Linkerd with Helm | Linkerd](https://linkerd.io/2.12/tasks/install-helm/)
- [roboll/helmfile: Deploy Kubernetes Helm Charts](https://github.com/roboll/helmfile)
- [Getting Started | Linkerd](https://linkerd.io/2.12/getting-started/)
