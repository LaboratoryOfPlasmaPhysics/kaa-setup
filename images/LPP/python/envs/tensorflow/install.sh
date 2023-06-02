#!/bin/bash
source /opt/ipympl_vers.sh
sed -i s/IPW_VER/$IPW_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/IPYMPL_VER/$IPYMPL_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/MIN_MPL_VER/$MIN_MPL_VER/ $( dirname -- "$0"; )/environment.yml 
CONDA_OVERRIDE_CUDA="11.7.1" mamba env create -f $( dirname -- "$0"; )/environment.yml 

mamba run -n tensorflow /opt/conda/envs/tensorflow/bin/python  $( dirname -- "$0"; )/tests/all.py
cp $( dirname -- "$0"; )/logo-*.png /opt/conda/envs/tensorflow/share/jupyter/kernels/python3/
