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

if [ $USER -ne 0 ]; then
    echo -e "$R ERROR:: Install with sudo permissions $N" | tee -a $LOG_FILE
    exit 1
fi

USAGE(){
    echo "USAGE: sh <file.sh> <source-dir> <dest-dir> <Days>[optional]"
    exit 1
}

if [ $# -ne 2 ]; then
    USAGE
fi