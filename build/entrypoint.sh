#!/usr/bin/env bash
set -euo pipefail

# 必須: EULA=true
if [[ "${EULA:-false}" != "true" ]]; then
  echo "EULA not accepted. Set EULA=true to proceed." >&2
  exit 1
fi

BEDROCK_SERVER_VERSION="${BEDROCK_SERVER_VERSION:?BEDROCK_SERVER_VERSION is required}"
BEDROCK_DIR="${BEDROCK_DIR:-/bedrock-server}"
ZIP="bedrock-server-${BEDROCK_SERVER_VERSION}.zip"
URL="https://www.minecraft.net/bedrockdedicatedserver/bin-linux/${ZIP}"

cd "${BEDROCK_DIR}"

CURRENT_VER_FILE=".bedrock.version"
CURRENT_VER="$(cat "${CURRENT_VER_FILE}" 2>/dev/null || true)"

if [[ ! -f "./bedrock_server" || "${CURRENT_VER}" != "${BEDROCK_SERVER_VERSION}" ]]; then
  echo "Downloading Bedrock Dedicated Server ${BEDROCK_SERVER_VERSION}..."
  rm -f "${ZIP}"
  curl -fsSL "${URL}" -o "${ZIP}"
  unzip -o "${ZIP}" -d .
  rm -f "${ZIP}"
  echo -n "${BEDROCK_SERVER_VERSION}" > "${CURRENT_VER_FILE}"
fi


export BOX64_LD_LIBRARY_PATH="${BEDROCK_DIR}:${BOX64_LD_LIBRARY_PATH:-}"


# SIGTERM/SIGINT で停止
_term() {
  echo "Caught termination signal, stopping bedrock_server..."
  pkill -TERM -f bedrock_server || true
}
trap _term TERM INT

exec box64 ./bedrock_server
