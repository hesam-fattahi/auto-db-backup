# auto-db-backup
## Automated, Encrypted Database Backup and Restore System

**auto-db-backup** is a lightweight, Bash-based system that automates database backups every 12 hours, encrypts them, and uploads them to your preferred remote storage. It’s portable, modular, and designed for minimal setup across any environment.

## Overview
This project streamlines the database backup lifecycle:
- Dumps the database (MongoDB or PostgreSQL)
- Compresses and encrypts the dump
- Uploads backups to a remote destination (via SFTP or rsync)
- Cleans up local temporary files (optional)
- Schedules backups every 12 hours using cron
- Restores the latest backup when needed

All settings and credentials are managed via a simple `.env` file.

## Project Structure
```
auto-db-backup/
├── scripts/
│   ├── config_loader.sh       # Loads and validates environment variables
│   ├── log.sh                 # Handles standardized logging
│   ├── db_dump.sh             # Creates MongoDB or PostgreSQL database dump
│   ├── compress_backup.sh     # Compresses the dump into a tarball
│   ├── encrypt_backup.sh      # Encrypts the tarball using GPG
│   ├── upload_backup.sh       # Uploads encrypted backups via SFTP or rsync
│   ├── cleanup.sh             # Removes local backup files after upload
│   ├── download_backup.sh     # Downloads the latest encrypted backup
│   ├── decrypt_backup.sh      # Decrypts a downloaded backup using GPG
│   ├── restore_backup.sh      # Restores the database from a decrypted archive
│   └── cron_setup.sh          # Sets up the 12-hour cron job for backups
├── backup.sh                  # Orchestrates the full backup process
├── restore.sh                 # Orchestrates the full restore process
├── .env.example               # Example environment configuration
├── .gitignore                 # Ignores local and sensitive files (e.g., .env)
└── LICENSE                    # License file
```

Each script handles a single, well-defined task. The `backup.sh` and `restore.sh` scripts orchestrate the complete workflow.

## How It Works
### Backup Process (`backup.sh`)
1. Loads configuration (`config_loader.sh`)
2. Dumps the database (`db_dump.sh`)
3. Compresses the dump into a tarball (`compress_backup.sh`)
4. Encrypts the archive using GPG (`encrypt_backup.sh`)
5. Uploads the encrypted file (`upload_backup.sh`)
6. Optionally cleans up local files (`cleanup.sh`)

This process can run manually or be scheduled via cron.

### Restore Process (`restore.sh`)
1. Downloads the latest encrypted backup (`download_backup.sh`)
2. Decrypts it using the same GPG key (`decrypt_backup.sh`)
3. Restores the database based on its type (`restore_backup.sh`)

This ensures seamless data recovery using the same configuration.

## Installation
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/auto-db-backup.git
   cd auto-db-backup
   ```

2. **Create and configure your environment**
   ```bash
   cp .env.example .env
   ```

3. **Edit `.env` to set your parameters**
   ```bash
   DB_TYPE=postgres
   DB_URI=postgresql://user:password@localhost:5432/mydb
   ENCRYPTION_KEY=my_secret_key
   UPLOAD_METHOD=sftp
   UPLOAD_HOST=backup.example.com
   UPLOAD_USER=backupuser
   UPLOAD_PATH=/remote/backups
   CLEANUP_AFTER_UPLOAD=true
   ```

4. **Install required dependencies**
   - `bash`, `tar`, `gpg`, `cron`, `sftp` or `rsync`
   - `mongodump` (for MongoDB) or `pg_dump` (for PostgreSQL)

## Usage
- **Manual backup**
  ```bash
  bash backup.sh
  ```

- **Manual restore**
  ```bash
  bash restore.sh
  ```

- **Automated backups (every 12 hours)**
  ```bash
  bash scripts/cron_setup.sh
  ```

- **Confirm cron job**
  ```bash
  crontab -l
  ```

## Upload Options
Store backups using:
- **SFTP**: Secure SSH-based file transfers
- **rsync**: Efficient incremental backups

Configure via `.env`. To add new upload methods, extend `upload_backup.sh`.

## Cleanup
When `CLEANUP_AFTER_UPLOAD=true`, the `cleanup.sh` script deletes local dump and tarball files after a successful upload, saving disk space while keeping remote storage as the source of truth.

## Configuration Reference
| Variable              | Description                                           |
|-----------------------|-------------------------------------------------------|
| `DB_TYPE`             | Database type (`mongo` or `postgres`)                 |
| `DB_URI`              | Connection URI for the database                       |
| `ENCRYPTION_KEY`      | Passphrase for GPG encryption                        |
| `UPLOAD_METHOD`       | Upload method (`sftp` or `rsync`)                    |
| `UPLOAD_HOST`         | Remote host for backup storage                       |
| `UPLOAD_USER`         | Remote username                                      |
| `UPLOAD_PATH`         | Path on the remote host to store backups              |
| `CLEANUP_AFTER_UPLOAD`| Delete local files after upload (`true`/`false`)     |

## Extending the Project
Easily extend the system by:
- Adding new database types: Modify `db_dump.sh` and `restore_backup.sh`
- Adding new upload options: Extend `upload_backup.sh`
- Changing backup intervals: Update `cron_setup.sh`

The modular structure keeps extensions simple and isolated.