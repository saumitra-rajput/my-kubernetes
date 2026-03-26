# Kubernetes RBAC — Role, ServiceAccount & RoleBinding

## 1. Apply manifests in order

```bash
# 1. Create namespace first
kubectl apply -f namespace.yml

# 2. Create role
kubectl apply -f role.yml

# 3. Create service account
kubectl apply -f service-account.yml

# 4. Create role binding
kubectl apply -f role-binding.yml
```

> ⚠️ Always apply `namespace.yml` first — other resources will fail with `namespaces not found` without it.

---

## 2. Verify resources

```bash
# Check service accounts
kubectl get serviceaccount -n apache

# Check roles
kubectl get role -n apache

# Check role bindings
kubectl get rolebinding -n apache
```

---

## 3. Test permissions with `kubectl auth can-i`

```bash
# Check YOUR own permissions
kubectl auth can-i get pods -n apache

# Check permissions AS a specific service account
kubectl auth can-i get pods --as=apache-user -n apache
kubectl auth can-i get deployments --as=apache-user -n apache
kubectl auth can-i delete deployments --as=apache-user -n apache
kubectl auth can-i get hpa --as=apache-user -n apache
```

> Returns `yes` or `no`

---

## 4. Common errors & fixes

| Error | Cause | Fix |
|---|---|---|
| `no matches for kind "Role" in version "rbac.authorizath.k8s.io/v1"` | Typo in apiVersion | Use `rbac.authorization.k8s.io/v1` |
| `namespaces "apache" not found` | Namespace not created yet | Apply `namespace.yml` first |
| `Unsupported value: "user"` in RoleBinding subjects | Wrong `kind` value | Use `ServiceAccount`, `User`, or `Group` |
| `auth can-i` returns `no` after rolebinding | Wrong subject name or namespace in binding | Check `name` and `namespace` in rolebinding subjects match exactly |
