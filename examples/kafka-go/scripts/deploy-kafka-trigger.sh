#!/bin/bash

export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kafka-trigger/releases/latest | grep tag_name | cut -d '"' -f 4)
kubectl create -f https://github.com/kubeless/kafka-trigger/releases/download/$RELEASE/kafka-zookeeper-$RELEASE.yaml

echo "Sucessfully deployed kafka, zookeeper and related services. They should appear in below output from \`kubectl --namespace kubeless get svc\`"
kubectl -n kubeless get svc
