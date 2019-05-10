# FaaS on Kubernetes Exploration

## Why?

Function as a Service is a new approach to applications (2014 introduction with AWS Lambda platform) that allows developers to focus on small units of business logic and can encourage better separation and decoupling of the codebase along these units. Applications in a FaaS-centric architecture are simple functions that don't need to focus on routing or server operation and relieve developers of needing to focus on server management or networking (to a large extent). The architecture unveiled by serverless applications is perhaps better at event driven workflows, auto-scaling, consuming less resources, and enabling fast, agile, iterative development cycles. Existing solutions are not without their problems though: observability is more difficult, we leave behind the world of kubernetes and often end up with heavier reliance on separate vendor systems like AWS, deployment and configuration can be tricky and so on.

## Kubernetes Native Solutions
Kubernetes based solutions for FaaS approach the problems of existing systems by remaining within kubernetes, simplifying deployment, often building out a UI for maintaining functions and observing logs, and often coming with out-of-the-box or easy to deploy tools for notifications, queues and streaming data.

## Minikube Installation and Use
[minikube.md](minikube.md)
