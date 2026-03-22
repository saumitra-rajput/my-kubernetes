# Basic commands

## default

- kind create cluster --name=jarvis
- kind get clusters
- kubectl get nodes
- kubectl get namespace or kubectl get ns
- kubectl get pods -n kube-system(name-space)
- kind delete cluster --name jarvis

  pods (Ensure you have one cluster running)
- kubectl cluster-info
- kubectl run nginx --image=nginx:latest # this will create nginx pod using latest image note you still need to do port mapping to see the webpage
- kubectl delete pod nginx

  namespace
- kubectl create ns nginx
- kubectl get namespace or kubectl get ns 
- kubectl run nginx -n nginx
- kubectl get pods # no output because your pod is mapped with the ns nginx
- kubectl get pods -n nginx # you'll see the ouput

## config.yml
 
- kind create cluster --name=jarvis --config=config.yml # create cluster using config.yml and define it's name
- kubectl cluster-info --context kind-jarvis # to see the cluster info with context kind-clustername(jarvis)
- kubectl get nodes # to see the nodes
- kind get clusters # to see the name of your cluster
- kind delete cluster --name=nameofyourcluster # delete the cluster with the namespecified


## namespace.yml
- kubectl get ns # shows default ns
- kubectl apply -f ns.yml (manifest file name)
- kubectl get ns # you see you ns is created.


## pod.yml
- kubectl get pods
- kubectl apply -f pod.yml
- kubectl get pods # show default pods
- kubectl get pods -n nginx # show ns nginx mapped pods
- kubectl exec -it pod/nginx-pod -n nginx -- bash # to get inside the pod
- kubectl describe pod/nginx-pod -n nginx # show the details about the pod which ns is nginx
- kubectl delete pod nginx-pod -n nginx
- kubectl delete -f pod.yml # this will delete the pod via yml manifest file


## deployment.yml

- kubectl apply -f deployment.yml
- kubectl get deployment -n nginx
- kubectl get pods -n nginx
- kubectl scale deployment/nginx-deploy -n nginx --replicas=3
- kubectl get pods -n nginx

scaling option

- kubectl scale deployment/nginx-deploy -n nginx --replicas=5
- kubectl get pods -n nginx
- kubectl scale deployment/nginx-deploy -n nginx --replicas=1
- kubectl get pods -n nginx
- kubectl get pods -n nginx -o wide # shows the more detailed output of pods

image set

- kubectl set image deployment/nginx-deply -n nginx nginx=nginx:alpine

- kubectl delete -f deployment.yml # delete the deployment


