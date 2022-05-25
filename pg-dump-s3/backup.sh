#!/bin/bash

set -eo pipefail

OIFS="$IFS"
IFS=','

for DB in $DBS; do
IFS="$OIFS"

echo "dumping ${DB}"
DATE=$(date +"%Y%m%d")
S3_FILE="${DB}_${DATE}.sql.bz2"

if [[ -v S3_ENDPOINT ]]; then
    pg_dump $EXTRA_OPTS $DB | bzip2 -c | aws --endpoint-url=${S3_ENDPOINT} --no-progress s3 cp - s3://${S3_BUCKET}/${S3_FILE}
else
    pg_dump $EXTRA_OPTS $DB | bzip2 -c | aws --no-progress s3 cp - s3://${S3_BUCKET}/${S3_FILE}
fi
done
