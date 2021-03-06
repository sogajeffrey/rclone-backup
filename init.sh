#!/bin/bash

set -e

if [[ ! -z "$CRON" ]]; then
    echo "CRON enabled"
    echo "${CRON} /backup.sh" > /etc/cron.d/backup-cron
    echo "### EMPTY LINE FOR CRON" >> /etc/cron.d/backup-cron

    chmod 0644 /etc/cron.d/backup-cron

    cron

    echo "Backup cron container started with schedule ${CRON}" > /var/log/cron.log

    tail -f /var/log/cron.log
fi

if [[ -z "$CRON" ]]; then
    echo "One time run of backup"
    /backup.sh
fi

