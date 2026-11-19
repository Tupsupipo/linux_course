#!/usr/bin/env bash

set -euo pipefail

DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_SOURCE="ubuntu@192.168.1.13:/var/www/html/"
BACKUP_DIR="/srv/backup/www"
BACKUP_PATH="${BACKUP_DIR}/${DATE}"

mkdir -p "$BACKUP_PATH"

if /usr/bin/flock -n /run/www-sync.lock /usr/bin/rsync -a -e "/usr/bin/ssh -i /root/.ssh/sync_ed25519  -o BatchMode=yes" "$BACKUP_SOURCE" "$BACKUP_PATH" >> /var/log/www-sync.log 2>&1
then
    echo "Backup completed successfully at $(date '+%Y-%m-%d %H:%M:%S') to ${BACKUP_PATH}" >> /var/log/www-sync.log
else
    echo "Backup failed at $(date '+%Y-%m-%d %H:%M:%S')" >> /var/log/www-sync.log
fi

cd "$BACKUP_DIR" || exit 1      # exit 1 varmistaa, ettei seuraava komento ajaudu, jos cd epäonnistuu. set -e ajaa tosin saman asian.
ls -1dt */ | tail -n +3 | xargs -r rm -rf # säilytetään vain kaksi uusinta varmuuskopiota, vanhemmat poistetaan
