#!/bin/bash

git clone https://github.com/LaboratoryOfPlasmaPhysics/LFR_Flight_Software
meson LFR_Flight_Software build-LFR_Flight_Software
cd build-LFR_Flight_Software
ninja
ninja install 
cd .. 
rm -rf LFR_Flight_Software build-LFR_Flight_Software

git clone https://github.com/spacepy/spacepy /tmp/spacepy
cd /tmp/spacepy 
FC_VENDOR=gfortran /opt/conda/envs/space/bin/python setup.py install 
rm -rf /tmp/spacepy