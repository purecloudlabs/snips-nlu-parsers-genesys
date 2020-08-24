FROM python:3.6-slim-buster

ENV WORKDIR=/snipspg

RUN mkdir ${WORKDIR}

RUN chown -R nlu_user:nlu_user ${WORKDIR}
USER nlu_user

WORKDIR ${WORKDIR}
COPY pip.conf /home/nlu_user/.pip/pip.conf
COPY python ${WORKDIR}/

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && source $HOME/.cargo/env \
    && python3.6 -m pip install  --user setuptools_rust==0.8.4 \
    && python3.6 python/setup.py bdist_wheel upload -r inin-pypi
