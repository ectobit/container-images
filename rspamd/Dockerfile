FROM alpine:3.14.0

RUN apk add --no-cache ca-certificates curl rspamd rspamd-controller rspamd-fuzzy rspamd-proxy && \
    chown -R rspamd:rspamd /etc/rspamd

COPY entrypoint.sh /entrypoint.sh

VOLUME ["/var/lib/rspamd"]

EXPOSE 11332/tcp 11333/tcp 11334/tcp 11335/tcp

USER 100

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/rspamd", "-f"]
