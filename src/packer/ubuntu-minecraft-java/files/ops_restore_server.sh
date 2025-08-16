#!/bin/bash
set -euo pipefail
exec > >(tee -a /home/mcserver/restore_server.log) 2>&1

# Configurable paths
SERVICE_NAME="mcjava"
SERVER_DIR="/home/mcserver/minecraft_java"
BACKUP_ROOT="/home/mcserver/backup"
BACKUP_DIR="$BACKUP_ROOT/$1"

echo "$(date): Stopping Minecraft Service"
systemctl stop "$SERVICE_NAME"

# restore
echo "$(date): Restore previous Minecraft configuration..."
cp "$BACKUP_DIR"/server.properties "$SERVER_DIR/"
cp "$BACKUP_DIR"/permissions.json "$SERVER_DIR/"
cp "$BACKUP_DIR"/allowlist.json "$SERVER_DIR/"

echo "$(date): Restoring worlds directory..."
rm -rf "$SERVER_DIR/worlds"
cp -r "$BACKUP_DIR/worlds" "$SERVER_DIR/"

chown -R mcserver:mcserver "$SERVER_DIR"

# restart service
echo "$(date): Starting Minecraft Service"
sudo systemctl start "$SERVICE_NAME"
