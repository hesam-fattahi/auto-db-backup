#!/bin/bash
# Handles database dump creation based on type.
# Supported databases: MongoDB and PostgreSQL

set -e
source "$(dirname "$0")/log.sh"

DATE=$(date +%Y-%m-%d_%H-%M-%S)
DUMP_DIR="$BACKUP_DIR/dump_$DATE"

log INFO "Starting database dump for $DB_TYPE..."

case $DB_TYPE in
  mongodb)
    mongodump --uri="$DB_URI" --out="$DUMP_DIR"
    ;;
  postgres)
    pg_dump "$DB_URI" > "$DUMP_DIR.sql"
    ;;
  *)
    log ERROR "Unsupported DB_TYPE: $DB_TYPE"
    exit 1
    ;;
esac

log INFO "Database dump completed: $DUMP_DIR"
echo "$DUMP_DIR"
