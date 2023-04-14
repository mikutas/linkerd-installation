cluster:
	k3d cluster create -p "8081:80@loadbalancer"

ca:
	step certificate create root.linkerd.cluster.local linkerd-control-plane/ca.crt linkerd-control-plane/ca.key \
	--profile root-ca --no-password --insecure

issuer:
	step certificate create identity.linkerd.cluster.local linkerd-control-plane/issuer.crt linkerd-control-plane/issuer.key \
	--profile intermediate-ca --not-after 8760h --no-password --insecure \
	--ca linkerd-control-plane/ca.crt --ca-key linkerd-control-plane/ca.key

linkerd:
	helmfile -f helmfile.yaml apply

emojivoto:
	kubectl apply -f https://run.linkerd.io/emojivoto.yml && \
	kubectl annotate ns emojivoto linkerd.io/inject=enabled && \
	kubectl rollout restart deploy -n emojivoto

dashboard:
	linkerd viz dashboard

destroy:
	k3d cluster delete
