#!/bin/bash
kubectl -n simple-app create cm chaos-exp --from-file=experiment.json
