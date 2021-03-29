#!/bin/bash
set -eu
# install kubernetes kind
sudo apt-get -y update
function installKind() {
    if ! [ -x "$(command -v kind)" ]; then
    echo "Instaling Kubernetes KinD..."
    curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.7.0/kind-$(uname)-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    kind --version
  fi
}
function createKindCluster() {
    if [ -x "$(command -v kind)" ]; then
    echo "Create Kubernetes KinD Cluster..."
    curl -Lo ./kind-config.yaml https://raw.githubusercontent.com/sivakumarvunnam/kind/master/kind-config.yaml
    chmod +x ./kind-config.yaml
    kind create cluster --config ./kind-config.yaml --name cluster
  fi
}

installKind
createKindCluster