#!/bin/bash
source /opt/ipympl_vers.sh
sed -i s/IPW_VER/$IPW_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/IPYMPL_VER/$IPYMPL_VER/ $( dirname -- "$0"; )/environment.yml 
sed -i s/MIN_MPL_VER/$MIN_MPL_VER/ $( dirname -- "$0"; )/environment.yml 
mamba env create -f $( dirname -- "$0"; )/environment.yml

mamba run -n tensorflow /opt/conda/envs/tensorflow/bin/python  $( dirname -- "$0"; )/tests/all.py
cp $( dirname -- "$0"; )/logo-*.png /opt/conda/envs/tensorflow/share/jupyter/kernels/python3/
mkdir -p /opt/conda/envs/tensorflow/lib/nvvm/libdevice
cp /opt/conda/envs/tensorflow/lib/libdevice.10.bc /opt/conda/envs/tensorflow/lib/nvvm/libdevice/libdevice.10.bc
echo '#!/bin/sh' >> /opt/conda/envs/tensorflow/etc/conda/activate.d/env_vars.sh
echo '#!/bin/sh' >> /opt/conda/envs/tensorflow/etc/conda/deactivate.d/env_vars.sh
chmod +x /opt/conda/envs/tensorflow/etc/conda/deactivate.d/env_vars.sh
chmod +x /opt/conda/envs/tensorflow/etc/conda/activate.d/env_vars.sh
echo 'export CUDNN_PATH=/opt/conda/envs/tensorflow/lib/python3.10/site-packages/nvidia/cudnn/' >> /opt/conda/envs/tensorflow/etc/conda/activate.d/env_vars.sh
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/conda/envs/tensorflow/lib/:$CUDNN_PATH/lib"' >> /opt/conda/envs/tensorflow/etc/conda/activate.d/env_vars.sh
echo 'export XLA_FLAGS="--xla_gpu_cuda_data_dir=/opt/conda/envs/tensorflow/lib/"' >> /opt/conda/envs/tensorflow/etc/conda/activate.d/env_vars.sh