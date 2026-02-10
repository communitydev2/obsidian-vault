#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

# === CONFIG ===
VAULT_DIR="/storage/5582-52A3/obsidian/obsidian-vault"
LOG_FILE="$VAULT_DIR/auto-sync.log"
LOCK_DIR="$VAULT_DIR/.sync.lock"

# === Ensure vault exists ===
if [ ! -d "$VAULT_DIR" ]; then
  echo "ERROR: Vault not found: $VAULT_DIR" >&2
  exit 1
fi

cd "$VAULT_DIR"

# === Lock to prevent overlapping runs ===
if mkdir "$LOCK_DIR" 2>/dev/null; then
  trap 'echo "SYNC END: $(date)" >> "$LOG_FILE"; rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT
else
  echo "INFO: Sync already running, exiting."
  exit 0
fi

# === Logging ===
{
  echo "========================================"
  echo "SYNC START: $(date)"
  echo "PWD: $(pwd)"
} >> "$LOG_FILE"
exec >> "$LOG_FILE" 2>&1

# === Safety: ensure git repo ===
if [ ! -d ".git" ]; then
  echo "ERROR: Not a git repository"
  exit 1
fi

# === Avoid broken rebase states ===
if [ -d ".git/rebase-merge" ] || [ -d ".git/rebase-apply" ]; then
  echo "ERROR: Rebase already in progress. Fix manually."
  exit 1
fi

# === 1) Commit local changes FIRST ===
git add -A
if ! git diff --cached --quiet; then
  git commit -m "android backup at $(date)"
else
  echo "INFO: No local changes to commit."
fi

# === 2) Pull remote changes safely ===
git pull --rebase

# === 3) Push ===
git push
