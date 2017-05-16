#!/bin/bash

SQL_DUMP_FILE="dump.sql"
ERROR_LOG="mysqldump-error.log"
ERROR_LOG_CLEANED="mysqldump-error-cleaned.log"
COMPRESSED_FILE=hub-db-dump_`date "+%Y-%m-%d_%H-%M-%S"`.tar.gz
OUT_DIR=/data/

# Dump data to file
mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD" 2> ${ERROR_LOG} > ${SQL_DUMP_FILE}

# Hackery to remove warning messages from error file
grep -v '^mysqldump:.*\[Warning\].*$' ${ERROR_LOG} > ${ERROR_LOG_CLEANED}

if [ -s ${ERROR_LOG_CLEANED} ];
then
    echo "Error dumping database, "$(cat ${ERROR_LOG_CLEANED})
else
    # Compress database dump and move to volume mount directory
    tar -zcvf ${COMPRESSED_FILE} ${SQL_DUMP_FILE} >/dev/null 2>&1
    mv ${COMPRESSED_FILE} ${OUT_DIR}
    echo "Dumped database to file: "${OUT_DIR}${COMPRESSED_FILE}
fi

# Remove unnecessary files
rm ${ERROR_LOG} ${ERROR_LOG_CLEANED} ${SQL_DUMP_FILE}