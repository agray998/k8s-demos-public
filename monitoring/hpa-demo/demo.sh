#!/bin/bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
wget https://k8s.io/examples/application/php-apache.yaml
cat php-apache.yaml | linkerd inject --proxy-cpu-limit 10m - | kubectl apply -f - # assumes linkerd already installed, so can demo need to configure proxy injection if using hpa
kubectl autoscale deploy php-apache --cpu-percent=60 --min=1 --max=5
kubectl run -it load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
kubectl get hpa php-apache --watch
