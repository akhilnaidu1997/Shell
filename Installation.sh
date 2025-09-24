#!/bin/bash # #! --> represents shebang, used to tell which shell we are using as interpreter

USER=$(id -u) 

if [ $USER -ne 0 ]; then
    echo "ERROR:: Install with sudo permissions"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo " ERROR: Installing $2 is failure"
    else
        echo "$2 app is  installed successfully"
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

