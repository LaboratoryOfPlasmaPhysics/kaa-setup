#!/usr/bin/bash
HUB_VERSION=${2:-"4.0.2"}
REGISTRY=${1:-"129.104.6.172:32219"}
IMAGE="lpp/jupyter-notebok-code_oss"
echo "Will build $IMAGE for dockerhub version: $HUB_VERSION and push on registry: $REGISTRY"
FULL_NAME="${REGISTRY}/${IMAGE}:hub-${HUB_VERSION}"

if hash podman 2>/dev/null; then
    podman build --pull --format docker --build-arg HUB_VERSION=$HUB_VERSION -t ${FULL_NAME} .
    podman push ${FULL_NAME}
else
    docker build --pull --build-arg HUB_VERSION=$HUB_VERSION -t ${FULL_NAME} .
    docker push ${FULL_NAME}
fi