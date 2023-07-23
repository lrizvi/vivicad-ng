FROM docker.io/mambaorg/micromamba:1.4.9
MAINTAINER rizvi.mu@northeastern.edu
EXPOSE 8888

COPY --chown=$MAMBA_USER:$MAMBA_USER . /tmp

RUN micromamba install -y -n base -f /tmp/environment.yaml && \
    micromamba clean --all --yes

RUN eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate base && \
    pip install /tmp

CMD jupyter lab --ip 0.0.0.0 --no-browser --NotebookApp.token='' --NotebookApp.password='' /mnt
