### API Gateway ###

docker_build('go-kubernetes-gateway', '.', 
    dockerfile='./infra/development/docker/gateway.Dockerfile')
k8s_yaml('./infra/development/k8s/gateway.yaml')
k8s_resource('gateway', port_forwards=8080)

### End of API Gateway ###

### Orders Service ###

docker_build('go-kubernetes-orders', '.', 
    dockerfile='./infra/development/docker/orders.Dockerfile')
k8s_yaml('./infra/development/k8s/orders.yaml')
k8s_resource('orders', port_forwards=2000)

### End of Orders Service ###

### Payments Service ###

docker_build('go-kubernetes-payments', '.', 
    dockerfile='./infra/development/docker/payments.Dockerfile')
k8s_yaml('./infra/development/k8s/payments.yaml')
k8s_resource('payments', port_forwards=5672)

### End of Payments Service ###

### RabbitMQ ###

k8s_yaml('./infra/development/k8s/rabbitmq.yaml')
k8s_resource('rabbit-mq', port_forwards=[15672, 5672])

### End of RabbitMQ ###

### Run "tilt up" ###