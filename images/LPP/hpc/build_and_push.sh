#!/usr/bin/bash
HUB_VERSION=${2:-"2.2.2"}
REGISTRY=${1:-"129.104.6.165:32219"}
IMAGE="lpp/jupyter-notebok-hpc"
echo "Will build $IMAGE for dockerhub version: $HUB_VERSION and push on registry: $REGISTRY"
FULL_NAME="${REGISTRY}/${IMAGE}:hub-${HUB_VERSION}"
docker build --build-arg HUB_VERSION=$HUB_VERSION -t ${FULL_NAME} .
docker push ${FULL_NAME}
