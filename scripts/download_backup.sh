#!/bin/bash
# Retrieves the latest encrypted backup from the remote storage for restoration.
set -e
source "$(dirname "$0")/log.sh"

LOCAL_DIR="$BACKUP_DIR/latest_download"
mkdir -p "$LOCAL_DIR"

case $UPLOAD_METHOD in
  sftp)
    log INFO "Downloading latest backup via SFTP..."
    sftp "$UPLOAD_USER@$UPLOAD_HOST":"$UPLOAD_PATH/latest_backup.tar.gz.gpg" "$LOCAL_DIR/"
    ;;
  rsync)
    log INFO "Downloading latest backup via rsync..."
    rsync -avz "$UPLOAD_USER@$UPLOAD_HOST:$UPLOAD_PATH/latest_backup.tar.gz.gpg" "$LOCAL_DIR/"
    ;;
  *)
    log ERROR "Unsupported download method: $UPLOAD_METHOD"
    exit 1
    ;;
esac

log INFO "Download complete: $LOCAL_DIR"
echo "$LOCAL_DIR/latest_backup.tar.gz.gpg"
