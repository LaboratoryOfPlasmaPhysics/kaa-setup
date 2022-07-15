#!/bin/bash
source /opt/ipympl_vers.sh
sed -i s/IPW_VER/$IPW_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/IPYMPL_VER/$IPYMPL_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/MIN_MPL_VER/$MIN_MPL_VER/ $( dirname -- "$0"; )/environment.yml 
CONDA_OVERRIDE_CUDA="11.4.2" mamba env create -f $( dirname -- "$0"; )/environment.yml 
#curl -fsSL https://code-server.dev/install.sh > /tmp/install.sh
#mamba run -n vscode bash /tmp/install.sh
