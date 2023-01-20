#!/usr/bin/bash
HUB_VERSION=${2:-"2.3.1"}
REGISTRY=${1:-"129.104.6.172:32219"}
echo "Will build images for dockerhub version: $HUB_VERSION and push on registry: $REGISTRY"

cd base && bash build_and_push.sh $REGISTRY $HUB_VERSION; cd ..
cd python && bash build_and_push.sh $REGISTRY $HUB_VERSION; cd ..
cd code_oss && bash build_and_push.sh $REGISTRY $HUB_VERSION; cd ..

