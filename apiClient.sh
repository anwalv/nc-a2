#!/bin/bash

exec 3<>/dev/tcp/localhost/4242 || { echo "Failed to connect to server"; exit 1; }

echo "Aloha!" >&3
echo "Aloha!"
read -r server_message <&3
echo "$server_message"

read -p "Please enter your name: " user_name
echo "My name is $user_name" >&3
read -r server_message <&3
echo "$server_message"

read -p "Enter your IP address: " ip_address
echo "$ip_address" >&3
read -r server_message <&3
echo "$server_message"

while true; do
    read -p "Enter command (GetMountsHigherThan <height>, GetMountInfo <mount_name>, bye): " command
    if [[ "$command" == "exit" ]]; then
        echo "bye" >&3
        read -r server_message <&3
        echo "$server_message"
        echo "May the Force be with you!"
        break
    fi
    echo "$command" >&3
    read -r response_count <&3
    if [[ "$response_count" == "0" ]]; then
        echo "No data"
    elif [[ "$response_count" =~ ^[1-9]+$ ]] || [[ "$response_count" =~ ";" ]]; then
        echo "Response:"
        for ((i=0; i<response_count; i++)); do
            read -r response_line <&3
            echo "$response_line"
        done
    else
        echo "Unexpected response: $response_count"
    fi
done

