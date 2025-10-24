#!/bin/bash
# Loads `.env` variables and performs sanity checks

set -e

if [ ! -f .env ]; then
  echo "❌ Configuration file '.env' not found."
  exit 1
fi

# Export environment variables
export $(grep -v '^#' .env | xargs)

# Basic validation
if [ -z "$DB_TYPE" ] || [ -z "$DB_URI" ]; then
  echo "❌ Database configuration is incomplete."
  exit 1
fi

mkdir -p "$BACKUP_DIR"
