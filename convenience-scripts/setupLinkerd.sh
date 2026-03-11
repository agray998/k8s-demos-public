curl -sL run.linkerd.io/install-edge | sh
export PATH=$PATH:$HOME/.linkerd2/bin
echo "export PATH=$PATH:$HOME/.linkerd2/bin" >> $HOME/.bashrc
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.1" | kubectl apply -f -
linkerd check --pre
linkerd install --crds | kubectl apply -f -
linkerd install | kubectl apply -f -
linkerd check
linkerd viz install | kubectl apply -f -
linkerd viz check
linkerd viz dashboard &

