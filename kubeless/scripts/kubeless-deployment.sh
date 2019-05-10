#!/bin/bash

source $PWD/scripts/get-release.sh
get_release

# Create the kubeless namespace
kubectl create ns kubeless
# Apply a kubeless release
kubectl create -f \
  https://github.com/kubeless/kubeless/releases/download/$release/kubeless-$release.yaml
# Show deployment
kubectl get deployment --namespace kubeless
