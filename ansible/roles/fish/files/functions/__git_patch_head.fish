function git_patch_head
  git commit --fixup "( git rev-parse HEAD )"
  git rebase -i --autosquash "( git rev-parse HEAD~2 )"
end
