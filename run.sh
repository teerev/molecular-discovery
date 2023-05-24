#!/bin/bash

# The name of the Docker container
CONTAINER_NAME="rdkit_jupyter"

# The name of the Docker image
IMAGE_NAME="rdkit-jupyter"

# Check if the Docker container exists
if [ $(docker ps -a -f "name=$CONTAINER_NAME" --format '{{.Names}}') = "$CONTAINER_NAME" ]; then
    echo "Container exists. Starting..."
    docker start $CONTAINER_NAME
else
    echo "Container doesn't exist. Building image, creating container, and starting JupyterLab..."
    docker build -t $IMAGE_NAME .
    docker run -p 8888:8888 -v "$(pwd)":/home -d --name $CONTAINER_NAME $IMAGE_NAME
fi

# Wait for JupyterLab to start and display the URL with token
echo "Waiting for JupyterLab to start..."
while true; do
    LOG=$(docker logs $CONTAINER_NAME 2>&1 | grep "http://")
    if [[ -n "$LOG" ]]; then
        echo "JupyterLab started. You can access it at the following URL:"
        echo "$LOG"
        break
    fi
    sleep 1
done
