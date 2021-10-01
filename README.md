# linkerd-installation

[Generating your own mTLS root certificates | Linkerd](https://linkerd.io/2.10/tasks/generate-certificates/)

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

```fish
yq e .identity.issuer.crtExpiry=(cat linkerd2/issuer.crt | \
openssl x509 -noout -dates | rg "notAfter" | sed -e 's/notAfter=\(.*\)$/"\1"/' | \
TZ='GMT' xargs -I{} date -d {} +"\"%Y-%m-%dT%H:%M:%SZ\"") -i linkerd2/crtexpiry.yaml
```

You may not like unrelated diffs by yq, then use `git add -p` or edit `identity.issuer.crtExpiry` manually from the first.

[Installing Linkerd with Helm | Linkerd](https://linkerd.io/2.10/tasks/install-helm/)

[roboll/helmfile: Deploy Kubernetes Helm Charts](https://github.com/roboll/helmfile)

```
helmfile -f helmfile.yaml apply
```

[Getting Started | Linkerd](https://linkerd.io/2.10/getting-started/)

demo app

```
curl -sL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -
```

```
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```
