TPWD=$PWD

cd /storage/5582-52A3/obsidian/obsidian-vault || exit 1
exec >> /storage/5582-52A3/obsidian/obsidian-vault/auto-sync.log 2>&1
echo "=== sync run: $(date) ==="

git add -A

# Commit only if there are staged changes
if ! git diff --cached --quiet; then
  git commit -m "android backup at $(date)"
fi

# Always pull first to receive PC updates
git pull --rebase

# Then push any phone changes
git push
cd $TPWD
