# Kafka Topics and Go Functions

Kubeless provides (almost) out-of-the-box kafka support with built in features for creating and publishing topics. This example builds on some of the examples in kubeless by adding a producer in the producer-python directory. Not a lot of documentation on that side of things, but once I got the host/port right (pretty obvious) everything else was by the book. The consumer is a standard golang kubeless function that just happens to be subscribed to the topic via kubeless's `trigger` command.

## Getting Started
Take a look in the [./scripts](./scripts) directory or go ahead and run the .sh files:
```sh
# Install kafka, zookeeper and related systems in the cluster
./scripts/deploy-kafka.sh
# Deploy the example environment
./scripts/deploy-example.sh
```
Now you can manually push to a topic with `kubeless topic publish --topic example --data 'whatever'`. Or you can call the producer function from CLI and check that we see the message go through kafka and into the logs for the consumer.
```sh
kubeless function call py-producer --data '{ "message": "hey!" }' 
# Show consumer logs. You're looking for the json `{ type: 'python-event', object: { 'message': 'hey!' } }`
kubectl logs service/consumer
```

Finally, go ahead and clean up the environment by deleting the functions and triggers created above via
```sh
./scripts/cleanup.sh
```

## Go files
Go dependencies are brought into the kubeless function via a Gopkg.toml. Even so, the new shiny `go mod init` allows working in directories not in the $GOPATH, which is likely for lambda style work. The Gopkg.toml files were kept up to date manually.
