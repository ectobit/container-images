# rspamd

[![rspamd](https://github.com/ectobit/container-images/actions/workflows/rspamd.yml/badge.svg)](https://github.com/ectobit/container-images)
[![Docker Pulls](https://img.shields.io/docker/pulls/ectobit/rspamd?label=pulls&logo=docker)](https://hub.docker.com/repository/docker/ectobit/rspamd)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/ectobit/rspamd?label=size&logo=docker&sort=semver)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/ectobit/rspamd?logo=docker)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/rspamd)](https://artifacthub.io/packages/search?repo=rspamd)

Alpine based container image with [rspamd](https://rspamd.com/) including controller and proxy.

This image is used by the [same named Helm chart](https://artifacthub.io/packages/helm/ectobit/rspamd).

## Redis TLS compatibility patch

This image carries a small patch for `/usr/share/rspamd/lualib/lua_redis.lua` so Redis Lua script uploads (`SCRIPT LOAD`) propagate the same TLS options as normal Redis requests:
`ssl`, `no_ssl_verify`, `ssl_ca`, `ssl_ca_dir`, `ssl_cert`, `ssl_key`, and `sni`.

Keep this patch until upstream Rspamd includes equivalent Redis TLS handling for script upload.
