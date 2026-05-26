#!/bin/bash

SERVERS=("34.228.17.213")

for server in "${SERVERS[@]}"
do
    echo "Checking server: $server"
    ssh -o ConnectTimeout=5 ec2-user@"$server" "df -hT"
    ssh -o ConnectTimeout=5 ec2-user@"$server" "free -h"
    # ssh -o ConnectTimeout=5 ec2-user@"$server" "top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2 "%"}' "  
done