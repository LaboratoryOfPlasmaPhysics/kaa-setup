
ARG HUB_VERSION=1.4.2
FROM jupyter/scipy-notebook:hub-$HUB_VERSION

USER root

RUN apt-get update --yes && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${NB_UID}

ENV CONDA_ENVS_PATH="~/.conda/envs"
ENV QT_QPA_PLATFORM="offscreen"

# Install Python packages 
RUN pip3 install --upgrade pip && \
    pip3 install seaborn peakutils shapely "python-lsp-server[all]"  &&\
    conda install --quiet --yes \
    'xeus==2.4.1' \
    'xeus-python==0.13.*' \
    'xeus-cling' \
    'ipyvolume' \
    'plotly' \
    'ipyleaflet' \
    'mplleaflet' 

# Install Extensions
RUN pip3 install py-heat-magic  \
              https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master \
              hdf5plugin jupyterlab_hdf jupyter_nbextensions_configurator lckr-jupyterlab-variableinspector \
              jupyterlab-drawio jupyterlab_latex jupyterlab-spellchecker ipyparallel "elyra[all]>=3.7.0" && \
    jupyter contrib nbextension install --sys-prefix &&\
    jupyter labextension install jupyterlab-spreadsheet &&\
    jupyter labextension install @jupyterlab/hdf5 && \
    jupyter nbextensions_configurator enable &&\
    conda install --quiet --yes -c glueviz glueviz=1.2 && \
    conda install --quiet --yes \
    'texlab' \
    'chktex' \
    'jupyterlab-git'  \
    'jupyterlab_execute_time' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

COPY extensions_config.py /tmp/extensions_config.py
RUN /opt/conda/bin/python3 /tmp/extensions_config.py

USER ${NB_UID}

WORKDIR "${HOME}"
