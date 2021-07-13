FROM jupyter/scipy-notebook:hub-1.4.1

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



USER ${NB_UID}

# Install Python 3 packages
RUN FC_VENDOR=gfortran pip install ffnet spwc  spacepy pandas_profiling seaborn && \
    conda install --quiet --yes \
    'networkx' \
    'xeus>=1.0.4' \
    'xeus-python==0.12.*' \
    'xeus-cling' \
    'jupyterlab-git'  \
    'python-lsp-server' \
    'jedi-language-server' \
    'ipyvolume' \
    'seaborn' \
    'ipyleaflet' \
    'mplleaflet' \
    'cppyy' \
    'jupyterlab-lsp' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

ADD --chown=${NB_UID}:${NB_UID} tests /tmp/tests

RUN cd /tmp/tests && python /tmp/tests/all.py && cd / && rm -rf /tmp/tests

WORKDIR "${HOME}"
