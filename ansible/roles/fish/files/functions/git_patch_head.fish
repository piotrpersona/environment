function git_patch_head
  NON_FIXUP_HEAD_COMMIT="$(
    git log --oneline
    | grep --invert-match 'fixup'
    | head -1
    | awk '{print $1}'
  )"
  git commit --fixup "$NON_FIXUP_HEAD_COMMIT"
  git rebase --interactive --autosquash "$NON_FIXUP_HEAD_COMMIT~1"
end
