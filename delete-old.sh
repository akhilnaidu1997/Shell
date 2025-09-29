#!/bin/bash # #! --> represents shebang, used to tell which shell we are using as interpreter

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER=$(id -u) 
LOG_FOLDER1="/var/log/shell-install"
SCRIPT_NAME1=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOG_FOLDER1/$SCRIPT_NAME1.log"

mkdir -p $LOG_FOLDER1

echo " Script started at time : $(date) " | tee -a $LOG_FILE

source="/home/ec2-user/app-logs"

if [ ! -d $source ]; then
    echo "ERROR: Source directory is not available"
    exit 1
fi

find=$( find $source -name "*.log" -type f -mtime +14)

while IFS= read -r line # Internal field seperator
do
    echo "Deleting lines: $line"
    rm -rf $line
done <<< $find