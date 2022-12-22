# syntax=docker/dockerfile:1.3
FROM debian:11.6-slim

ARG TARGETPLATFORM

RUN --mount=type=cache,target=/var/cache/apt,id=${TARGETPLATFORM} --mount=type=cache,target=/var/lib/apt,id=${TARGETPLATFORM} apt-get update && \
    apt-get --no-install-recommends install -y bzip2 ca-certificates curl mariadb-client unzip

RUN if [ ${TARGETPLATFORM} = "linux/amd64" ]; \
    then curl -sSL -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip; \
    else curl -sSL -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip; fi && \
    unzip -q awscliv2.zip && \
    ./aws/install && \
    rm -fr aws

RUN --mount=type=cache,target=/var/cache/apt,id=${TARGETPLATFORM} --mount=type=cache,target=/var/lib/apt,id=${TARGETPLATFORM} apt-get remove --purge -y curl unzip && \
    apt-get autoremove -y

COPY backup.sh /usr/local/bin/

USER 65534:65534

ENTRYPOINT ["/usr/local/bin/backup.sh"]
