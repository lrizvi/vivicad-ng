FROM docker.io/mambaorg/micromamba:1.4.9
MAINTAINER rizvi.mu@northeastern.edu
EXPOSE 8888

COPY --chown=$MAMBA_USER:$MAMBA_USER env.yml /tmp/env.yml
RUN micromamba install -y -n base -f /tmp/env.yml && \
    micromamba clean --all --yes

CMD jupyter lab --ip 0.0.0.0 --no-browser --NotebookApp.token='' --NotebookApp.password='' /mnt
