#!/bin/bash

set -e

echo "Job started: $(date)" | tee -a /var/log/cron.log
RCLONE_CONF=/root/.config/rclone/rclone.conf

if [[ -z "$BACKUP_DIR" ]]; then
    echo "Please set the target directory to backup using BACKUP_DIR"
	exit 1
fi

if [[ -z "$FILE_PREFIX" ]]; then
    echo "Please set the prefix for the backup file"
	exit 1
fi

if [[ -z "${RCLONE_REMOTE}" ]] || [[ -z "${RCLONE_PATH}" ]]; then
  echo "RCLONE_REMOTE and RCLONE_PATH must be set"
  exit 1
fi

if [[ ! -f "$RCLONE_CONF" ]]; then
    echo "Please mount the /root folder which contains /root/.config/rclone/rclone.conf"
	exit 1
fi

DATE=$(date +%Y%m%d_%H%M%S)

FILE=/tmp/${FILE_PREFIX}-${DATE}.tar.gz

tar czvf ${FILE} ${BACKUP_DIR} | tee -a /var/log/cron.log

rclone move ${FILE} ${RCLONE_REMOTE}:${RCLONE_PATH}/ -P  | tee -a /var/log/cron.log

if [ ! -z "$DELETE_OLDER_THAN" ]; then
	rclone delete ${RCLONE_REMOTE}:${RCLONE_PATH}/ --min-age ${DELETE_OLDER_THAN} 
fi

echo "Job finished: $(date)" | tee -a /var/log/cron.log
