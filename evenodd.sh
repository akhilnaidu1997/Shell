#!/bin/bash

NUM=$1

if [ $(( $NUM % 2 )) -eq 0 ]; then
    echo " Given $NUM is EVEN"
else
    echo " Given $NUM is ODD"
fi