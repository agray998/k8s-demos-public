#!/bin/bash
kubectl create ns staging
kubectl create ns prod
kubectl label ns prod env=prod
kubectl -n prod run web --image=httpd
kubectl -n prod expose pod web --port=80
kubectl -n prod label pod web app=apache
kubectl -n staging run test --image=alpine -- sleep infinity
# sleep 5
# echo "Request WITHOUT Network Policy in place"
# kubectl -n staging exec test -- sh -c "apk update; apk add curl; curl -s web.prod.svc.cluster.local"
# kubectl -n prod apply -f netpol.yaml
# echo "Request WITH Network Policy in place"
# kubectl -n staging exec test -- sh -c "curl -s web.prod.svc.cluster.local"
