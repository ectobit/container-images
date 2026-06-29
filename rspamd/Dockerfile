# syntax=docker/dockerfile:1.3
FROM alpine:3.24.1

ARG TARGETPLATFORM

RUN --mount=type=cache,target=/var/cache/apk,id=${TARGETPLATFORM} apk add \
    ca-certificates \
    curl \
    rspamd \
    rspamd-controller \
    rspamd-fuzzy \
    rspamd-proxy \
    tzdata &&\
    apk upgrade --no-cache

COPY lua_redis_tls_script_load.patch /tmp/lua_redis_tls_script_load.patch
RUN apk add --no-cache --virtual .patch-deps patch && \
    patch -d / -p0 < /tmp/lua_redis_tls_script_load.patch && \
    apk del .patch-deps && \
    rm /tmp/lua_redis_tls_script_load.patch

RUN chown -R rspamd:rspamd /etc/rspamd

COPY entrypoint.sh /

VOLUME ["/var/lib/rspamd"]

EXPOSE 11332/tcp 11333/tcp 11334/tcp 11335/tcp

USER 100

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/rspamd", "-f"]
