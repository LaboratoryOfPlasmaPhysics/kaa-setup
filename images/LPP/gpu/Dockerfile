
ARG HUB_VERSION=1.4.2
FROM jupyter/scipy-notebook:hub-$HUB_VERSION

USER ${NB_UID}

ENV CONDA_ENVS_PATH="~/.conda/envs"
ENV QT_QPA_PLATFORM="offscreen"

# Install Python 3 packages
RUN pip3 install --upgrade pip && \
    FC_VENDOR=gfortran pip install py-heat-magic seaborn peakutils shapely tensorflow-gpu \
              https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master \
              hdf5plugin jupyterlab_hdf jupyter_nbextensions_configurator lckr-jupyterlab-variableinspector && \
    jupyter contrib nbextension install --sys-prefix &&\
    jupyter nbextensions_configurator enable &&\
    conda install --quiet --yes -c glueviz glueviz && \
    conda install --quiet --yes \
    'cupy' \
    'cudatoolkit' \
    'cudnn' \
    'pkg-config' \
    'networkx' \
    'xeus>=1.0.4' \
    'xeus-python==0.12.*' \
    'xeus-cling' \
    'jupyterlab-git'  \
    'python-lsp-server' \
    'jedi-language-server' \
    'jupyterlab_execute_time' \
    'mamba_gator' \
    'ipyvolume' \
    'plotly' \
    'ipyleaflet' \
    'mplleaflet' \
    'cppyy' \
    'jupyterlab-lsp' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

COPY extensions_config.py /tmp/extensions_config.py
RUN /opt/conda/bin/python3 /tmp/extensions_config.py

USER ${NB_UID}

ADD --chown=${NB_UID}:${NB_UID} tests /tmp/tests

RUN cd /tmp/tests && python /tmp/tests/all.py && cd / && rm -rf /tmp/tests

WORKDIR "${HOME}"
