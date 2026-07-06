#!/bin/bash
git clone https://github.com/chaostoolkit-incubator/kubernetes-crd.git ctk-operator
cd ctk-operator/manifests
kubectl kustomize overlays/generic-rbac | kubectl apply -f -
