
ARG HUB_VERSION=2.3.1
FROM jupyter/minimal-notebook:hub-$HUB_VERSION

USER root

SHELL ["/bin/bash", "--login", "-c"]

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends curl wget make gcc g++ gfortran pkg-config git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}

RUN mamba init bash

#ENV CONDA_ENVS_PATH="~/.conda/envs"
ENV QT_QPA_PLATFORM="offscreen"

COPY jupyter_config.py /etc/jupyter/jupyter_config.py
COPY ipympl_vers.sh /opt/

# Install Extensions
RUN source /opt/ipympl_vers.sh && pip3 install --upgrade pip && pip3 install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master \
              hdf5plugin jupyterlab_hdf jupyter_nbextensions_configurator lckr-jupyterlab-variableinspector \
              jupyterlab-drawio jupyterlab_latex jupyterlab-spellchecker ipyparallel "elyra[all]>=3.7.0" \
              "ipywidgets==$IPW_VER" "ipympl==$IPYMPL_VER" "matplotlib>=$MIN_MPL_VER"  && \
    jupyter contrib nbextension install --sys-prefix &&\
    jupyter labextension install jupyterlab-spreadsheet &&\
    jupyter labextension install @jupyterlab/hdf5 && \
    jupyter nbextensions_configurator enable &&\
    mamba install --quiet --yes \
    'texlab' \
    'chktex' \
    'jupyterlab-git'  \
    'jupyterlab_execute_time' \
    'nb_conda_kernels'  && \
    rm -rf /opt/conda/share/jupyter/kernels/ && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
COPY extensions_config.py /tmp/extensions_config.py
RUN /opt/conda/bin/python3 /tmp/extensions_config.py 

USER ${NB_UID}

WORKDIR "${HOME}"
