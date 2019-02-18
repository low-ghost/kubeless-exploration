#!/bin/bash

# Script to install kubeless for linux and macOS

source $PWD/scripts/get-release.sh
get_release

os=$(uname -s | tr '[:upper:]' '[:lower:]'$)
# get the latest binary, unzip, move it to local bin
curl -OL https://github.com/kubeless/kubeless/releases/download/$release/kubeless_$os-amd64.zip && \
  unzip kubeless_$os-amd64.zip && \
  sudo mv bundles/kubeless_$os-amd64/kubeless /usr/local/bin/
# cleanup
rm -rf bundles kubeless_$os-amd64.zip
echo "installed `kubeless version`"
