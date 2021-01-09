FROM debian:10.7-slim

RUN apt-get update && \
    apt-get -y install bzip2 curl mariadb-client unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -fr ./aws && \
    apt-get remove --purge -y curl unzip

COPY backup.sh /usr/local/bin/

USER 65534

ENTRYPOINT ["/usr/local/bin/backup.sh"]
