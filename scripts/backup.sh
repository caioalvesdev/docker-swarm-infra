#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M)
BACKUP_DIR="$HOME/backups/$DATE"

mkdir -p "$BACKUP_DIR"

echo "Backup Postgres..."

docker exec $(docker ps -q -f name=postgres) \
pg_dumpall -U postgres > "$BACKUP_DIR/postgres.sql"

echo "Backup Mongo..."

docker exec $(docker ps -q -f name=mongodb) \
mongodump --archive="$BACKUP_DIR/mongo.archive"

echo "Compactando..."

tar -czf "$BACKUP_DIR.tar.gz" -C "$HOME/backups" "$DATE"

rm -rf "$BACKUP_DIR"

echo "Backup concluído: $BACKUP_DIR.tar.gz"

