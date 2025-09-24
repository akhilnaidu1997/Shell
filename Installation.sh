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

echo " Script started at time : $(date) "

if [ $USER -ne 0 ]; then
    echo -e "$R ERROR:: Install with sudo permissions $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e " $R ERROR: Installing $2 is failure $N"
    else
        echo -e "$G $2 app is  installed successfully $N"
    fi
}

dnf list installed mysql &>> $LOG_FILE
if [ $? -ne 0 ]; then
    dnf install mysql -y &>> $LOG_FILE
    VALIDATE $? "MYSQL"
else
    echo -e "$Y MYSQL is already installed $N"
fi

dnf list installed nginx &>> $LOG_FILE
if [ $? -ne 0 ]; then
    dnf install nginx -y &>> $LOG_FILE
    VALIDATE $? "NGINX"
else
    echo -e "$Y NGINX is already installed $N"
fi

dnf list installed python3 &>> $LOG_FILE
if [ $? -ne 0 ]; then
    dnf install python3 -y &>> $LOG_FILE
    VALIDATE $? "PYTHON"
else
    echo -e "$Y PYTHON is already installed $N"
fi

