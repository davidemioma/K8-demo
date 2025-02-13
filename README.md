# Ride Sharing sample k8s microservice project

## Services

- gateway: API Gateway
- orders: Order Service
- payments: payment Service

## Intro

This is a golang microservices sample project using Kubernetes for both local development and for production, making you more confident on developing new microservices and deploying them.

## Requirements

To run this project locally all you need is [Tilt](https://tilt.dev/) and [Minikube](https://minikube.sigs.k8s.io/docs/)

## Run

```bash
tilt up
```

## Monitor

```bash
kubectl get pods
```

or

```bash
minikube dashboard
```

## Deployment (Google Cloud example)

It's advisable to first run the steps manually and then build a proper CI/CD flow according to your infrastructure.

## 0. Enviroments

```bash
REGION: europe-west2 # change according to your location
PROJECT_ID: <your-gcp-project-id>
```

## 1. Build Docker Images

Build all docker images and tag them accordingly to push to Artifact Registry.

```bash
docker build -t {REGION}-docker.pkg.dev/{PROJECT_ID}/go-k8-tutorial/gateway:latest --platform linux/amd64 -f infra/production/docker/gateway.Dockerfile .
docker push {REGION}-docker.pkg.dev/{PROJECT_ID}/go-k8-tutorial/gateway:latest -platform linux/amd64  .
```

## 2. Create a Artifact Registry repository

Go to Google Cloud > Artifact Registry and manually create a docker repository to host your project images.

## 3. Push the Docker images to artifact registry

Docker push the images.
If you get errors pushing:

1. Make sure to `gcloud login`, select the right project or even `gcloud init`.
2. Configure artifact on your docker config `gcloud auth configure-docker {REGION}-docker.pkg.dev` [Docs](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling#cred-helper)

## 4. Create a Google Kubernetes Cluster

You can either run a `gcloud` command to start a GKE cluster or manually create a cluster on the UI (recommended).

## 5. Update manifests files

Connect to your remote cluster and apply the kubernetes manifests.

```bash
gcloud container clusters get-credentials go-k8-tutorial--region {REGION}--project {PROJECT_ID} && \
kubectl apply -f infra/production/k8s
```

If you need to redeploy you can use the same command above or just `kubectl apply -f infra/production/k8s`
Sometimes pods might need to be deleted for new ones to be deployed.

```bash
kubectl get pods
kubectl delete pod <pod-name>

# or for all deployments
kubectl rollout restart deployment
```

## 6. Enjoy!

```bash
Get the External IP from the api-gateway
kubectl get services
```

cURL for the /servies or establish a websocket connection to /ws/drivers!

```bash
curl http://{EXTERNAL_IP}:8081/services
```

Go back to locally developing your project by changing kubernetes context

```bash
kubectl config get-contexts

# For Docker Desktop
kubectl config use-context docker-desktop

# OR for Minikube
kubectl config use-context minikube
```

## Explanation

This is a basic example of how to structure a microservice architecture with Kubernetes.

You can try to run the `tilt up` command and then try to access the `gateway` service at `http://localhost:8080`.

This is pretty neat and it's a good way to start with Kubernetes and explore the features it offers.
