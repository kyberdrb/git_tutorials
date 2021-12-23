# Migrate repository from Github to Bitbucket...

... or from one provider to another with keeping the commit history

## Migrating a repo with one branch

1. when not cloned, clone
      
      git clone <github_repo_origin_url>

  when already cloned, pull/fetch is sufficient

      git pull <github_repo_origin_url>

1. optional - download all the branches of a repo if there is more than one

      for remote in $(git branch -r | grep -v master); do git checkout --track $remote; done

1. optional - download all large files from git LFS
        
      git lfs fetch origin --all

1. change origin URL

      git remote set-url origin <bitbucket_repo_origin_url>

1. push all with tags and LFS

      git push --all
      git push --tags
      git lfs push --all

## Sources
- https://www.bluelabellabs.com/blog/how-to-migrate-git-repository-from-github-to-bitbucket/ 
- https://gitprotect.io/blog/how-to-migrate-from-bitbucket-to-github/
- https://www.atlassian.com/git/tutorials/git-move-repository

