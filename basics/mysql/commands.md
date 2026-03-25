# Kubernetes — StatefulSet with ConfigMap & Secrets

---

## 1. Apply StatefulSet

- `kubectl apply -f namespace.yml -f statefulset.yml`

---

## 2. Verify Resources

- `kubectl get all -n mysql`
- `kubectl get pods -n mysql`
- `kubectl get ns`

---

## 3. Watch Pods in Real Time

- `watch kubectl get all -n mysql`

> 💡 `watch` refreshes the output every 2 seconds — useful to monitor pod restarts live.

---

## 4. Describe a Pod

- `kubectl describe pod/mysql-statefulset-0 -n mysql`

---

## 5. Delete & Recreate StatefulSet

```bash
# Delete StatefulSet
kubectl delete -f statefulset.yml

# Recreate StatefulSet
kubectl apply -f statefulset.yml
```

---

## 6. Delete a Pod (StatefulSet recreates it)

- `kubectl delete pod mysql-statefulset-0 -n mysql`

> ⚠️ StatefulSet will automatically recreate the pod with the same name!

---

## 7. Access Pod via Shell

- `kubectl exec -it pod/mysql-statefulset-1 -n mysql -- bash`

---

## 8. ConfigMap & Secrets

### Generate a Base64 Encoded Password

- `echo -n "rootpass" | base64`

> 💡 Kubernetes Secrets store values in **base64 encoded** format.

### Apply ConfigMap, Secrets & StatefulSet Together

- `kubectl apply -f namespace.yml`
- `kubectl apply -f configMap.yml -f secrets.yml -f statefulset.yml`

---

## 9. Clean Up

### Delete Namespace (removes everything inside)
- `kubectl delete namespace/mysql`

### Verify Cleanup
- `kubectl get all -n mysql`
- `kubectl get ns`

---

## ConfigMap vs Secret

| Feature | ConfigMap | Secret |
|---|---|---|
| Stores | Non-sensitive config | Sensitive data |
| Example | DB name, host, port | Passwords, tokens |
| Encoding | Plain text | Base64 encoded |
| Use case | App configuration | Credentials |

---
