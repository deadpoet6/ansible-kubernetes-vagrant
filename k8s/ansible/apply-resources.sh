vagrant scp master:~/.kube/config ~/.kube/
kubectl apply -f ./apps/components.yaml

## apply keycloak operator ##

kubectl create ns keycloak
kubectl config set-context --current --namespace=keycloak
kubectl apply -f ./apps/keycloak-operator/deploy/cluster_roles/
kubectl apply -f ./apps/keycloak-operator/deploy/crds/
kubectl apply -f ./apps/keycloak-operator/deploy/role.yaml
kubectl apply -f ./apps/keycloak-operator/deploy/role_binding.yaml
kubectl apply -f ./apps/keycloak-operator/deploy/service_account.yaml
kubectl apply -f ./apps/keycloak-operator/deploy/operator.yaml
sleep 30s
kubectl apply -f ./apps/keycloak-operator/deploy/examples/keycloak/keycloak.yaml