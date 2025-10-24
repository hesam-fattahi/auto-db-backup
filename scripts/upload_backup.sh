#!/bin/bash
# Uploads the encrypted backup to a user-specified destination (e.g., SFTP or rsync).

set -e
source "$(dirname "$0")/log.sh"

FILE=$1

case $UPLOAD_METHOD in
  sftp)
    log INFO "Uploading backup via SFTP..."
    sftp "$UPLOAD_USER@$UPLOAD_HOST":"$UPLOAD_PATH" <<< $"put $FILE"
    ;;
  rsync)
    log INFO "Uploading backup via rsync..."
    rsync -avz "$FILE" "$UPLOAD_USER@$UPLOAD_HOST:$UPLOAD_PATH"
    ;;
  *)
    log ERROR "Unsupported upload method: $UPLOAD_METHOD"
    exit 1
    ;;
esac

log INFO "Upload complete."
