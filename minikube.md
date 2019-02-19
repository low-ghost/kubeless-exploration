# Minikube Installation and Use 

For better (maybe) local development experience.

## Installation and Config
On linux
```sh
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
Some envs, maybe not necessary:
```sh
export MINIKUBE_HOME=$HOME
export CHANGE_MINIKUBE_NONE_USER=true
```
You can technically run minikube natively on linux, but certain commands that help to get docker containers in don't work natively (specifically `eval $(minikube docker-env)`), so I'd recommend installing virtualbox or any other choice.

## Getting Started
```sh
# easiest
minikube start
# with a named profile
minikube -p my-profile start
# with the ability to push docker images. On this one, not sure how you'd anticipate
# the results of `minikube ip` and I ran it first without this option to get it.
# Probably making it more complicated than it is
minikube start --insecure-registry <minikube ip>:5000
```

## Toy App
```sh
kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080
kubectl expose deployment hello-minikube --type=NodePort
url=$(sudo minikube service hello-minikube --url)
curl $url
```
or `curl localhost:<port>` using same port that shows up in `echo $url` after above.
Kill the toy app with
```sh
kubectl delete services hello-minikube
```

## Get Custom Docker Image in There
```sh
# having started with the --insecure-registry flag and port 5000
eval $(minikube docker-env)
docker run -d -p 5000:5000 --restart=always --name registry -v /data/docker-registry:/var/lib/registry registry:2
# Build an image (optional if you already have or are pulling)
docker build -t some-image .
# Tag
docker tag some-image localhost:5000/some-image
# Push to local registry
docker push localhost:5000/some-image
# make sure your deployment.yml points to this with lines like (yaml)
    spec:
      containers:
      - name: some-image
        image: localhost:5000/some-image
# create the deployment and a service
kubectl create -f deployment.yml
kubectl create -f service.yml
```
