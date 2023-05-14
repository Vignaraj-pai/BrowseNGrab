#!/bin/bash

wifi_stat=$(nmcli radio wifi)

wifi_nm="NITK-NET"
wifi_pwd="2K16NITK"

URL="https://nac.nitk.ac.in:8090/login.xml"

file_path="$HOME/.config/browsengrab/nitk/login.txt"


# Create the directory if it doesn't exist
mkdir -p "$(dirname "$file_path")"

# if -u flag is present then ask for updation of credentials
if [ "$1" == "-c" ]; then
    echo "Update credentials"
    chmod +w "$file_path"
    echo "Enter username: "
    read -r USERNAME
    echo "Enter password: "
    read -r PASSWORD
    # Store username and password in login.txt
    echo "$USERNAME" > "$file_path"
    echo "$PASSWORD" >> "$file_path"
    chmod -x -w "$file_path"
    exit 1
fi

if [ "$1" == '-s' ]; then
    echo "Status of connection"
    # check if connected to NITK-NET
    if [ $(nmcli device wifi | grep -c "$wifi_nm") -eq 1 ]
    then
        echo "Connected to NITK-NET"
        if [ "$(nmcli -g connectivity general status)" == "portal" ]
        then
        echo "Not logged in"
        exit 1
        fi
        if [ "$(nmcli -g connectivity general status)" == "full" ]
        then 
        echo "Logged in and connected to the internet"
        exit 1
        fi
    else
        echo "Not connected to NITK-NET"
        exit 1
    fi
fi

# If login.txt exists, then read username and password from it
if [ -f "$file_path" ]; then
    USERNAME=$(sed -n 1p "$file_path")
    PASSWORD=$(sed -n 2p "$file_path")
else
    echo "Enter username: "
    read -r USERNAME
    echo "Enter password: "
    read -r PASSWORD
    # Store username and password in login.txt
    echo "$USERNAME" > "$file_path"
    echo "$PASSWORD" >> "$file_path"
    chmod -x -w "$file_path"
fi

if [ $wifi_stat == "disabled" ]
then
    curl --data "mode=191&username=${USERNAME}&password=${PASSWORD}&a=1683446146445&producttype=0" $URL 

    if [ "$(nmcli -g connectivity general status)" == "full" ]
    then
        exit 1
    fi

else 
    # connect to NITK-NET
    if [ -z $(nmcli device wifi | grep -c "$wifi_nm") ]
    then
        echo "Connecting to NITK-NET"
        nmcli device wifi connect $wifi_nm password $wifi_pwd
        until [ "$(nmcli -g connectivity general status)" == "full" ]
    do
        curl --data "mode=191&username=${USERNAME}&password=${PASSWORD}&a=1683446146445&producttype=0" $URL
        sleep 1
    done
    else
        echo "NITK-NET not found"
        exit 1
    fi    
fi