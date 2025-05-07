#!/bin/bash
export KRO_VERSION=$(curl -sL \
    https://api.github.com/repos/kro-run/kro/releases/latest | \
    jq -r '.tag_name | ltrimstr("v")'
)

test -z $KRO_VERSION && exit || \
  helm install kro oci://ghcr.io/kro-run/kro/kro \
    --namespace kro \
    --create-namespace \
    --version=${KRO_VERSION}
