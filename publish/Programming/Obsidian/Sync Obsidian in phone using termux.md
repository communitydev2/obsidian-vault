https://pulinagrawal.github.io/Obsidian-Sync-Alternative/

https://www.reddit.com/r/termux/comments/zzynoz/easy_way_to_get_sdcards_path_storagexxxxxxxx/

ln -s $(readlink -f ~/storage/external-1 | cut -d/ -f-3) ~/storage/shared-external-1

this creates a link to your external folder

```
mkdir ~/storage/shared-external-1/obsidian
cd ~/storage/shared-external-1/obsidian
ls -la to see all folders
```

in the clone section, do this instead
```

git clone https://github.com/communitydev2/obsidian-vault.git

```

go inside the repo directory on your phone, and do git pull. it will ask you to do a 
```
git config
```

but it gave me the whole code, so it worked,

```
git config --global user.email "your@email.com"
```

then do

```
git pull
```

In the part of Create a sync.sh file with the following lines.
```
you need to do ssh-add copyPathOfPublicKeyCreatedEarlier   (remove .pub from the path)
```

```
nano sync.sh

or nano "$HOME/storage/shared-external-1/obsidian/obsidian-vault/sync.sh"

```

```
TPWD=$PWD

cd ~/storage/shared-external-1/obsidian/obsidian-vault

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



```
on the phone, press the ctrl then a X
then press the enter on the mobile keyboard
```
chmod 755 ~/storage/shared-external-1/obsidian/obsidian-vault/sync.sh
```

```
git config --global user.name "Miguel"
git config --global user.email "miguel_f_r_salvador@hotmail.com"

```

after this, 

```
bash sync.sh will work

After doing it, it will ask you for your credentials,
username is communitydev2
pass (get grt github dev settings, apis, public api named obsidian)
```
```
pkg install cronie termux-services
```

restart termux
```
pkg install termux-api
termux-job-scheduler --job-id 1 --period-ms 120000 --script "/data/data/com.termux/files/usr/bin/bash $HOME/storage/shared-external-1/obsidian/obsidian-vault/sync.sh >> $HOME/sync.log 2>&1"


```
```

git config --global credential.helper store

bash "$HOME/storage/shared-external-1/obsidian/obsidian-vault/sync.sh"

It will ask you for credentials, but it's stored from now on

to verify, do 

cat ~/.git-credentials

if you see a line, it worked

then paste 

/data/data/com.termux/files/usr/bin/bash \
/data/data/com.termux/files/home/storage/shared-external-1/obsidian/obsidian-vault/sync.sh


```
pkg install cronie termux-services
```
exit - write on termux
```
```
sv-enable crond
sv status crond - check if its working
sv up crond
check if these paths are working
ls /data/data/com.termux/files/usr/bin/bash
ls /data/data/com.termux/files/home/storage/shared-external-1/obsidian/obsidian-vault/sync.sh

chmod +x /data/data/com.termux/files/home/storage/shared-external-1/obsidian/obsidian-vault/sync.sh

crontab -r 2>/dev/null || echo "No existing crontab"

cat <<'EOF' | crontab -
* * * * * /data/data/com.termux/files/usr/bin/bash /storage/5582-52A3/obsidian/obsidian-vault/sync.sh >> /data/data/com.termux/files/home/cron-sync.log 2>&1
EOF

sv-enable crond
sv up crond
sv status crond

on app settings, set termux to unresttricted battery
allow background activity
```

```
errors:

it was unsynching because it was using a random folder I created, which I deleted,

I changed the sync.sh

cat > /storage/5582-52A3/obsidian/obsidian-vault/sync.sh <<'EOF'
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
EOF

```

```
then 

chmod +x /storage/5582-52A3/obsidian/obsidian-vault/sync.sh

/data/data/com.termux/files/usr/bin/bash /storage/5582-52A3/obsidian/obsidian-vault/sync.sh

tail -n 60 /data/data/com.termux/files/home/auto-sync.log



```

