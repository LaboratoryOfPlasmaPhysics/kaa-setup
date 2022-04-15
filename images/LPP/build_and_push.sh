#!/usr/bin/bash
HUB_VERSION=${2:-"2.2.2"}
REGISTRY=${1:-"129.104.6.165:32219"}
echo "Will build images for dockerhub version: $HUB_VERSION and push on registry: $REGISTRY"

cd base && bash build_and_push.sh $REGISTRY $HUB_VERSION; cd ..
cd gpu && bash build_and_push.sh $REGISTRY $HUB_VERSION; cd ..
cd hpc && bash build_and_push.sh  $REGISTRY $HUB_VERSION; cd ..
cd space && bash build_and_push.sh $REGISTRY $HUB_VERSION; cd ..