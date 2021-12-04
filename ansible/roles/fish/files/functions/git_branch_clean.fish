function git_branch_clean
    git br | grep -E 'feature|hotfix|bugfix|release' | awk '{print $1}' | xargs git br -D 
end