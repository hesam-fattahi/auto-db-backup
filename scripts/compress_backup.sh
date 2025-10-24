#!/bin/bash
# Creates a compressed archive of the dump

set -e
source "$(dirname "$0")/log.sh"

DUMP_PATH=$1
DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE_PATH="$BACKUP_DIR/backup_$DATE.tar.gz"

log INFO "Compressing backup..."
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$DUMP_PATH")" "$(basename "$DUMP_PATH")"
log INFO "Compression complete: $ARCHIVE_PATH"

echo "$ARCHIVE_PATH"
