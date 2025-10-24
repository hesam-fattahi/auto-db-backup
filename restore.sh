#!/bin/bash
# Main entry point for restoring the database from the latest encrypted backup.

set -e
source "./scripts/config_loader.sh"
source "./scripts/log.sh"

log INFO "===== Starting Restore Process ====="

DOWNLOAD_PATH=$(bash ./scripts/download_backup.sh)
DECRYPTED_PATH=$(bash ./scripts/decrypt_backup.sh "$DOWNLOAD_PATH")
bash ./scripts/restore_backup.sh "$DECRYPTED_PATH"

log INFO "===== Restore Completed Successfully ====="
