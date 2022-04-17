
ARG HUB_VERSION=1.4.2
FROM lpp/jupyter-notebok-base:hub-$HUB_VERSION

USER root

RUN apt-get update --yes && \
    apt install -y curl meson cmake libhdf5-openmpi-dev openmpi-common openmpi-bin libopenmpi-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://code-server.dev/install.sh | sh

USER ${NB_UID}


# Install Python 3 packages
RUN pip3 install --upgrade pip && \
    pip3 install git+https://github.com/betatim/vscode-binder 'jupyter-server-proxy' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" 


WORKDIR "${HOME}"
