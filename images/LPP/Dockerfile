
ARG HUB_VERSION=1.4.1
FROM jupyter/scipy-notebook:hub-$HUB_VERSION

USER root

ADD https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz /tmp/cdf38_0-dist-all.tar.gz

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends make gcc gfortran libncurses-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    tar -xf cdf38_0-dist-all.tar.gz && \
    cd cdf38_0-dist && \
    make OS=linux ENV=gnu CURSES=yes FORTRAN=no UCOPTIONS=-O2 SHARED=yes all && \
    make INSTALLDIR=/usr/local/cdf install  && \
    cd / && rm -rf /tmp/cdf* && \
    sed -i 's/Distributed under the terms of the Modified BSD License\./Distributed under the terms of the Modified BSD License\.\nsource \/opt\/conda\/bin\/activate base/' /usr/local/bin/start.sh


ENV CONDA_ENVS_PATH="~/.conda/envs"

USER ${NB_UID}

# Install Python 3 packages
RUN FC_VENDOR=gfortran pip install \
              ffnet spwc==0.8.2  spacepy pandas_profiling seaborn SALib isc_dhcp_leases \
              LightPipes handcalcs geopack PyGeopack peakutils pint pyspedas \
              https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master \
              pytplot hdf5plugin jupyterlab_hdf jupyter_nbextensions_configurator && \
    jupyter contrib nbextension install --sys-prefix &&\
    jupyter nbextensions_configurator enable &&\
    conda install --quiet --ye -c glueviz glueviz && \
    conda install --quiet --yes \
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
    'k3d' \
    'ipyleaflet' \
    'mplleaflet' \
    'ipyvolume' \
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
