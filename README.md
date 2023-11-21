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

```shell
just apply-all
```

## Demo app

```shell
just emojivoto
```

## Dashboard

```shell
linkerd viz dashboard
```

or open `http://linkerd-viz.local:54321`

## [Dynamic Request Routing Tutorial](https://linkerd.io/2.14/tasks/configuring-dynamic-request-routing/)

```shell
just expect-backend-a
```

```shell
just expect-backend-b
```

---

cf.

- [Generating your own mTLS root certificates | Linkerd](https://linkerd.io/2.14/tasks/generate-certificates/)
- [Installing Linkerd with Helm | Linkerd](https://linkerd.io/2.14/tasks/install-helm/)
- [smallstep/cli: 🧰 A zero trust swiss army knife for working with X509, OAuth, JWT, OATH OTP, etc.](https://github.com/smallstep/cli)
- [helmfile/helmfile: Declaratively deploy your Kubernetes manifests, Kustomize configs, and Charts as Helm releases. Generate all-in-one manifests for use with ArgoCD.](https://github.com/helmfile/helmfile)
- [casey/just: 🤖 Just a command runner](https://github.com/casey/just)
