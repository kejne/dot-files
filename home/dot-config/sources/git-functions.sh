#Use when creating new PR. Figures out the branch-name.
gitpush () {
  branchvar=`git status | grep -o -E '\w+\/.*'`

  git push --set-upstream origin $branchvar
}

# When a PR is merged, this cleans up your local environment
gitdone () {
  getbranch
  git switch main
  git pull
  git branch -d $branchvar
}

getbranch() {
  branchvar=`git branch --show-current`
}

# Push all to existing PR
gpush () {
  local MSG
  if [ "$#" -ne 1 ]; then
    MSG="backup"
  else
    MSG=$1
  fi

  git add .
  git commit -m $MSG
  git push
}

#Push all to new upstream
push-new-pr-all () {
  if [ "$#" -ne 2 ]; then
     echo "Usage example: push-new-pr-all <branch> \"Commit message\""
     exit 1;
  fi
   
  gitb $1
  git add .
  git commit -m $2
  gitpush
}
