# Minikube Config for Openwhisk

## Set Docker in Promiscuous Mode
Do this every time you start minikube
```sh
minikube ssh -- sudo ip link set docker0 promisc on
```

## mycluster.yml Format For Minikube
If deploying on minikube (as this repo does) edit the mycluster.yml with your minikube ip and any open port.

```yaml
whisk:
  ingress:
    type: NodePort
    apiHostName: <minikube ip>
    apiHostPort: 31001

nginx:
  httpsNodePort: 31001
```
