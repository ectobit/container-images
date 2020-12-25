# Optimized container images for different utility purposes

[![GitHub](https://img.shields.io/github/license/acim/go-reflex)](LICENSE)

All images within this monorepo are intended to be used primarily within Kubernetes cluster. Therefore images contain neither entrypoint nor command. Click on the links bellow to find more information about each image.

## [ectobit/mariadb-client](https://github.com/ectobit/container-images/tree/main/mariadb-client/README.md)

This image is based on the latest Alpine and contains MySQL/MariaDB utilities like mysql, mysqldump and mysqlcheck which may be used for database backup, tables optimizatition and similar purposes.

## [ectobit/go-lint](https://github.com/ectobit/container-images/tree/main/go-lint/README.md)

This image is based on Golang Alpine and contains golangci-lint and golint linters.
