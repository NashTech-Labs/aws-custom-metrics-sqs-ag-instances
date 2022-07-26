#!/bin/bash
######ENV REQUIRED#############
#SQS_QUEUE_NAME
#SQS_QUEUE_URL
#AUTO_SCALING_GROUP_NAME
#AWS_ACCESS_KEY_ID
#AWS_SECRET_ACCESS_KEY
#AWS_DEFAULT_REGION=us-west-2
###############################

echo -e "\nRunning Script Very One minute"
aws --version
aws sts get-caller-identity

APPROXIMATE_NUMBER_OF_MESSAGES=`aws sqs get-queue-attributes --queue-url ${SQS_QUEUE_URL} \
  --attribute-names ApproximateNumberOfMessages  --query Attributes.ApproximateNumberOfMessages | bc`

CAPACITY=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${AUTO_SCALING_GROUP_NAME}  --query AutoScalingGroups[0].DesiredCapacity`

echo "APPROXIMATE_NUMBER_OF_MESSAGES: ${APPROXIMATE_NUMBER_OF_MESSAGES}"
echo "CURRENT_CAPACITY: ${CAPACITY}"

if [ $CAPACITY -ne 0 ]; then
    echo "CURRENT CAPACITY IS NOT ZERO"
    BACKLOG_PER_INSTANCE=$((${APPROXIMATE_NUMBER_OF_MESSAGES}/${CAPACITY}))
    echo "BACKLOG_PER_INSTANCE: ${BACKLOG_PER_INSTANCE}"

    aws cloudwatch put-metric-data --metric-name MyBacklogPerInstance \
    --namespace "CUSTOM/SQS" \
    --unit None \
    --value ${BACKLOG_PER_INSTANCE} \
    --dimensions QueueName=${SQS_QUEUE_NAME}
else
    echo "CURRENT CAPACITY ZERO, NOT ABLE CREATE CUSTOM METRICS"
fi