# Kubernetes — Taints & Tolerations

---

## What is a Taint?

> **A Taint is a rule applied to a Node that prevents pods from being scheduled on it — unless the pod has a matching Toleration.**

```
Node with Taint          Pod without Toleration
      │                           │
      │   ❌ Cannot schedule       │
      └───────────────────────────┘

Node with Taint          Pod with Toleration
      │                           │
      │   ✅ Can schedule          │
      └───────────────────────────┘
```

---

## Taint Syntax

```bash
kubectl taint node <node-name> <key>=<value>:<effect>
```

### Effects

| Effect | Meaning |
|---|---|
| `NoSchedule` | Pod will NOT be scheduled on this node |
| `PreferNoSchedule` | Kubernetes will try to avoid this node |
| `NoExecute` | Evicts already running pods + blocks new ones |

---

## 1. Add a Taint to a Node

- `kubectl taint node jarvis-worker2 prod=true:NoSchedule`
- `kubectl taint node jarvis-worker prod=true:NoSchedule`

---

## 2. Overwrite an Existing Taint

- `kubectl taint node jarvis-worker2 prod=true:NoSchedule --overwrite`
- `kubectl taint node jarvis-worker prod=true:NoSchedule --overwrite`

---

## 3. Remove a Taint from a Node

> 💡 Add `-` at the end of the taint to remove it.

- `kubectl taint node jarvis-worker prod=true:NoSchedule-`
- `kubectl taint node jarvis-worker2 prod=true:NoSchedule-`
- `kubectl taint node jarvis-worker stat=false:NoSchedule-`
- `kubectl taint node jarvis-worker2 stat=false:NoSchedule-`

---

## 4. Check Taints on a Node

```bash
# Describe node and filter taint info
kubectl describe node jarvis-worker | grep -i "taint"
kubectl describe node jarvis-worker2 | grep -i "taint"

# Full node details
kubectl describe node jarvis-worker
```

---

## 5. Check All Nodes

- `kubectl get nodes`

---

## 6. Apply & Verify Pods

```bash
# Apply pod and deployment
kubectl apply -f pod.yml
kubectl apply -f deployment.yml -f pod.yml

# Check pods and which node they landed on
kubectl get pods -n nginx
kubectl get all -n nginx -o wide        # -o wide shows which node pod is on

# Describe pod to see scheduling events
kubectl describe pod/test-pod -n nginx
```

---

## 7. Delete a Pod

- `kubectl delete -f pod.yml`
- `kubectl delete pod/test-pod -n nginx`

---

## What `-o wide` Shows

```bash
kubectl get all -n nginx -o wide
```

```
NAME         READY   STATUS    NODE
test-pod     1/1     Running   jarvis-worker   ← shows which node pod scheduled on
```

> 💡 Use `-o wide` to verify your taint is working — check which node the pod landed on.

---

## Taint & Toleration Flow

```
Add Taint to jarvis-worker2
         │
         ▼
Apply pod.yml (no toleration)
         │
         ▼
Pod cannot schedule on jarvis-worker2  ❌
Pod schedules on jarvis-worker         ✅
         │
         ▼
Remove Taint from jarvis-worker2
         │
         ▼
Pod can now schedule on jarvis-worker2 ✅
```

---

## One Line Summary

> 💡 **Taint = keep pods away from a node | Toleration = allow a pod to ignore a taint and schedule anyway.**
