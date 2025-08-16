# This works

API_URL="https://net-secondary.web.minecraft-services.net/api/v1.0/download/links"

DOWNLOAD_URL=$(curl -s "$API_URL" \
	| jq -r '.result.links[] | select(.downloadType == "serverBedrockLinux") | .downloadUrl')

echo "$(date): Downloading Version $LATEST_VERSION from $DOWNLOAD_URL..."

randomint=$(head /dev/urandom | tr -dc '0-9' | head -c 4)

echo "$(date): Using random int $randomint"

USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$randomint.212 Safari/537.36"

echo "$(date): Using User Agent $USER_AGENT"

if ! curl -H "Accept-Encoding: identity" -H "Accept-Language:en" -A "$USER_AGENT" -fSL "$DOWNLOAD_URL" -o "$WORKDIR/bedrock-server.zip"; then
	echo "$(date): ERROR: failed to download Bedrock server from $DOWNLOAD_URL"
	exit 1
fi

echo "$(date): Download complete..."