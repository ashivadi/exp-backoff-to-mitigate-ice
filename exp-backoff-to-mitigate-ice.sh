#!/bin/bash


# This assumes you are running this with appropriate IAM permissions

INSTANCE_ID="$1"
REGION="$2"
MAX_RETRIES=10
BASE_WAIT=30 # Initial wait time in seconds

if [ -z "$INSTANCE_ID" ] || [ -z "$REGION" ]; then
    echo "Usage: $0 <instance-id> <region>"
    exit 1
fi

attempt=1
while [ $attempt -le $MAX_RETRIES ]; do
    echo "Attempt $attempt: Trying to start instance $INSTANCE_ID..."

    aws ec2 start-instances --instance-ids $INSTANCE_ID --region $REGION 2>&1

    if [ $? -eq 0 ]; then
        echo "Instance started successfully."
        break
    else
        echo "Failed to start instance. Retrying in $BASE_WAIT seconds..."
        sleep $BASE_WAIT
        BASE_WAIT=$((BASE_WAIT * 2)) # Exponential backoff
        attempt=$((attempt + 1))
    fi
done

if [ $attempt -gt $MAX_RETRIES ]; then
    echo "Exceeded maximum retries. Instance start failed."
fi
