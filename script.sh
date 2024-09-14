#!/bin/bash

# Usage:
# ./run_docker.sh USERNAME CONTAINER_NAME GPU MEMORY CPU

if [ "$#" -ne 5 ]; then
    echo "Usage: $0 USERNAME CONTAINER_NAME CPU MEMORY GPU"
    exit 1
fi

USERNAME=$1
CONTAINER_NAME=$2
CPU=$3
MEMORY=$4
GPU=$5

# Function to find an available port between 8000 and 9999
find_available_port() {
    for port in {8000..9999}; do
        # Check if the port is available
        (echo >/dev/tcp/localhost/$port) &>/dev/null
        if [ $? -ne 0 ]; then
            echo $port
            return
        fi
    done
    echo "No available port found between 8000 and 9999" >&2
    exit 1
}

PORT_NO=$(find_available_port)
echo "Port is $PORT_NO"
# Run the Docker container with the provided parameters and environment variables
docker run -p $PORT_NO:80 \
    -e USERNAME="$USERNAME" \
    -e GPU="$GPU" \
    -e MEMORY="$MEMORY" \
    -e CPU="$CPU" \
    -e PORT_NO="$PORT_NO" \
    -e CONTAINER_NAME="$CONTAINER_NAME" \
    --name "$CONTAINER_NAME" \
    flask-docker-app:v1

echo "Container $CONTAINER_NAME is running on port $PORT_NO."
