#!/bin/bash

SERVERS=("34.228.17.213")

for server in "${SERVERS[@]}"
do
    echo "Checking server: $server"
    ssh ec2-user@"$server" "df -hT"
done