#!/bin/bash

NODEPORT=$1

curl \
  -H "Content-Type: application/json" \
  -X POST \
  -d@test.json \
  http://127.0.0.1:$NODEPORT/ 
