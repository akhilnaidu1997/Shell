#!/bin/bash

NUMBER=4

if [ $NUMBER -lt 10 ]; then
    echo " Given number $NUMBER is less than 10"
elif [ $NUMBER -eq 10 ]; then
    echo " Given number $NUMBER is equal to 10"
else
    echo " Number $NUMBER is greater than 10"
fi

