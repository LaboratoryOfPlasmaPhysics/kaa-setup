#!/usr/bin/sh

cd gpu && sh build_and_push.sh; cd ..
cd hpc && sh build_and_push.sh; cd ..
cd space && sh build_and_push.sh; cd ..