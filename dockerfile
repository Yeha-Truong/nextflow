# FROM nextflow/nextflow
# FROM quay.io/singularity/singularity:v3.11.0-slim
FROM --platform=x86_64 alpine:edge

COPY --link . /work

LABEL image.author.name "truongnguyen"
LABEL image.author.email "truongnguyen@vietkite.com"

# SHELL ["/bin/bash", "-c"]

RUN apk add --no-cache tzdata
ENV TZ=Asia/Saigon

RUN date \
    && ln -s /usr/share/zoneinfo/${TZ} /etc/localtime 

RUN cat /etc/os-release \
    && apk update \
    && apk upgrade \
    && apk add curl vim fortune git wget unzip zip zsh openjdk11 bash \
    && curl -s "https://get.sdkman.io" | bash 
# RUN cat /etc/os-release && /bin/bash -c && exit 0 && "source /root/.sdkman/bin/sdkman-init.sh;sdk install java" \
#     && java --version 
RUN cd /usr/local/bin \
    && curl -s https://get.nextflow.io | bash \
    && chmod +x nextflow 

# RUN curl -fsSL https://get.docker.com | sh
RUN apk add singularity --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    && apk add docker openrc \
    && rc-update add docker boot 

# RUN chmod  -R 777 /root


WORKDIR /work

