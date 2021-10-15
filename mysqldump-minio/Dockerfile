# syntax=docker/dockerfile:1.3
FROM debian:10.7-slim

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt apt-get update && \
    apt-get --no-install-recommends install -y bzip2 ca-certificates curl mariadb-client unzip

RUN curl -sSL -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip && \
    unzip -q awscliv2.zip && \
    ./aws/install && \
    rm -fr aws

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt apt-get remove --purge -y curl unzip

COPY backup.sh /usr/local/bin/

USER 65534:65534

ENTRYPOINT ["/usr/local/bin/backup.sh"]
