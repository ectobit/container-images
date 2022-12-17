# syntax=docker/dockerfile:1.3
FROM ubuntu:22.04 AS builder

ARG TARGETPLATFORM

RUN --mount=type=cache,target=/var/cache/apt,id=${TARGETPLATFORM} --mount=type=cache,target=/var/lib/apt,id=${TARGETPLATFORM} \
    apt-get update && \
    apt-get --no-install-recommends install -y ca-certificates curl unzip && \
    update-ca-certificates && \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /etc/apt/trusted.gpg.d/pgdg.asc

RUN if [ ${TARGETPLATFORM} = "linux/amd64" ]; \
    then curl -sSL -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip; \
    else curl -sSL -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip; fi && \
    unzip -q awscliv2.zip && \
    ./aws/install


FROM ubuntu:22.04

RUN echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list
COPY --from=builder /usr/share/ca-certificates/mozilla/ /etc/ssl/certs
COPY --from=builder /etc/apt/trusted.gpg.d/pgdg.asc /etc/apt/trusted.gpg.d

RUN apt-get update && \
    apt-get --no-install-recommends install -y postgresql-client bzip2 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/aws-cli /usr/local/aws-cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws && \
    ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer
COPY backup.sh /usr/local/bin

USER 65534:65534

ENTRYPOINT ["/usr/local/bin/backup.sh"]
