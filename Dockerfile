FROM python:3.6-slim-buster

ENV WORKDIR=/snipspg

RUN apt-get update && apt-get install -y curl
RUN groupadd -g 1001 nlu_user && useradd -r -m -u 1001 -g nlu_user nlu_user

RUN mkdir ${WORKDIR}

RUN chown -R nlu_user:nlu_user ${WORKDIR}
USER nlu_user

WORKDIR ${WORKDIR}
COPY pip.conf /home/nlu_user/.pip/pip.conf
COPY . ${WORKDIR}/

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && /bin/bash -c "source $HOME/.cargo/env && python3.6 -m pip install  --user setuptools_rust==0.8.4"
