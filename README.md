# Simple TCP Server with Custom Protocol

This project implements a simple TCP server using the `socat` utility and a bash script that supports a custom protocol for client-server communication. The server handles a handshake procedure and provides an API for querying mountain data from a simple text-based database.

## Components

- **apiServer.sh**: The main server script that handles client connections and requests.
- **apiClient.sh**: The client script that allows users to interact with the server.
- **apiService.service**: A systemd service file for managing the server script as a service.
- **db.txt**: A text file containing mountain data in a CSV-like format.
- **configureServer.sh**: A script for installing dependencies and setting up the server.

## Installation Instructions

To set up the entire solution on a fresh multipass Ubuntu VM, follow these steps:

1. **Launch a new multipass VM**:
   ```bash
   multipass launch --name my-vm --mem 2G --disk 20G
   multipass shell my-vm
   Copy the files:
   apiServer.sh
   apiClient.sh
   apiService.service
   db.txt
   configureServer.sh

   Run the configuration script:
   chmod +x configureServer.sh
   ./configureServer.sh
   
   Run the Client Script:
   ./apiClient.sh 
