# OpenWhisk

OpenWhisk is another FaaS solution for kubernetes.

## Getting Started
You'll need the wsk CLI available [here](https://github.com/apache/incubator-openwhisk-cli).

Then follow along with the instructions in minikube.md and either follow along or run [scripts/deploy-openwhisk.sh](scripts/deploy-openwhisk.sh).
```sh
wsk property set --apihost <minikube ip>:31001
wsk property set --auth 23bc46b1-71f6-4ed5-8c54-816aa4f8c502:123zO3xZCLrMN6v2BKK1dXYFpXlPkccOFqm12CdAsMgRU4VrNZ9lyGVCGuMDGIwP
```

This is where it broke for me..., couldn't get couch-db to run without erroring, `wsk -i list` never returns, kubectl became slower and slower until being unresponsive. Maybe I'll try again and actually follow the directions w/r/t minikube flags haha. Definitely more implementation work here though and a lot of running infrastructure.
