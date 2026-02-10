#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

VAULT_DIR="/storage/5582-52A3/obsidian/obsidian-vault"

# Runtime files OUTSIDE the repo
LOG_FILE="/data/data/com.termux/files/home/auto-sync.log"
LOCK_DIR="/data/data/com.termux/files/home/.obsidian-vault-sync.lock"

# Safety
if [ ! -d "$VAULT_DIR" ]; then
  echo "ERROR: Vault not found: $VAULT_DIR" >&2
  exit 1
fi

cd "$VAULT_DIR"

# Prevent overlapping runs
if mkdir "$LOCK_DIR" 2>/dev/null; then
  trap 'echo "SYNC END: $(date)" >> "$LOG_FILE"; rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT
else
  echo "INFO: Sync already running, exiting." >> "$LOG_FILE"
  exit 0
fi

# Logging
{
  echo "========================================"
  echo "SYNC START: $(date)"
  echo "PWD: $(pwd)"
} >> "$LOG_FILE"
exec >> "$LOG_FILE" 2>&1

# Abort if a rebase is already in progress
if [ -d ".git/rebase-merge" ] || [ -d ".git/rebase-apply" ]; then
  echo "ERROR: Rebase already in progress. Finish it first."
  exit 1
fi

# 1) Commit current local changes
git add -A
if ! git diff --cached --quiet; then
  git commit -m "android backup at $(date)"
else
  echo "INFO: No local changes to commit (pass 1)."
fi

# 2) Pull safely even if files change mid-run
git pull --rebase --autostash

# 3) Commit again in case changes reappear
git add -A
if ! git diff --cached --quiet; then
  git commit -m "android backup at $(date) (post-pull)"
else
  echo "INFO: No local changes to commit (pass 2)."
fi

# 4) Push
git push
