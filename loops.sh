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

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e " $R ERROR: Installing $2 is failure $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$G $2 app is  installed successfully $N" | tee -a $LOG_FILE
    fi
}

for PACKAGE in $@
do
    dnf list installed $PACKAGE &>> $LOG_FILE
    if [ $? -ne 0 ]; then
        dnf install $PACKAGE -y &>> $LOG_FILE
        VALIDATE $? "$PACKAGE"
    else
        echo -e "$Y $PACKAGE is already installed $N" | tee -a $LOG_FILE
    fi
done

