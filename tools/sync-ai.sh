#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.devkit}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/.devkit"

if [[ ! -d "$SRC" ]]; then
  echo "ERROR: Source .devkit folder not found at: $SRC" >&2
  exit 1
fi

mkdir -p "$TARGET"

# Mirror only the DevKit instruction pack
rsync -a --delete "$SRC/" "$TARGET/"

echo "Synced DevKit instructions from $SRC to $TARGET"
