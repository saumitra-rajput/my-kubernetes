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


## replicasets.yml

- kubectl apply -f replicaset.yml
- kubectl get pods -n nginx
- kubectl get replicaset -n nginx


## daemonsets.yml

- kubectl apply -f daemonset.yml
- kubectl get pods -n nginx
- kubectl get pods -n nginx -o wide # you will see your each work node has one pod daemonsets ensure that each node has a pod and equally distributed DaemonSet → one pod on every node and it do not scale replicas like deploymentsets
- kubectl delete -f daemonset.yml
- kubectl get pods -n nginx -o wide


## job.yml

- kubectl apply -f job.yml
- kubectl get pods -n nginx
- kubectl logs pods/job-xdg8r -n nginx # see the job messages with the pod specific name
- kubectl get pods -n nginx
- kubectl delete -f job.yml


## cronjob.yml

- kubectl apply -f cronjob.yml
- kubectl get cronjob -n nginx
- kubectl logs pod/minute-backup-29569647-z7glk -n nginx
- kubectl get pods -n nginx
- kubectl delete -f cronjob.yml
- kubectl get pods -n nginx


## persistentVolume.yml

- kubectl apply -f persistentVolume.yml
- kubectl get pv  # you noticed it's free not mapped with ns nginx and Status is available


## persistentVolumeClaim.yml

- kubectl get pv # check the pv status is available
- kubectl apply -f persistentVolumeClaim.yml 
- kubectl get pv # after apply you have claim it status changed to bound
- kubectl get pvc # check your pvc 




