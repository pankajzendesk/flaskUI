#!/bin/bash

# Usage:
# ./run_docker.sh USERNAME CONTAINER_NAME PORT_NO GPU MEMORY CPU

if [ "$#" -ne 6 ]; then
    echo "Usage: $0 USERNAME CONTAINER_NAME PORT_NO GPU MEMORY CPU"
    exit 1
fi

USERNAME=$1
CONTAINER_NAME=$2
PORT_NO=$3
GPU=$4
MEMORY=$5
CPU=$6

docker run -p $PORT_NO:80 \
    -e USERNAME="$USERNAME" \
    -e CONTAINER_NAME="$CONTAINER_NAME" \
    -e PORT_NO="$PORT_NO" \
    -e GPU="$GPU" \
    -e MEMORY="$MEMORY" \
    -e CPU="$CPU" \
    flask-docker-app:v1
