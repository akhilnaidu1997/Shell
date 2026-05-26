#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem )
DISK_Threshold=3
MESSAGE=""

while IFS= read -r line;
do
    usage=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
    Partition=$(echo $line | awk '{print $7}')
    if [ $usage -gt $DISK_Threshold ]; then
        MESSAGE+="Disk usage on partition $Partition is above threshold: $usage%\n"
    fi
done <<< "$DISK_USAGE"

if [ -n "$MESSAGE" ]; then
    echo -e "$MESSAGE"
fi

sh mail.sh "Disk Usage Alert" "$MESSAGE"