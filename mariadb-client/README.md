# [ectobit/mariadb-client](https://hub.docker.com/repository/docker/ectobit/mariadb-client)

![Docker](https://github.com/ectobit/container-images/workflows/mariadb-client/badge.svg)
[![Pulls](https://img.shields.io/docker/pulls/ectobit/mariadb-client)](https://hub.docker.com/r/ectobit/mariadb-client)
[![Stars](https://img.shields.io/docker/stars/ectobit/mariadb-client)](https://hub.docker.com/r/ectobit/mariadb-client)

This image is based on the latest Alpine and contains MySQL/MariaDB utilities like mysql, mysqldump and mysqlcheck which may be used for database backup, tables optimization and similar purposes.

# Example usage for tables optimization using CronJob Kubernetes resource

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
