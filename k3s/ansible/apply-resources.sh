vagrant scp master-1:~/k3s.yaml ~/.kube/config
kubectl apply -f ./apps/components.yaml