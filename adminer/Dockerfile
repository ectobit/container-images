# syntax=docker/dockerfile:1.3
FROM adminer:4.8.1

USER root

RUN --mount=type=cache,target=/var/cache/apk apk del curl

USER adminer
