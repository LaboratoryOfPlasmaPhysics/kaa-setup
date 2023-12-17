
ARG HUB_VERSION=4.0.2
FROM jupyter/minimal-notebook:hub-$HUB_VERSION

USER root

SHELL ["/bin/bash", "--login", "-c"]

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends curl rsync wget make gcc g++ gfortran xvfb pkg-config git bash-completion \
    vim vim-addon-manager vim-python-jedi vim-scripts vim-snippets vim-youcompleteme zlib1g-dev yarn 'texlive-*' \
    build-essential libbz2-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev tk-dev autoconf autotools-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 
    
RUN  sed -i '4i Xvfb :1 &' /usr/local/bin/start.sh && head /usr/local/bin/start.sh

USER ${NB_UID}

RUN mamba init bash

#ENV CONDA_ENVS_PATH="~/.conda/envs"
ENV QT_QPA_PLATFORM="offscreen"
ENV DISPLAY=":1"

COPY jupyter_config.py /etc/jupyter/jupyter_config.py
COPY ipympl_vers.sh /opt/

# Install Extensions
RUN source /opt/ipympl_vers.sh && pip3 install --upgrade pip && \
              pip3 install --no-deps "ipympl==$IPYMPL_VER" &&\
              pip3 install \
              lckr_jupyterlab_variableinspector black isort \
              jupyterlab-unfold \
              ipyparallel \
              jupyterlab_templates jupyterlab-code-formatter 'tqdm>=4.64.1' \
              "ipywidgets==$IPW_VER" "matplotlib>=$MIN_MPL_VER" && \
    mamba install --quiet --yes \
    'automake' \
    'ipyevents' \
    'jupyterlab-h5web' \
    'jupyter-archive' \
    'jupyterlab-spellchecker' \
    'texlab' \
    'chktex' \
    'jupyterlab-git'  \
    'jupyterlab_execute_time' \
    'nb_conda_kernels'  \
    'jupyterlab>=4.0.9'\
    'notebook>=7.0.6' \
    && \
    rm -rf /opt/conda/share/jupyter/kernels/ && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
COPY extensions_config.py /tmp/extensions_config.py
RUN /opt/conda/bin/python3 /tmp/extensions_config.py 

USER ${NB_UID}

WORKDIR "${HOME}"
