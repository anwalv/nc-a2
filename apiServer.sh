#!/bin/bash


handle_client() {
    read -r client_message
    if [[ "$client_message" == "Aloha!" ]]; then
        echo "Oh, no."
    else
        echo "Unexpected handshake. Closing connection."
        return
    fi

    read -r client_name
    if [[ "$client_name" =~ ^My\ name\ is\  ]]; then
        echo "And broadcast address of your network?"
    else
        echo "Invalid name format."
        return
    fi

    read -r client_ip
    echo "Ready."

    while true; do
        read -r command

        if [[ "$command" == "bye" ]]; then
            echo "Goodbye!"
            break
        fi

        
        case $command in
            GetMountsHigherThan*)
                height=$(echo "$command" | awk '{print $2}')
                if ! [[ "$height" =~ ^[0-9]+$ ]]; then
                    echo "Invalid height."
                    continue
                fi
                response=$(awk -F ';' -v h="$height" '$3 > h {print $1, $2, $3}' db.txt | wc -l)
                echo "$response"
                if [[ "$response" -gt 0 ]]; then
                    awk -F ';' -v h="$height" '$3 > h {print $1, $2, $3}' db.txt
                fi
                ;;

            GetMountInfo*)
                mount_name=$(echo "$command" | awk '{print $2}')
                response_count=$(grep -E "^$mount_name;" db.txt | wc -l)
                echo "$response_count"
                if [[ "$response_count" -gt 0 ]]; then
                    grep -E "^$mount_name;" db.txt
                fi
                ;;
            *)
                echo "Unknown command."
                ;;
        esac
    done
}

socat TCP-LISTEN:4242,reuseaddr,fork - | while read -r line; do
    handle_client <<< "$line"
done
