docker build -t sqs-metrics .

docker run -d \
-e SQS_QUEUE_NAME=<queue-name>\
-e SQS_QUEUE_URL= <queue-url> \
-e AUTO_SCALING_GROUP_NAME=<auto-scaling-group-name> \
-e AWS_DEFAULT_REGION=<region> \
-e AWS_ACCESS_KEY_ID=<> \
-e AWS_SECRET_ACCESS_KEY=<> \
--name sqs-metrics sqs-metrics:latest