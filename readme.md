# Environemnt Variables Requirement
### *SQS_QUEUE_NAME*
### *SQS_QUEUE_URL*
### *AUTO_SCALING_GROUP_NAME*
### *AWS_ACCESS_KEY_ID*
### *AWS_SECRET_ACCESS_KEY*
### *AWS_DEFAULT_REGION*

# Concept
1. sqs metrics **ApproximateNumberOfMessages**  in AWS/SQS namespace in aws cloudwatch metric provides the length of the queue in given time.

2. aws auto scaling groups desired capacity, under which healthy instances are in-service.

3. crontab to publish custom metrics every 1 minute

# setup
## docker
```
docker build -t sqs-metrics .

docker run -d \
-e SQS_QUEUE_NAME=<queue-name>\
-e SQS_QUEUE_URL= <queue-url> \
-e AUTO_SCALING_GROUP_NAME=<auto-scaling-group-name> \
-e AWS_DEFAULT_REGION=<region> \
-e AWS_ACCESS_KEY_ID=<> \
-e AWS_SECRET_ACCESS_KEY=<> \
--name sqs-metrics sqs-metrics:latest

```
## kubernetes
```
kubectl apply -f deployment/metrics.yaml
```