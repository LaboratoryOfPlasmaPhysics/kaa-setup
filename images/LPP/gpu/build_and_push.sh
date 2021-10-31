#!/usr/bin/sh
HUB_VERSION=1.4.2
REGISTRY=${2:-"129.104.6.165:32219"}
IMAGE="lpp/jupyter-notebok-gpu"
FULL_NAME="${REGISTRY}/${IMAGE}:hub-${HUB_VERSION}"
docker build --build-arg HUB_VERSION=$HUB_VERSION -t ${FULL_NAME} .
docker push ${FULL_NAME}
