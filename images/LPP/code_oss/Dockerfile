
ARG HUB_VERSION=4.0.2
FROM registry.lpp.polytechnique.fr/lpp/jupyter-notebok-base:hub-$HUB_VERSION

ENV OMPI_MCA_opal_cuda_support=true

USER root
COPY  add_kernel_entry.sh /tmp/
COPY  start_vscode.sh /usr/local/bin/

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends libffi-dev gdb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN bash /tmp/add_kernel_entry.sh && rm /tmp/add_kernel_entry.sh && chmod +x /usr/local/bin/start_vscode.sh

USER ${NB_UID}

COPY --chown=${NB_UID} envs /tmp/envs

RUN cd /tmp/envs && bash install.sh && cd / && rm -rf /tmp/envs 

RUN mamba install --quiet --yes jupyter-server-proxy && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"



WORKDIR "${HOME}"
