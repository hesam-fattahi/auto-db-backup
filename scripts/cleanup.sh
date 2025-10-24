#!/bin/bash
# Removes temporary and local backup files after successful upload if enabled.

set -e
source "$(dirname "$0")/log.sh"

if [ "$CLEANUP_AFTER_UPLOAD" = true ]; then
  log INFO "Cleaning up local backups..."
  rm -rf "$BACKUP_DIR"/dump_* "$BACKUP_DIR"/*.tar.gz "$BACKUP_DIR"/*.gpg
fi
