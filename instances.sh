#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0fee42dfd5533e5de"
ZONE_ID="Z10111863267OBDLA0XLE"
DOMAIN_NAME="daws86s-akhil.shop"

for instance in $@
do
    Instance_ID=$( aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text )

    if [ $instance != "frontend" ]; then
        IP=$( aws ec2 describe-instances --instance-ids $Instance_ID  --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text )
        RECORD_NAME="$instance.$DOMAIN_NAME" #mongodb.daws86ss-akhil.shop
    else
        IP=$( aws ec2 describe-instances --instance-ids $Instance_ID  --query 'Reservations[0].Instances[0].PublicIpAddress' --output text )
        RECORD_NAME="$DOMAIN_NAME" #daws86ss-akhil.shop
    fi

    echo " $instance: $IP"

    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Updating record set"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$RECORD_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP'"
            }]
        }
        }]
    }
    '
done


