#!/bin/bash
source /opt/ipympl_vers.sh
sed -i s/IPW_VER/$IPW_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/IPYMPL_VER/$IPYMPL_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/MIN_MPL_VER/$MIN_MPL_VER/ $( dirname -- "$0"; )/environment.yml 
mamba env create -f $( dirname -- "$0"; )/environment.yml 
mamba run -n machine_learning /opt/conda/envs/machine_learning/bin/python  $( dirname -- "$0"; )/tests/all.py
cp $( dirname -- "$0"; )/logo-*.png /opt/conda/envs/machine_learning/share/jupyter/kernels/python3/