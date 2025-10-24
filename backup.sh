#!/bin/bash
# Main entry point that orchestrates the full backup process by calling modular scripts.

set -e
source "./scripts/config_loader.sh"
source "./scripts/log.sh"

log INFO "===== Starting Backup Process ====="

DUMP_PATH=$(bash ./scripts/db_dump.sh)
ARCHIVE_PATH=$(bash ./scripts/compress_backup.sh "$DUMP_PATH")
ENCRYPTED_PATH=$(bash ./scripts/encrypt_backup.sh "$ARCHIVE_PATH")
bash ./scripts/upload_backup.sh "$ENCRYPTED_PATH"
bash ./scripts/cleanup.sh

log INFO "===== Backup Completed Successfully ====="
