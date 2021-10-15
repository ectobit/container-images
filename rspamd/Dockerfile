# syntax = docker/dockerfile:experimental
FROM alpine:3.14.2

RUN --mount=type=cache,target=/var/cache/apk apk add ca-certificates curl rspamd rspamd-controller rspamd-fuzzy rspamd-proxy tzdata && \
    chown -R rspamd:rspamd /etc/rspamd

COPY entrypoint.sh /

VOLUME ["/var/lib/rspamd"]

EXPOSE 11332/tcp 11333/tcp 11334/tcp 11335/tcp

USER 100

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/rspamd", "-f"]
