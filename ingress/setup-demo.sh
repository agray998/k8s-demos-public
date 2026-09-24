#!/bin/bash
wget https://run.linkerd.io/emojivoto.yml

linkerd inject emojivoto.yaml --proxy-cpu-limit=100m | kubectl apply -f -
