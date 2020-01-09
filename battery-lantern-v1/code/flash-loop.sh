#!/bin/bash

while true; do
    ./flash.sh
    if [ $? -eq 0 ]; then
        printf "\e[92m"
        figlet OK
        printf "\e[0m"
        sleep 7
    else
        printf "\e[31m"
        figlet ERROR
        printf "\e[0m"
        sleep 1
    fi
done
