# Kubernetes — Ingress Setup with Kind Cluster

---

## 1. Create Kind Cluster

- `cd ~/my-kubernetes/basics/kind-cluster/`
- `kind create cluster --name jarvis --config=config.yml`

---

## 2. Apply Namespace, Service & Deployment

```bash
# Navigate to k8s directory
cd ~/flask-app/my-docker/projects/flask-db/k8s/
```

- `kubectl apply -f namespace.yml`
- `kubectl apply -f namespace.yml -f service.yml -f deployment.yml`

---

## 3. Apply Ingress

- `kubectl apply -f ingress.yml`

---

## 4. Install NGINX Ingress Controller

- `kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/cloud/deploy.yaml`

---

## 5. Verify Everything

```bash
# Check all resources in nginx namespace
kubectl get all -n nginx

# Check services
kubectl get service -n nginx
kubectl get service -n ingress-nginx

# Check ingress
kubectl get ingress -n nginx
kubectl get ingress -n ingress-nginx

# Describe a pod if needed
kubectl describe pod/<pod-name> -n nginx
```

---

## 6. Persistent Volume (if needed)

```bash
# Navigate to kind-cluster directory
cd ~/my-kubernetes/basics/kind-cluster/
```

- `kubectl apply -f persistentVolume.yml -f persistentVolumeClaim.yml`
- `kubectl apply -f deployment.yml`

---

## 7. Port Forward — Ingress Controller

- `kubectl port-forward service/ingress-nginx-controller 8080:80 -n ingress-nginx`

Then test in browser or curl:

```bash
curl http://localhost:8080/flask
curl http://localhost:8080/nginx
```

---

## 8. Verify Pods

- `kubectl get pods -n nginx`
- `kubectl get pods -n ingress-nginx`

---

## 9. Clean Up

### Delete Specific Resources

```bash
# Delete ingress
kubectl delete -f ingress.yml

# Delete deployments and services
kubectl delete -f namespace.yml -f service.yml -f deployment.yml

# Delete persistent volumes
kubectl delete -f persistentVolume.yml -f persistentVolumeClaim.yml
```

### Delete Ingress Controller

```bash
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/cloud/deploy.yaml
```

### Delete Entire Cluster

```bash
# This deletes everything at once
kind delete cluster --name jarvis
```

---

> 💡 **Tip:** `kind delete cluster --name jarvis` removes the entire cluster and all resources inside it in one command.
