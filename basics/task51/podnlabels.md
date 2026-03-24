# Kubernetes Notes — Pod Management & Labels

---

## 1. Running Pods

Create a pod directly using `kubectl run`:

- `kubectl run redis-pod --image=redis:latest`
- `kubectl run test-pod --image=nginx:latest --dry-run=client -o yaml`

---

## 2. Inspecting Pods

View pod details in different formats:

- `kubectl get pods`
- `kubectl get pods -A`
- `kubectl get pod/redis-pod -o wide`
- `kubectl get pod/redis-pod -o yaml`

---

## 3. Dry Run — Imperative (`kubectl run`)

Test pod creation without applying, and optionally save the output to a YAML file:

- `kubectl run test-pod --image=nginx:latest --dry-run=client -o yaml`
- `kubectl run test-pod --image=nginx:latest --dry-run=client -o yaml > dryrun.yml`

---

## 4. Dry Run — Declarative (`kubectl apply`)

Validate a YAML manifest before applying it, either client-side or server-side:

- `kubectl apply -f pod.yml --dry-run=client`
- `kubectl apply -f pod.yml --dry-run=server`

---

## 5. Applying Manifests

Deploy resources from YAML files:

- `kubectl apply -f pod.yml`
- `kubectl apply -f pod3.yml`

---

## 6. Labels — Viewing

List pods along with their labels, or filter by a specific label:

- `kubectl get pods --show-labels`
- `kubectl get pods -l app=nginx`
- `kubectl get pods -l environment=dev`
- `kubectl get pod -l env=prod`

---

## 7. Labels — Adding & Updating

Add a new label or overwrite an existing one on a pod:

- `kubectl label pod nginx-pod environment=production`
- `kubectl label pod pod-three env=dev --overwrite`
- `kubectl label pod/pod-three team=devops`
- `kubectl label pod pod-three role=senior`

---

## 8. Labels — Removing

Remove a label from a pod using the `-` suffix:

- `kubectl label pod nginx-pod environment-`
- `kubectl label pod/pod-three team-`

---

## 9. Deleting Resources

Remove pods using manifest files or by pod name:

- `kubectl delete -f pod.yml`
- `kubectl delete -f pod3.yml`
- `kubectl delete -f busybox.yml`
- `kubectl delete pod/nginx-pod`
- `kubectl delete pod/redis-pod`

