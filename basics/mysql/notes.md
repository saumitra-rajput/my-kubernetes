# Kubernetes — StatefulSet Notes

---

## What is a StatefulSet?

> **StatefulSet is used to manage stateful applications like databases where each pod needs a stable identity and persistent storage.**

---

## StatefulSet vs Deployment

| Feature | Deployment | StatefulSet |
|---|---|---|
| Pod names | Random (e.g. `pod-x7k2p`) | Ordered (e.g. `pod-0`, `pod-1`) |
| Pod identity | No stable identity | Stable, unique identity |
| Storage | Shared or no storage | Each pod gets its own storage |
| Use case | Stateless apps (nginx, flask) | Stateful apps (mysql, mongodb) |
| Scaling order | Random | Ordered (0 → 1 → 2) |

---

## Key Concept — Pod Names are Always Fixed

```
mysql-statefulset-0    ← always pod 0
mysql-statefulset-1    ← always pod 1
mysql-statefulset-2    ← always pod 2
```

If you delete `mysql-statefulset-0` — it comes back as `mysql-statefulset-0` again.

---

## Commands Practiced

### Apply Namespace and StatefulSet
- `kubectl apply -f namespace.yml -f statefulset.yml`

### Check All Resources
- `kubectl get all -n mysql`
- `kubectl get pods -n mysql`

### Delete a Pod (StatefulSet recreates it)
- `kubectl delete pod/mysql-statefulset-0 -n mysql`

### Access Pod via Shell
- `kubectl exec -it pod/mysql-statefulset-1 -n mysql -- bash`

### Access MySQL Inside Pod
```bash
mysql -u root -p
# Enter password when prompted
```

### MySQL Commands Inside Pod
```sql
show databases;
exit
```

---

## Clean Up

### Delete a Single Pod
```bash
kubectl delete pod/mysql-statefulset-0 -n mysql
```

> ⚠️ StatefulSet will recreate the pod automatically!

### Delete Entire Namespace (removes everything)
```bash
kubectl delete namespace/mysql
```

### Delete Using YAML Files
```bash
kubectl delete -f namespace.yml -f statefulset.yml
```

---

## What Happened in This Session

```
Apply StatefulSet
      │
      ▼
mysql-statefulset-0  ✅ Running
mysql-statefulset-1  ✅ Running
      │
      ▼
Delete mysql-statefulset-0
      │
      ▼
mysql-statefulset-0  ✅ Recreated automatically  ← StatefulSet magic!
mysql-statefulset-1  ✅ Still Running
      │
      ▼
Exec into mysql-statefulset-1
      │
      ▼
mysql -u root -p
show databases;  ← mydb was still there ✅
```

---

## One Line Summary

> 💡 **StatefulSet keeps pod identity and data stable — even if a pod is deleted, it comes back with the same name and data.**
