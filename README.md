# Kubeless Exploration

## What's this all about?
Kubeless is a pretty bad-ass and easy to use implementation of FaaS (functions as a service) on kubernetes with dead simple setup and implementation. It's compliant with the AWS Lambda CLI and serverless framework (via a plugin), supports a number of popular programming languages or you can implement custom runtimes, and event triggers, Kafka, Kinesis, monitoring, logging, and so on are all easy to setup and intuitive.

A good portion of this repo (so far) is taken directly from [kubeless.io](kubeless.io) or easy to find documentation. Perhaps it's helpful to have it all in one place and I've included some helpful scripts and notes on the process.

## Takeaways
Besides the glowing review above, I don't like the fact that functions are always-up pods that are implemented via servers, such as bottle for python. Better approach would be something like fission's where functions are executed from a pool and so don't need to always have running resources per function. Then again, pods aren't expensive. I also haven't yet implemented autoscaling in kubeless, so can't comment on that.  

## Minikube Installation and Use
[minikube.md](minikube.md)

## Getting Started
Installation scripts are provided at [./scripts](./scripts) and have some of there own documentation.

If you don't have the kubeless CLI installed, do so following kubeless directions or run the script provided here
```sh
./scripts/install-kubeless-cli.sh
```

Once minikube or whatever kubernetes cluster is up and you're in the right context, install kubeless in that cluster
```sh
./scripts/kubeless-deployment.sh
```

## Examples
A number of examples to follow along with in [./examples](./examples), each with it's own README.md. `cd` into a directory and try it out. They build on each other, at least in terms of becoming more complex, in the order presented here.

1. [Simple python function with HTTP and UI](examples/python/README.md)
1. [Kafka producer with golang and python](examples/kafka-producer-go-python/README.md)
