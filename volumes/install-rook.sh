#!/bin/bash
git clone --single-branch --branch v1.17.1 https://github.com/rook/rook.git
cd rook/deploy/examples
kubectl apply -f crds.yaml -f common.yaml -f operator.yaml 
kubectl apply -f cluster-test.yaml 
kubectl apply -f csi/rbd/storageclass-test.yaml 
kubectl apply -f filesystem-test.yaml
kubectl apply -f csi/cephfs/storageclass.yaml
kubectl apply -f object-test.yaml 
kubectl apply -f object-user.yaml 
kubectl apply -f storageclass-bucket-delete.yaml
kubectl get all -n rook-ceph
kubectl -n rook-ceph get cephcluster rook-ceph
kubectl -n rook-ceph get cephclusters
