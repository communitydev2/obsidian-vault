TPWD=$PWD

cd ~/storage/shared-external-1/obsidian/obsidian-vault

git add -A
git commit -m "android backup at $(date)"
git pull
git push

cd $TPWD
