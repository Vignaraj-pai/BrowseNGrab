#!/bin/bash

wifi_nm="NITK-NET"
wifi_pwd="2K16NITK"

URL="https://nac.nitk.ac.in:8090/httpclient.html"

file_path="$HOME/.config/browsengrab/nitk/login.txt"

# Function to log in to NITK-NET
login() {
    USERNAME=$(sed -n 1p "$file_path")
    PASSWORD=$(sed -n 2p "$file_path")
    
    curl --data "mode=191&username=${USERNAME}&password=${PASSWORD}&a=1683446146445&producttype=0" $URL
}

# Function to check network status
check_network_status() {
    nmcli_dev_status=$(nmcli -g general.connection device show wlan0)
    nmcli_con_status=$(nmcli -g general.status connection show "$wifi_nm")
    
    if [[ $nmcli_dev_status == "connected" && $nmcli_con_status == "portal" ]]; then
        echo "Network status: Portal"
        login
    elif [[ $nmcli_dev_status == "connected" && $nmcli_con_status == "full" ]]; then
        echo "Network status: Full"
    else
        echo "Network status: Not connected or unknown"
    fi
}

# Loop to continuously check network status
while true; do
    check_network_status
    sleep 60  # Delay between checks (in seconds)
done
