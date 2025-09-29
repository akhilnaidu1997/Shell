#!/bin/bash # #! --> represents shebang, used to tell which shell we are using as interpreter

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

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
    echo -e "USAGE: $R sh <file.sh> <source-dir> <dest-dir> <Days>[optional] $N"
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    echo " ERROR: Source $SOURCE_DIR is not there"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo " ERROR: Source $DEST_DIR is not there"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "files found"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo "Zip file name: $ZIP_FILE_NAME"
    find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"
    if [ -f $ZIP_FILE_NAME ]; then
        echo "Archieval is successful"
        while IFS= read -r line # Internal field seperator
        do
            echo "Deleting lines: $line"
            rm -rf $line
        done <<< $FILES
    else
        echo "Archieval is failed"
    fi

else
    echo "files not found"
fi

