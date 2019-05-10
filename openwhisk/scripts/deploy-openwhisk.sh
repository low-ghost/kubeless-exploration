#!/bin/bash

# If not already inited
helm init
# Create a tiller deploy pod
kubectl create clusterrolebinding tiller-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
# For a single node cluster, indicate the worker nodes for openwhisk use
kubectl label nodes --all openwhisk-role=invoker
# Clone the repo
git clone https://github.com/apache/incubator-openwhisk-deploy-kube.git
# Use helm to deploy the cluster
helm install incubator-openwhisk-deploy-kube/helm/openwhisk --namespace=openwhisk --name=owdev -f mycluster.yaml
# Check that pods are `Running`
kubectl --namespace openwhisk get pods
