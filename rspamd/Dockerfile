# syntax=docker/dockerfile:1.3
FROM alpine:3.14.2

ARG TARGETPLATFORM

RUN --mount=type=cache,target=/var/cache/apk,id=amd64 if [ "${TARGETPLATFORM}" = "linux/amd64" ]; \
    then apk add -U ca-certificates curl rspamd rspamd-controller rspamd-fuzzy rspamd-proxy tzdata; fi

RUN --mount=type=cache,target=/var/cache/apk,id=arm64 if [ "${TARGETPLATFORM}" = "linux/arm64" ]; \
    then apk add -U ca-certificates curl musl musl-dev rspamd rspamd-controller rspamd-fuzzy rspamd-proxy tzdata; fi

RUN chown -R rspamd:rspamd /etc/rspamd

COPY entrypoint.sh /

VOLUME ["/var/lib/rspamd"]

EXPOSE 11332/tcp 11333/tcp 11334/tcp 11335/tcp

USER 100

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/rspamd", "-f"]
