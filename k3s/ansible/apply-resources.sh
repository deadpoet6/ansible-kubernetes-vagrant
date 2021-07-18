vagrant scp master-1:~/k3s.yaml ~/.kube/config
kubectl apply -f ./apps/components.yaml
kubectl create ns keycloak
kubectl config set-context --current --namespace=keycloak
kubectl apply -f ./apps/postgres/manifest.yaml
sleep 60s
kubectl apply -f ./apps/keycloak/manifest.yaml
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml