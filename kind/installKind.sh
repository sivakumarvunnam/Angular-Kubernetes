#!/bin/bash
set -eu
# update repo list
sudo apt-get -y update 
sudo apt-get install -y tree wget curl
# install kubernetes Docker
function installDocker() {
  if ! [ -x "$(command -v docker)" ]; then
    echo "Installing Docker CE..."
    curl -fsSL get.docker.com -o /usr/local/src/get-docker.sh
    sudo sh /usr/local/src/get-docker.sh
    sudo usermod -aG docker vagrant
  fi
}
# install kubernetes Kubectl
function installKubectl() {
    if ! [ -x "$(command -v kubectl)" ]; then
    echo "Instaling Kubernetes CLI..."
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    kubectl version --client
  fi
}
# install kubernetes Kind
function installKind() {
    if ! [ -x "$(command -v kind)" ]; then
    echo "Instaling Kubernetes KinD..."
    curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.7.0/kind-$(uname)-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    kind --version
  fi
}
# Create Kubernetes Kind Cluster
function createKindCluster() {
    if [ -x "$(command -v kind)" ]; then
    echo "Create Kubernetes KinD Cluster..."
    curl -Lo ./kind-config.yaml https://raw.githubusercontent.com/sivakumarvunnam/Angular-Kubernetes/main/kind/kind-config.yaml
    chmod +x ./kind-config.yaml
    kind create cluster --config ./kind-config.yaml --name cluster
  fi
}

installDocker
installKubectl
installKind
createKindCluster