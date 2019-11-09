function git_fixup
  set commit_title $argv[1..-1]
  set broken_commit_id (git log --oneline | grep "$commit_title" | awk '{print $1}')
  git commit --fixup $broken_commit_id
  git rebase -i --autosquash ( git rev-parse $broken_commit_id^ )
end
