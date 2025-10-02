#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-.devkit}"
SRC="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$TARGET"
rsync -a --delete --exclude ".git" --exclude ".github" --exclude "tools" "$SRC/" "$TARGET/"
echo "Synced devkit to $TARGET"
