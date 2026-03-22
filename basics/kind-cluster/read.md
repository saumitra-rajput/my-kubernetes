# Basic commands

## default

- kind create cluster --name=jarvis
- kind get clusters
- kubectl get nodes
- kubectl get namespace or kubectl get ns
- kubectl get pods -n kube-system(name-space)
- kind delete cluster --name jarvis

## config.ym
 
- kind create cluster --name=jarvis --config=config.yml # create cluster using config.yml and define it's name
- kubectl cluster-info --context kind-jarvis # to see the cluster info with context kind-clustername(jarvis)
- kubectl get nodes # to see the nodes
- kind get clusters # to see the name of your cluster
- kind delete cluster --name=nameofyourcluster # delete the cluster with the namespecified

