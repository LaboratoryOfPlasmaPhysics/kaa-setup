
ARG HUB_VERSION=1.4.2
FROM registry.lpp.polytechnique.fr/lpp/jupyter-notebok-base:hub-$HUB_VERSION

USER root

ADD https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz /tmp/cdf38_0-dist-all.tar.gz

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends make gcc g++ gfortran libncurses-dev pkg-config  rsync wakeonlan netdata && \
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
RUN pip3 install git+https://github.com/spedas/pyspedas git+https://github.com/MAVENSDC/PyTplot py_tsyganenko && \
    pip3 install meson ninja spwc==0.8.2 pint &&\
    FC_VENDOR=gfortran pip3 install \
              ffnet git+https://github.com/SciQLop/speasy && \
    git clone https://github.com/LaboratoryOfPlasmaPhysics/LFR_Flight_Software && \
    meson LFR_Flight_Software build-LFR_Flight_Software && \
    cd build-LFR_Flight_Software && ninja && ninja install && cd .. && \
    rm -rf LFR_Flight_Software build-LFR_Flight_Software && \
    git clone https://github.com/spacepy/spacepy /tmp/spacepy && \
    cd /tmp/spacepy && FC_VENDOR=gfortran python setup.py install && rm -rf /tmp/spacepy && cd - && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

ADD --chown=${NB_UID}:${NB_UID} tests /tmp/tests

RUN cd /tmp/tests && python /tmp/tests/all.py && cd / && rm -rf /tmp/tests

WORKDIR "${HOME}"
