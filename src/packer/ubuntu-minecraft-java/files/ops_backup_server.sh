#!/bin/bash
set -euo pipefail
exec > >(tee -a /home/mcserver/backup_server.log) 2>&1

# Configurable paths
SERVICE_NAME="mcjava"
SERVER_DIR="/home/mcserver/minecraft_java"
BACKUP_ROOT="/home/mcserver/backup"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
BACKUP_DIR="$BACKUP_ROOT/$TIMESTAMP"

echo "$(date): Stopping Minecraft Service"
systemctl stop "$SERVICE_NAME"

# backup
echo "$(date): Cleaning up temp dir"
mkdir -p "$BACKUP_DIR"

echo "$(date): Backing up server files to $BACKUP_DIR..."
cp -r "$SERVER_DIR/worlds" "$BACKUP_DIR/"
cp "$SERVER_DIR/server.properties" "$BACKUP_DIR/" || echo "server.properties not found"
cp "$SERVER_DIR/permissions.json" "$BACKUP_DIR/" || echo "permissions.json not found"
cp "$SERVER_DIR/allowlist.json" "$BACKUP_DIR/" || echo "allowlist.json not found"

# restart service
echo "$(date): Starting Minecraft Service"
sudo systemctl start "$SERVICE_NAME"

BACKUP_FILENAME="${TIMESTAMP}.zip"
zip -r "${BACKUP_FILENAME}" "$BACKUP_DIR"

MANAGED_IDENTITY_CLIENT_ID=96e8acd8-3f28-49fe-968a-895495a48da1
STORAGE_ACCOUNT_NAME=stdatabqsh3ge7

echo "Managed Identity: $MANAGED_IDENTITY_CLIENT_ID"
echo "Storage Account Name: $STORAGE_ACCOUNT_NAME"

az login --identity --client-id $MANAGED_IDENTITY_CLIENT_ID

az storage blob upload \
	--account-name $STORAGE_ACCOUNT_NAME \
	--container-name minecraft \
	--name "$BACKUP_FILENAME" \
	--file "$BACKUP_FILENAME" \
	--auth-mode login

rm -f "${BACKUP_FILENAME}"
