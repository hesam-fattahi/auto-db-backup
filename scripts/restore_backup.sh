#!/bin/bash
# Restores the database from a decrypted archive, depending on database type.

set -e
source "$(dirname "$0")/log.sh"

ARCHIVE=$1
TEMP_DIR="$BACKUP_DIR/restore_temp"

mkdir -p "$TEMP_DIR"
tar -xzf "$ARCHIVE" -C "$TEMP_DIR"

log INFO "Restoring $DB_TYPE database..."

case $DB_TYPE in
  mongodb)
    mongorestore --uri="$DB_URI" "$TEMP_DIR"/dump_*
    ;;
  postgres)
    psql "$DB_URI" < "$TEMP_DIR"/*.sql
    ;;
esac

log INFO "Database restoration complete."
