function git_commit_message
#   git log --format=%B -n 1 "$1" \
#     || echo "Provide commit hash"
end
