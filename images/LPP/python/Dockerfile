
ARG HUB_VERSION=2.3.1
FROM registry.lpp.polytechnique.fr/lpp/jupyter-notebok-base:hub-$HUB_VERSION


USER root

ADD https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_1/cdf38_1-dist-all.tar.gz /tmp/cdf38_1-dist-all.tar.gz

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends make gcc g++ gfortran libncurses-dev pkg-config && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    tar -xf cdf38_1-dist-all.tar.gz && \
    cd cdf38_1-dist && \
    make OS=linux ENV=gnu CURSES=yes FORTRAN=no UCOPTIONS=-O2 SHARED=yes all && \
    make INSTALLDIR=/usr/local/cdf install  && \
    cd / && rm -rf /tmp/cdf* 
    #sed -i 's/Distributed under the terms of the Modified BSD License\./Distributed under the terms of the Modified BSD License\.\nsource \/opt\/conda\/bin\/activate base/' /usr/local/bin/start.sh


USER ${NB_UID}

COPY --chown=${NB_UID} envs /tmp/envs

RUN cd /tmp/envs && bash install.sh && cd / && rm -rf /tmp/envs && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

WORKDIR "${HOME}"