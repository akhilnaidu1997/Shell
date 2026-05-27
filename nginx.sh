#!/bin/bash

SERVICE=nginx

if systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE is running"
else
    echo "$SERVICE is NOT running"
    sudo systemctl start $SERVICE   
    if systemctl is-active --quiet $SERVICE; then
        echo "Started $SERVICE successfully"
    else
        echo "Failed to start $SERVICE"
    fi
fi