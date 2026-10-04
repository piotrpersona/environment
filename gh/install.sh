#!/usr/bin/env bash
# Configure the GitHub CLI.
#
# Settings and aliases are applied with `gh config`/`gh alias` rather than by
# symlinking ~/.config/gh, because that directory also holds hosts.yml, which
# contains the auth token and must never land in this repo.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

have gh || { have brew && brew install gh; } || die "gh is not installed"

gh config set git_protocol ssh
gh config set editor nvim
gh config set prompt enabled
say "config git_protocol=ssh editor=nvim"

while IFS= read -r line; do
    name="$(printf '%s' "${line%%=*}" | xargs)"
    expansion="$(printf '%s' "${line#*=}" | xargs)"
    [ -n "${name}" ] && [ -n "${expansion}" ] || continue
    if gh alias set --clobber "${name}" "${expansion}" >/dev/null 2>&1; then
        say "alias  ${name} = ${expansion}"
    else
        warn "alias ${name} skipped: already a gh command or extension"
    fi
done < <(read_list "${ENV_ROOT}/gh/aliases")

installed="$(gh extension list 2>/dev/null | awk '{print $3}')"
while IFS= read -r ext; do
    if printf '%s\n' "${installed}" | grep -qxF "${ext}"; then
        say "ext    ${ext} already installed"
    elif gh extension install "${ext}"; then
        say "ext    ${ext}"
    else
        warn "ext ${ext} failed to install"
    fi
done < <(read_list "${ENV_ROOT}/gh/extensions")

if gh auth status >/dev/null 2>&1; then
    say "auth   $(gh api user --jq .login 2>/dev/null || echo ok)"
elif [ -t 0 ]; then
    gh auth login --git-protocol ssh --web
else
    warn "not logged in - run: gh auth login --git-protocol ssh --web"
fi
