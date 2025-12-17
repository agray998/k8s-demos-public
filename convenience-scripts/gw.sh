#!/bin/bash
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.1" | kubectl apply -f -
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.1/deploy/crds.yaml
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.1/deploy/default/deploy.yaml
kubectl patch service/nginx-gateway -n nginx-gateway -p '{"spec": {"type": "NodePort"}}'
kubectl get service/nginx-gateway -n nginx-gateway

