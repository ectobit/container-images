# syntax=docker/dockerfile:1.3
FROM debian:10.11-slim

RUN echo PLATFORM "${TARGETPLATFORM}"

RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; \
    then echo DA, OVO JE AMD64 "${TARGETPLATFORM}"; \
    else echo NE, OVO JE ARM64 "${TARGETPLATFORM}"; fi

USER 65534:65534

ENTRYPOINT ["/usr/local/bin/backup.sh"]
