FROM continuumio/miniconda3:master-alpine

LABEL image.author.name "truongnguyen"
LABEL image.author.email "truongnguyen@vietkite.com"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache tzdata
ENV TZ=Asia/Saigon
RUN date \
    && ln -s /usr/share/zoneinfo/${TZ} /etc/localtime 

RUN apk add curl vim fortune git wget unzip zip zsh bash openjdk11

RUN cd /usr/local/bin \
    && curl -s https://get.nextflow.io | bash \
    && chmod +x nextflow

RUN pip install --upgrade --force-reinstall git+https://github.com/nf-core/tools.git@dev \
    && echo 'eval "$(_NF_CORE_COMPLETE=bash_source nf-core)"' >> ~/.bashrc

RUN apk add singularity --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    && apk add docker openrc \
    && rc-update add docker boot
