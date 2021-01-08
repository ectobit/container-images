# Optimized container images for different utility purposes

[![GitHub](https://img.shields.io/github/license/acim/go-reflex)](LICENSE)

All images within this monorepo are intended to be used primarily within Kubernetes cluster. Therefore images contain neither entrypoint nor command. Click on the links bellow to find more information about each image.

## [ectobit/mariadb-client](https://hub.docker.com/repository/docker/ectobit/mariadb-client)

![Docker](https://github.com/ectobit/container-images/workflows/mariadb-client/badge.svg)
[![Pulls](https://img.shields.io/docker/pulls/ectobit/mariadb-client)](https://hub.docker.com/r/ectobit/mariadb-client)
[![Stars](https://img.shields.io/docker/stars/ectobit/mariadb-client)](https://hub.docker.com/r/ectobit/mariadb-client)

This image is based on the latest Alpine and contains MySQL/MariaDB utilities like mysql, mysqldump and mysqlcheck which may be used for database backup, tables optimizatition and similar purposes.

### Example usage for tables optimization using CronJob Kubernetes resource

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: mariadb-optimize-tables
spec:
  schedule: '2 2 * * 0'
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 1
  failedJobsHistoryLimit: 1
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: mariadb-optimize-tables
              image: ectobit/mariadb-client
              imagePullPolicy: Always
              env:
                - name: PASSWORD
                  valueFrom:
                    secretKeyRef:
                      name: mariadb
                      key: mariadb-root-password
              command:
                - sh
                - -c
                - mysqlcheck -h mariadb -u root -p${PASSWORD} -o --all-databases
          restartPolicy: OnFailure
      ttlSecondsAfterFinished: 172800
```

## [ectobit/golang](https://hub.docker.com/repository/docker/ectobit/golang)

![Docker](https://github.com/ectobit/container-images/workflows/golang/badge.svg)
[![Pulls](https://img.shields.io/docker/pulls/ectobit/golang)](https://hub.docker.com/r/ectobit/golang)
[![Stars](https://img.shields.io/docker/stars/ectobit/golang)](https://hub.docker.com/r/ectobit/golang)

This image is based on the newest Golang Alpine and contains golangci-lint and golint linters. It can be used as Docker based CI step in Jenkins and Drone.

## [ectobit/mysqldump-minio](https://hub.docker.com/repository/docker/ectobit/mysqldump-minio)

![Docker](https://github.com/ectobit/container-images/workflows/mysqldump-minio/badge.svg)
[![Pulls](https://img.shields.io/docker/pulls/ectobit/mysqldump-minio)](https://hub.docker.com/r/ectobit/mysqldump-minio)
[![Stars](https://img.shields.io/docker/stars/ectobit/mysqldump-minio)](https://hub.docker.com/r/ectobit/mysqldump-minio)

This image is based on the newest Debian and contains MySQL/MariaDB utilities like mysql, mysqldump and mysqlcheck which may be used for database backup, tables optimizatition and similar purposes. It is larger in size comparing to ectobit/mariadb-client, but this image also contains AWS CLI 2 which allows backup to S3 compatible storage like Minio. The entrypoint of the image is a bash script which does the actual backup. It supports the following environment variables:

- MARIADB_HOST
- MARIADB_PASSWORD
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- name: S3_ENDPOINT
- name: S3_BUCKET
