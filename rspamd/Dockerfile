# syntax=docker/dockerfile:1.3
FROM alpine:3.14.2

ARG TARGETPLATFORM

RUN --mount=type=cache,target=/var/cache/apk if [ "${TARGETPLATFORM}" == "linux/amd64" ]; then apk add -U ca-certificates curl rspamd rspamd-controller rspamd-fuzzy rspamd-proxy tzdata; else apk add -U --allow-untrusted ca-certificates curl musl-dev rspamd rspamd-controller rspamd-fuzzy rspamd-proxy tzdata; fi

RUN chown -R rspamd:rspamd /etc/rspamd

COPY entrypoint.sh /

VOLUME ["/var/lib/rspamd"]

EXPOSE 11332/tcp 11333/tcp 11334/tcp 11335/tcp

USER 100

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/rspamd", "-f"]
