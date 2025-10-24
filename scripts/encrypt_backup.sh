#!/bin/bash
# Encrypts the tarball using GPG symmetric encryption

set -e
source "$(dirname "$0")/log.sh"

BACKUP_PATH=$1
ENCRYPTED_PATH="${BACKUP_PATH}.gpg"

log INFO "Encrypting backup..."
gpg --batch --yes --passphrase "$ENCRYPTION_KEY" -c "$BACKUP_PATH"
log INFO "Encryption complete: $ENCRYPTED_PATH"

echo "$ENCRYPTED_PATH"
