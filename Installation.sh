#!/bin/bash # #! --> represents shebang, used to tell which shell we are using as interpreter

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER=$(id -u) 

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

dnf list installed mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "MYSQL"
fi

dnf list installed nginx
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "NGINX"
fi

dnf list installed python3
if [ $? -ne 0 ]; then
    dnf install python3 -y
    VALIDATE $? "PYTHON"
fi

