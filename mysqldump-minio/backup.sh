#!/bin/bash

set -e

DBS=$(mysql -h ${MARIADB_HOST} -u root -p${MARIADB_PASSWORD} -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|test)")

for DB in $DBS; do
    echo "dumping ${DB}"
    DATE=$(date +"%Y%m%d")
    S3_FILE="${DB}_${DATE}.sql.bz2"
    mysqldump -h ${MARIADB_HOST} -u root -p${MARIADB_PASSWORD} --routines --triggers ${DB} | bzip2 -c | aws --endpoint-url=${S3_ENDPOINT} --no-progress s3 cp - s3://${S3_BUCKET}/${S3_FILE}
done
