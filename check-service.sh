#!/bin/bash

# Check if the service is running

SERVER=$1
SERVICE=nginx

if ssh -o ConnectTimeout=5 ec2-user@$SERVER "systemctl is-active --quiet $SERVICE"; then
    echo "$SERVICE is running on $SERVER"
else
    echo "$SERVICE is NOT running on $SERVER"
    if ssh -o ConnectTimeout=5 ec2-user@$SERVER "sudo systemctl start $SERVICE"; then
        echo "Started $SERVICE on $SERVER"
    else
        echo "Failed to start $SERVICE on $SERVER"
    fi
fi