
function git_hist
  git log --graph --decorate --all ( git rev-list -g --all )
end

