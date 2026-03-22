# Basic commands

## config.ym
 
- kind create cluster --name=jarvis --config=config.yml # create cluster using config.yml and define it's name
- kubectl cluster-info --context kind-jarvis # to see the cluster info with context kind-clustername(jarvis)
- kubectl get nodes # to see the nodes
- kind get clusters # to see the name of your cluster
- kind delete cluster --name=nameofyourcluster # delete the cluster with the namespecified

