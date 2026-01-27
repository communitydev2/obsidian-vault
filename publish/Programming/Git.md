Change git rebase settings (default code)

Git config –global –edit

Git config –global core.editor “code –wait” - changes to vscode

https://www.youtube.com/watch?v=CAnQ4b0uais&t=131s

Go back 1 commit:

- git log --oneline
    
- Check commit id and copy
    
- Git rebase -i commitId
    

  

## Download specific git folders:

https://download-directory.github.io/

  

## Get branches:

- Locally - git branch -d branch-name
    
- Remotelly - git branch -r
    

  

## Delete branch (remotely)

- git push origin --delete feature/login
    

## Create pull request:

- Push to a branch (this is very important)
    
- In the git browser, 
    

## Merge new branch to main

- ## git checkout main
    
- ## git pull origin main
    
- ## git merge branch-name
    
- ## git push origin main
    

## Create new branch (locally)

- Git checkout -b “feature/connect_db” 
    
-   
    

  

## Using git stash

- Stashes current changes in a pocket. Must use before commit, otherwise you lose those changes
    
- Git stash
    
- Git checkout main (goes back to main branch)
    
- Git pull (to get possible changes)
    
- Git stash apply
    

  
  

Imported project 

  

Merge commits 

- Copy commit ids
    
- Git rebase -i commitHash1 
    

  

-   
    

## Get branches:

- Locally - git branch -d branch-name
    
- Remotelly - git branch -r
    

  

## Delete branch (remotely)

- git push origin --delete feature/login
    

## Create pull request:

- Push to a branch (this is very important)
    
- In the git browser, 
    

## Merge new branch to main

- git checkout main
    
- git pull origin main
    
- git merge branch-name
    
- git push origin main
    

## Create new branch (locally)

- Git checkout -b “feature/connect_db” 
    
-   
    

  

## Using git stash

- Stashes current changes in a pocket. Must use before commit, otherwise you lose those changes
    
- Git stash
    
- Git checkout main (goes back to main branch)
    
- Git pull (to get possible changes)
    
- Git stash apply