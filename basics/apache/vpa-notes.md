# VPA (Vertical Pod Autoscaler) Setup & Testing on Kind

## 1. Install VPA from autoscaler repo  Delete it once the sh script is run

offical k8s repo [Link](https://github.com/kubernetes/autoscaler/blob/master/vertical-pod-autoscaler/docs/installation.md)

```bash
# Clone the repo (shallow)
git clone --depth 1 https://github.com/kubernetes/autoscaler.git
cd autoscaler/vertical-pod-autoscaler

# Fetch tags (required — shallow clone skips them)
git fetch --tags

# Run install script (installs CRDs, RBAC, and all 3 VPA components)
./hack/vpa-up.sh
```

> ⚠️ Without `git fetch --tags`, `vpa-up.sh` fails with:
> `fatal: invalid reference: vertical-pod-autoscaler-x.x.x`

### VPA Components installed by `vpa-up.sh`
| Component | Role |
|---|---|
| **Recommender** | Watches pods and suggests CPU/Memory values |
| **Updater** | Evicts pods that need resource adjustment |
| **Admission Controller** | Patches new pods with recommended resources |

### Verify installation
```bash
kubectl get pods -n kube-system | grep vpa
```
All 3 pods should be in `Running` state.

---

| Mode | Behaviour |
|---|---|
| `Recreate` | Evicts and recreates pods with updated resource values |
| `Initial` | Only sets resources at pod creation, never updates running pods |
| `InPlaceOrRecreate` | Tries in-place update first, falls back to recreate |

```bash
kubectl apply -f vpa.yml
```

---

## 3. Testing VPA with a load generator

### Terminal 1 — watch VPA recommendations
```bash
kubectl get vpa -n apache
# or watch continuously
watch kubectl get vpa -n apache
```

### Terminal 2 — generate load
```bash
# Start a busybox pod in the apache namespace
kubectl run -it --tty loadgen --image=busybox -n apache -- /bin/sh

# Inside the pod — run a continuous load loop
while true; do wget -q -O- http://<CLUSTER-IP>:<PORT> >> /dev/null ; done
```

> Replace `<CLUSTER-IP>:<PORT>` with your service's ClusterIP and port.
> Example used: `http://10.96.94.175:8081`

---

## 4. Observed output

```
# Before load
NAME         MODE       CPU   MEM     PROVIDED   AGE
apache-vpa   Recreate   25m   250Mi   True       7m25s

# After load generation (~18 min)
NAME         MODE       CPU    MEM     PROVIDED   AGE
apache-vpa   Recreate   247m   250Mi   True       21m
```

VPA bumped CPU recommendation from **25m → 247m** based on actual usage.

---

## 5. Useful commands

```bash
# Check all resources in apache namespace
kubectl get all -n apache

# Describe VPA for detailed recommendations
kubectl describe vpa apache-vpa -n apache

# Check VPA recommender logs
kubectl logs -n kube-system -l app=vpa-recommender
```
