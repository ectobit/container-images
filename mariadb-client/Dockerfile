# syntax=docker/dockerfile:1.3
FROM alpine:3.14.2

RUN --mount=type=cache,target=/var/cache/apk apk add -U mariadb-client

USER 65534:65534
