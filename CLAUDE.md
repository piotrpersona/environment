# environment

Dotfiles and machine setup for macOS. Every config file lives here and is
**symlinked** into place, so editing `~/.zshrc` edits `zsh/.zshrc` in this repo
and `git pull` is enough to roll out a change.

## Layout

One top-level directory per tool. A directory is a module when it has an
executable `install.sh`. `install.sh` at the root discovers and runs them.

```
lib.sh              shared helpers: link, say, warn, die, have, read_list
install.sh          entry point; syncs submodules then runs each module
<module>/install.sh links that module's config into place
<module>/<config>   the tracked config file
brew/packages       formulae, one per line
brew/cask           casks, one per line
fonts/fonts         Nerd Font casks, one per line
gh/aliases          gh aliases, "name = expansion"
gh/extensions       gh extensions, "owner/repo"
nvim/               submodule, piotrpersona/nvim
agents/             submodule, piotrpersona/agents (Claude Code config)
```

## Rules for changes

- Never `cp` a config into `$HOME`. Call `link <repo-path> <target>` from
  `lib.sh`; it is idempotent and moves an existing real file aside as
  `<target>.<stamp>.bak` instead of deleting it.
- Source `lib.sh` at the top of every module installer:
  `source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"`. It sets `set -euo
  pipefail` and resolves `ENV_ROOT`, so paths are absolute and a module runs
  standalone as well as from the root installer.
- Reference files through `${ENV_ROOT}`, never a relative path: modules are
  invoked from the repo root, not from inside their own directory.
- Secrets never enter the repo. `gh` is configured with `gh config set` and
  `gh alias set` precisely because `~/.config/gh/hosts.yml` holds the auth
  token. Anything machine-specific goes in an untracked `*.local.sh`, which
  `.zshrc` sources if present.
- A module must be safe to re-run and must skip, not fail, when its tool is
  absent (see `code/install.sh`).
- Package lists are plain text, one entry per line, parsed with `read_list`.
  Add to the list; do not inline a package name in a script.
- `brew` and `fonts` are opt-in (`OPT_IN` in `install.sh`) because they
  download a lot. Keep anything slow or large opt-in.
- Check syntax with `bash -n` on every script touched, and prefer
  `shellcheck` when available.
- Record user-visible changes in `CHANGELOG.md`.

## Submodules

`nvim` and `agents` are separate repos. A change inside one is committed and
pushed **there** first, then the new pointer is committed here. Both ship
their own `install.sh` and are linked, not copied, so a live edit under
`~/.config/nvim` or `~/.claude` shows up as a dirty submodule, which is the
intended signal to commit it.
