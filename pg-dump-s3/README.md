# [ectobit/pg-dump-s3](https://hub.docker.com/repository/docker/ectobit/pg-dump-s3)

![Docker](https://github.com/ectobit/container-images/workflows/pg-dump-s3/badge.svg)
[![Pulls](https://img.shields.io/docker/pulls/ectobit/pg-dump-s3)](https://hub.docker.com/r/ectobit/pg-dump-s3)
[![Stars](https://img.shields.io/docker/stars/ectobit/pg-dump-s3)](https://hub.docker.com/r/ectobit/pg-dump-s3)

This image is based on the latest Ubuntu and contains PostgreSQL client utilities including psql, pg_dump and pg_dumpall but also aws-cli 2 to be able to dump and restore from s3.

## Environment variables

### pg_dump related

- PGHOST
- PGPORT (optional, defaults to 5432)
- PGOPTIONS (optional connection flags, see PostgreSQL documentation)
- PGUSER
- PGPASSWORD
- DBS (comma separated list of databases to be dumped)
- EXTRA_OPTS (optional, extra options to pass to pg_dump command)

### aws cli related

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- S3_BUCKET
- S3_ENDPOINT (optional, i.e. for minio set to https://host.domain.com:9000)

## Example usage to dump databases to S3

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: pg-dump-s3
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
            - name: pg-dump-s3
              image: ectobit/pg-dump-s3
              imagePullPolicy: Always
              env:
                - name: PGHOST
                  value: postgresql
                - name: PGUSER
                  value: postgres
                - name: PGPASSWORD
                  valueFrom:
                    secretKeyRef:
                      name: postgresql
                      key: postgres-password
                - name: DBS
                  value: auth_service,other_service
                - name: AWS_ACCESS_KEY_ID
                  value: { { requiredEnv "S3_ACCESS_KEY_ID" } }
                - name: AWS_SECRET_ACCESS_KEY
                  value: { { requiredEnv "S3_SECRET_ACCESS_KEY" } }
                - name: S3_BUCKET
                  value: bucket/sub-bucket
          restartPolicy: OnFailure
      ttlSecondsAfterFinished: 172800
```
