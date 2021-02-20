#!/usr/bin/env sh

exec tail -F /var/log/rspamd/rspamd.log &

exec "$@"
