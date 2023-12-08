# syntax=docker/dockerfile:1.3
FROM alpine:3.19.0

RUN --mount=type=cache,target=/var/cache/apk apk add --no-cache mariadb-client

USER 65534:65534
