# linkerd-installation

## Generating certificates

example by fish

```fish
step certificate create root.linkerd.cluster.local linkerd2/ca.crt linkerd2/ca.key \
--profile root-ca --no-password --insecure
```

```fish
step certificate create identity.linkerd.cluster.local linkerd2/issuer.crt linkerd2/issuer.key \
--profile intermediate-ca --not-after 8760h --no-password --insecure \
--ca linkerd2/ca.crt --ca-key linkerd2/ca.key
```

## Install

```
helmfile -f helmfile.yaml apply
```

## Demo app

```
curl -sL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -
```

```
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```

## Dashboard

```
linkerd viz dashboard
```

---

cf.

- [Generating your own mTLS root certificates | Linkerd](https://linkerd.io/2.11/tasks/generate-certificates/)
- [Installing Linkerd with Helm | Linkerd](https://linkerd.io/2.11/tasks/install-helm/)
- [roboll/helmfile: Deploy Kubernetes Helm Charts](https://github.com/roboll/helmfile)
- [Getting Started | Linkerd](https://linkerd.io/2.11/getting-started/)
