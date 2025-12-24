#!/bin/bash

echo "Deployment is starting"

docker pull $DOCKER_USERNAME/group_e:v1

echo "Stopping old container if it exists"
docker stop group_e_container || true
docker rm group_e_container || true

echo "Starting new container"

docker run -d \
  --name group_e_container \
  -p 8087:8000 \
  $DOCKER_USERNAME/group_e:v1

echo "Deployment is successful"