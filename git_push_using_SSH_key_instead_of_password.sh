#/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Bad number of arguments"
  echo "Usage"
  echo "./bash_push....sh root_git_dir"
  echo "e.g."
  echo "./bash_push....sh ~/github_repositories"
  exit 1
fi

LOCAL_MAIN_GITHUB_DIR=$1

for repository in $(find $LOCAL_MAIN_GITHUB_DIR -maxdepth 1 -type d)
do

  REPO_URL=$(git -C $repository remote -v | grep -m1 '^origin' | sed -Ene's#.*(https://[^[:space:]]*).*#\1#p')
  if [ -z "$REPO_URL" ]; then
    echo "-- ERROR:  Could not identify Repo url."
    echo "   It is possible this repo is already using SSH instead of HTTPS."
    continue
  fi

  USER=$(echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\1#p')
  if [ -z "$USER" ]; then
    echo "-- ERROR:  Could not identify User."
    continue
  fi

  REPO=$(echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\2#p')
  if [ -z "$REPO" ]; then
    echo "-- ERROR:  Could not identify Repo."
    continue
  fi

  NEW_URL="git@github.com:$USER/$REPO.git"
  echo "Changing repo url from "
  echo "  '$REPO_URL'"
  echo "      to "
  echo "  '$NEW_URL'"

  CHANGE_CMD="git -C $repository remote set-url origin $NEW_URL"
  $($CHANGE_CMD)

  echo "Success"
  echo

done
