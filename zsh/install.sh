#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

# The old installer used `ls ~/.zshrc || cp`, so an existing ~/.zshrc was never
# overwritten and could diverge from the repo for years. Linking replaces it, so
# say loudly when a real file was just moved aside: machine-local PATH entries
# and tool init in it (asdf, nvm, pnpm, uv) need to move to ~/.zshrc.local.
had_real_zshrc=false
[ -e "${HOME}/.zshrc" ] && [ ! -L "${HOME}/.zshrc" ] && had_real_zshrc=true

link zsh/.zshrc          "${HOME}/.zshrc"
link zsh/.zsh_aliases.sh "${HOME}/.zsh_aliases.sh"
link zsh/prompt.sh       "${HOME}/prompt.sh"

# .zshrc sources these last if they exist; both stay machine-local and untracked.
touch -- "${HOME}/.zsh_aliases.local.sh" "${HOME}/.zshrc.local"

if [ "${had_real_zshrc}" = true ]; then
    warn "your previous ~/.zshrc was replaced by the repo version."
    warn "diff it against the backup and move anything machine-specific"
    warn "(PATH entries, asdf/nvm/pnpm/uv init, env vars) to ~/.zshrc.local:"
    warn "  diff ${HOME}/.zshrc.*.bak ${ENV_ROOT}/zsh/.zshrc"
fi
