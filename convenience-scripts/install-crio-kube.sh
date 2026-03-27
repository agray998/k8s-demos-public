test -z $KUBERNETES_VERSION && KUBERNETES_VERSION=v1.34 || echo ""
test -z $CRIO_VERSION && CRIO_VERSION=v1.34 || echo ""
test -z $USER && USER=student || echo ""
test -z $MODE && MODE=control || echo ""

install_deps() {
  apt-get update
  apt-get install -y software-properties-common curl apt-transport-https ca-certificates git wget lsb-release

  curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key | \
      gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" | \
      tee /etc/apt/sources.list.d/kubernetes.list

  curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key | \
      gpg --dearmor -o /usr/share/keyrings/cri-o-apt-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/ /" | \
      tee /etc/apt/sources.list.d/cri-o.list

  apt-get update
  apt-get install -y cri-o kubelet kubeadm kubectl
  apt-mark hold kubelet kubeadm kubectl

  swapoff -a
  modprobe overlay
  modprobe br_netfilter

  printf "net.bridge.bridge-nf-call-ip6tables = 1\nnet.bridge.bridge-nf-call-iptables = 1\nnet.ipv4.ip_forward = 1" | tee /etc/sysctl.d/kubernetes.conf

  sysctl --system
  systemctl start crio.service
}

if [[ $MODE == control ]]; then
  install_deps
  kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out
  mkdir -p /home/$USER/.kube
  cp -i /etc/kubernetes/admin.conf /home/$USER/.kube/config 
  chown $USER:$USER /home/$USER/.kube/config
  kubectl apply -f cilium-cni.yaml
elif [[ $MODE == worker ]]; then
  install_deps
  echo "Enter join token"
  read token
  echo "enter token hash"
  read hash
  kubeadm join k8scp:6443 --token $token --discovery-token-ca-cert-hash $hash
fi