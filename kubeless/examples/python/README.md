# Simple Function in Python Example with HTTP trigger and UI

## Deploy a Function
To deploy this simple python example function, run
```sh
./scripts/deploy-python-function.sh simplefunction.py
```
You should then be able to see a function named `simple-function` with the output from that script or via
```sh
kubectl get functions
```
Note: the kubeless function name cannot contain underscores. Kubeless itself is fine with a file name with an underscore as long as the function is kebab cased, but the serverless framework, used below as an alternative to bash deploying, errors.

## Calling the Function
```sh
kubeless function call simple-function --data 'That was crazy easy right?'
```
or via (unexposed) http with:
```sh
kubectl proxy -p 8080 &

curl -L --data '{ "some": { "http": "json" } }' \
  --header "Content-Type:application/json" \
  localhost:8080/api/v1/namespaces/default/services/simple-function:http-function-port/proxy/
```

## Logs
```sh
kubectl get logs <pod-name>
# or
kubectl get logs services/simple-function
```

## Expose to HTTP
The function can be made available to http calls in a variety of [[ways]]. See [here for more](https://kubeless.io/docs/http-triggers/), but this is perhaps the simplest using minikube and ingress.

Start by enabling the ingress addon with
```sh
minikube addons enable ingress
```
(remember that you likely need sudo and if you created minikube with a profile, then `sudo minikube -p <profile> addons ...`)
The docs say 'a couple of minutes and they mean it. To check progress
```sh
kubectl get pods -n kube-system
```
and look for `nginx-ingress-controller-<unique-id>`. Once that container is `Running`, proceed with the following to expose, interact and delete the function:
```sh
# kubeless trigger http create <trigger-name> --function-name <function-name> --hostname --path <path-after-host>
# not providing a hostname exposes it on a nip.io site
kubeless trigger http create http-simple-function --function-name simple-function --hostname localhost --path simple-function
# check its status and ip
kubectl get ing
# curl the endpoint listed in `HOSTS` with
curl \
  --data '{"some": "data"}' \
  --header "Content-Type:application/json" \
  simple-function.`minikube ip`.nip.io/simple-function
# Update the function by editing/saving file, then
kubeless function update simple-function --from-file examples/python/simplefunction.py
# To delete:
# kubeless trigger http delete <trigger-name>
kubeless trigger http delete http-simple-trigger
```

## Kubeless UI
```sh 
kubectl create -f https://raw.githubusercontent.com/kubeless/kubeless-ui/master/k8s.yaml
kubectl port-forward --namespace kubeless service/ui 3000:3000
```
and go to `localhost:3000`, select simple-function from the lefthand nav and have at it. From here you can edit the function, create new ones, view logs (the tiny `>_` in bottom right) etc.

## Serverless Framework
Easy enough using the provided serverless.yml
```sh
# Delete the previously CLI deployed function (optional)
kubeless function delete simple-function
# Install serverless globally and the kubeless plugin locally
npm install -g serverless
npm install serverless-kubeless
# Deploy, interact, remove
serverless deploy
serverless invoke -f simple-function -d '{"some": "json"}' -l
serverless logs -f simple-function
serverless remove
```
