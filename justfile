# https://k3d.io/v5.5.2/usage/exposing_services/
create-cluster:
	k3d cluster create -p "8081:80@loadbalancer"

delete-cluster:
	k3d cluster delete

ca:
	step certificate create root.linkerd.cluster.local linkerd-control-plane/ca.crt linkerd-control-plane/ca.key \
	--profile root-ca --no-password --insecure

issuer:
	step certificate create identity.linkerd.cluster.local linkerd-control-plane/issuer.crt linkerd-control-plane/issuer.key \
	--profile intermediate-ca --not-after 8760h --no-password --insecure \
	--ca linkerd-control-plane/ca.crt --ca-key linkerd-control-plane/ca.key

emojivoto:
	kubectl apply -f https://run.linkerd.io/emojivoto.yml && \
	kubectl annotate ns emojivoto linkerd.io/inject=enabled && \
	kubectl apply -f emojivoto/ingress.yaml && \
	kubectl rollout restart deploy -n emojivoto

apply-all:
	helmfile -f helmfile.yaml apply

diff-all:
	helmfile -f helmfile.yaml diff

destroy-all:
	helmfile -f helmfile.yaml destroy

template-all:
	helmfile -f helmfile.yaml template

apply NAME:
	helmfile -f helmfile.yaml apply --selector name={{ NAME }}

diff NAME:
	helmfile -f helmfile.yaml diff --selector name={{ NAME }}

destroy NAME:
	helmfile -f helmfile.yaml destroy --selector name={{ NAME }}

template NAME:
	helmfile -f helmfile.yaml template --selector name={{ NAME }}
