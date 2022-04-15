
ARG HUB_VERSION=1.4.2
FROM lpp/jupyter-notebok-base:hub-$HUB_VERSION

USER ${NB_UID}

# Install Python 3 packages
RUN pip3 install --upgrade pip && \
    FC_VENDOR=gfortran pip3 install tensorflow-gpu &&\
    conda install --quiet --yes \
    'cupy' \
    'cudatoolkit' \
    'cudnn' \
    'pkg-config' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

ADD --chown=${NB_UID}:${NB_UID} tests /tmp/tests

RUN cd /tmp/tests && python /tmp/tests/all.py && cd / && rm -rf /tmp/tests

WORKDIR "${HOME}"
