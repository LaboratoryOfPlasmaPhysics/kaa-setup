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
    cd / && rm -rf /tmp/cdf*


USER ${NB_UID}

# Install Python 3 packages
RUN FC_VENDOR=gfortran pip install ffnet spwc  spacepy && \
    conda install --quiet --yes \
    'networkx'  && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

WORKDIR "${HOME}"