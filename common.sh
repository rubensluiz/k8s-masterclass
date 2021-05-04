#!/usr/bin/env sh

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward                = 1
EOF
sysctl --system

apt-get update
apt-get install -y apt-transport-https ca-certificates curl

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update

apt-get install -y containerd kubeadm=1.18.17-00 kubelet=1.18.17-00

sudo apt-mark hold kubelet kubeadm kubectl

#echo "KUBELET_EXTRA_ARGS=--node-ip=$(hostname -I | awk '{print $2}')" | sudo tee /etc/default/kubelet

#sudo kubeadm init --apiserver-advertise-address=192.168.57.2 --pod-network-cidr=10.128.0.0/16 --service-cidr=10.127.0.0/16 --service-dns-domain=contoso.internal
#curl https://docs.projectcalico.org/manifests/calico.yaml -O
