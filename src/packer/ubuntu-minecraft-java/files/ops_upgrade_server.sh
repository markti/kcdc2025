#!/bin/bash
set -euo pipefail
exec > >(tee -a /home/mcserver/upgrade_server.log) 2>&1

# Configurable paths
SERVICE_NAME="mcjava"
SERVER_DIR="/home/mcserver/minecraft_java"
VERSION_FILE="/home/mcserver/version.txt"
BACKUP_ROOT="/home/mcserver/backup"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
BACKUP_DIR="$BACKUP_ROOT/$TIMESTAMP"
TMP_DIR="/tmp/mc_upgrade_tmp"
API_URL="https://net-secondary.web.minecraft-services.net/api/v1.0/download/links"

if [[ -f "$VERSION_FILE" ]]; then
	CURRENT_VERSION=$(cat "$VERSION_FILE")
else
	CURRENT_VERSION="1.27.71.01"
fi

LATEST_VERSION=$(curl -s "$API_URL" \
	| jq -r '.result.links[] | select(.downloadType == "serverBedrockLinux") | .downloadUrl' \
	| sed -n 's/.*bedrock-server-\([0-9.]*\)\.zip/\1/p')

if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
	echo "$(date): Up-to-date (version $CURRENT_VERSION)"
	exit 0
else
	echo "$(date): OUTDATED! Current: $CURRENT_VERSION, Latest $LATEST_VERSION"
fi

echo "$(date): Stopping Minecraft Service"
systemctl stop "$SERVICE_NAME"

# backup
echo "$(date): Cleaning up temp dir"
mkdir -p "$BACKUP_DIR"
mkdir -p "$TMP_DIR"

echo "$(date): Backing up server files to $BACKUP_DIR..."
cp -r "$SERVER_DIR/worlds" "$BACKUP_DIR/"
cp "$SERVER_DIR/server.properties" "$BACKUP_DIR/" || echo "server.properties not found"
cp "$SERVER_DIR/permissions.json" "$BACKUP_DIR/" || echo "permissions.json not found"
cp "$SERVER_DIR/allowlist.json" "$BACKUP_DIR/" || echo "allowlist.json not found"

# download
DOWNLOAD_URL=$(curl -s "$API_URL" \
	| jq -r '.result.links[] | select(.downloadType == "serverBedrockLinux") | .downloadUrl')

echo "$(date): Downloading Version $LATEST_VERSION from $DOWNLOAD_URL..."

randomint=$(head /dev/urandom | tr -dc '0-9' | head -c 4)

echo "$(date): Using random int $randomint"

USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$randomint.212 Safari/537.36"

echo "$(date): Using User Agent $USER_AGENT"

if ! curl -H "Accept-Encoding: identity" -H "Accept-Language:en" -A "$USER_AGENT" -fSL "$DOWNLOAD_URL" -o "$TMP_DIR/bedrock-server-$LATEST_VERSION.zip"; then
	echo "$(date): ERROR: failed to download Bedrock server from $DOWNLOAD_URL"
	exit 1
fi

echo "$(date): Download complete..."

# install

echo "$(date): Installing new Minecraft Version..."
unzip -o "$TMP_DIR/bedrock-server-$LATEST_VERSION.zip" -d "$SERVER_DIR"

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

echo "$LATEST_VERSION" > "$VERSION_FILE"

# clean up
rm -rf "$BACKUP_DIR"
rm -rf "$TMP_DIR"