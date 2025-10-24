#!/bin/bash
# Adds or updates a system cron job to run automatic backups every 12 hours.

set -e
source "$(dirname "$0")/log.sh"

CRON_SCHEDULE="0 */12 * * *"
SCRIPT_PATH="$(pwd)/backup.sh"

log INFO "Adding cron job to run every 12 hours..."
(crontab -l 2>/dev/null; echo "$CRON_SCHEDULE $SCRIPT_PATH >> $LOG_FILE 2>&1") | crontab -
log INFO "Cron job added."
