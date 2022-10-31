#!/bin/bash
APP_NAME="tb-gateway"
APP_TAG="0.1.0"

echo "$DOCKER_REGISTRY_PASSWORD" | docker login -u "$DOCKER_REGISTRY_USERNAME" --password-stdin "$DOCKER_REGISTRY"

export DOCKER_CLI_EXPERIMENTAL=enabled
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# docker buildx create --name mybuilder
docker buildx use mybuilder

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag "$DOCKER_REGISTRY/$DOCKER_REGISTRY_USERNAME/$APP_NAME:$APP_TAG" \
  --tag "$DOCKER_REGISTRY/$DOCKER_REGISTRY_USERNAME/$APP_NAME:latest" \
  --push .
