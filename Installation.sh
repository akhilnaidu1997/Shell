#!/bin/bash # #! --> represents shebang, used to tell which shell we are using as interpreter

USER=$(id -u) 

if [ $USER -ne 0 ]; then
    echo "ERROR:: Install with sudo permissions"
    exit 1
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "ERROR: Installing mysql is failure"
    exit 1
else 
    echo "MYSQL app is already installed"
fi
