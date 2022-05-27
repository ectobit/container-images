# [ectobit/mysqldump-minio](https://hub.docker.com/repository/docker/ectobit/mysqldump-minio)

![Docker](https://github.com/ectobit/container-images/workflows/mysqldump-minio/badge.svg)
[![Pulls](https://img.shields.io/docker/pulls/ectobit/mysqldump-minio)](https://hub.docker.com/r/ectobit/mysqldump-minio)
[![Stars](https://img.shields.io/docker/stars/ectobit/mysqldump-minio)](https://hub.docker.com/r/ectobit/mysqldump-minio)

This image is based on the newest stable Debian and contains MySQL/MariaDB mysqldump and AWS CLI 2 utilities which allow backup of MySQL/MariaDB databases directly to S3 compatible storage like Minio. Backups are going to be compressed using bzip2. The entrypoint of the image is a bash script which does the actual backup. At the moment this script probably doesn't work with AWS S3 (will be implemented just upon request, please open an issue for this). Configuration can be done using the following environment variables:

- MARIADB_HOST
- MARIADB_PASSWORD
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- S3_ENDPOINT
- S3_BUCKET

## Example usage to dump all databases (except information_schema, performance_schema, mysql and test) to Minio

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: mariadb-backup-minio
spec:
  schedule: '3 3 * * *'
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 1
  failedJobsHistoryLimit: 1
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: mariadb-backup-minio
              image: ectobit/mysqldump-minio
              imagePullPolicy: Always
              env:
                - name: MARIADB_HOST
                  value: mariadb
                - name: MARIADB_PASSWORD
                  valueFrom:
                    secretKeyRef:
                      name: mariadb
                      key: mariadb-root-password
                - name: AWS_ACCESS_KEY_ID
                  value: { { requiredEnv "HOME_MINIO_ACCESS_KEY" } }
                - name: AWS_SECRET_ACCESS_KEY
                  value: { { requiredEnv "HOME_MINIO_SECRET_KEY" } }
                - name: S3_ENDPOINT
                  value: https://your-minio-host:9000
                - name: S3_BUCKET
                  value: mariadb-backup
          restartPolicy: OnFailure
      ttlSecondsAfterFinished: 172800
```
