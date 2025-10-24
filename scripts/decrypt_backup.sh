#!/bin/bash
# Decrypts a downloaded backup archive using the configured encryption key.

set -e
source "$(dirname "$0")/log.sh"

FILE=$1
OUTPUT="${FILE%.gpg}"

log INFO "Decrypting backup..."
gpg --batch --yes --passphrase "$ENCRYPTION_KEY" -o "$OUTPUT" -d "$FILE"
log INFO "Decryption complete: $OUTPUT"

echo "$OUTPUT"
