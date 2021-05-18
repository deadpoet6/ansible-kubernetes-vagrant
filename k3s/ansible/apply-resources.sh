vagrant scp master-1:/etc/rancher/k3s/k3s.yaml ~/.kube/config
kubectl apply -f ./apps/components.yaml