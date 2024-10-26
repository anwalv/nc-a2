#!/bin/bash

sudo apt update
sudo apt install -y socat

sudo cp apiServer.sh /usr/bin/
sudo chmod +x /usr/bin/apiServer.sh

sudo cp apiService.service /etc/systemd/system/

sudo systemctl enable apiService.service
sudo systemctl start apiService.service
