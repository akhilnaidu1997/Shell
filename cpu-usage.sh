#!/bin/bash

CPU_THRESHOLD=5
MESSAGE=""

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2 "%"}')

if [ $CPU_USAGE -gt $CPU_THRESHOLD ]; then
    MESSAGE+="CPU usage is above threshold: $CPU_USAGE\n"
fi

if [ -n "$MESSAGE" ]; then
    echo -e "$MESSAGE"
fi

sh mail.sh "CPU Usage Alert" "$MESSAGE"