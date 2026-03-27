#!/bin/bash
# Ensure a storage class is present
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.31/deploy/local-path-storage.yaml

# Install traefik mesh via helm
helm repo add traefik https://traefik.github.io/charts
helm repo update
kubectl create ns traefik
helm -n traefik install traefik-mesh traefik/traefik-mesh

# Ensure required PVCs are configured to use the storageclass
kubectl -n traefik edit pvc metrics-storage
kubectl -n traefik edit pvc prometeheus-storage

# Make grafana service a NodePort
kubectl -n traefik edit svc grafana

# Create a service
kubectl create deploy web --image=httpd --replicas=3
kubectl expose deploy web --port=80

# Generate some mildly interesting traffic patterns
kubectl run traffic-gen --image=alpine -- \
    sh -c "apk update && apk add curl && while true; do curl web.default.traefik.mesh; done"

while true; do
  test $RANDOM -gt 7000 \
    && kubectl scale deploy web --replicas=0 \
    || kubectl scale deploy web --replicas=3 
  sleep 20 
done 