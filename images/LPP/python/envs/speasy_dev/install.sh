#!/bin/bash
source /opt/ipympl_vers.sh
echo IPW_VER $IPW_VER
sed -i s/IPW_VER/$IPW_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/IPYMPL_VER/$IPYMPL_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/MIN_MPL_VER/$MIN_MPL_VER/ $( dirname -- "$0"; )/environment.yml 

mamba env create -f $( dirname -- "$0"; )/environment.yml 

mamba run -n speasy_dev /bin/bash $( dirname -- "$0"; )/install_post.sh
mamba run -n speasy_dev /opt/conda/envs/speasy_dev/bin/python  $( dirname -- "$0"; )/tests/all.py
cp $( dirname -- "$0"; )/logo-*.png /opt/conda/envs/speasy_dev/share/jupyter/kernels/python3/