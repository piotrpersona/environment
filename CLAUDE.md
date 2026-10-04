# environment

Dotfiles and machine setup for macOS. Every config file lives here and is
**symlinked** into place, so editing `~/.zshrc` edits `zsh/.zshrc` in this repo
and `git pull` is enough to roll out a change.

## Layout

One top-level directory per tool. A directory is a module when it has an
executable `install.sh`. `install.sh` at the root discovers and runs them.

```
lib.sh              shared helpers: link, say, warn, die, have, read_list
install.sh          entry point; discovers and runs each module
<module>/install.sh links that module's config into place
<module>/<config>   the tracked config file
brew/packages       formulae, one per line
brew/cask           casks, one per line
fonts/fonts         Nerd Font casks, one per line
gh/aliases          gh aliases, "name = expansion"
gh/extensions       gh extensions, "owner/repo"
```

`nvim` and the agent config are **not** here. They are separate repos; see
"Related repos" in `README.md`.

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
- **Always update the "Tool reference" tables in `README.md` when adding or
  removing a tool.** They are the fast lookup for what this machine has, so a
  new entry in `brew/packages`, `brew/cask`, `fonts/fonts`, `gh/aliases` or
  `zsh/.zsh_aliases.sh` needs its row in the same commit. One sentence per
  row, columns `tool | description`. A tool with no row is a bug.
- `brew` and `fonts` are opt-in (`OPT_IN` in `install.sh`) because they
  download a lot. Keep anything slow or large opt-in.
- Check syntax with `bash -n` on every script touched, and prefer
  `shellcheck` when available.
- Record user-visible changes in `CHANGELOG.md`.

## Related repos

`piotrpersona/nvim` and `piotrpersona/agents` used to be submodules here. They
are now fully separate: cloned to `~/developer/github.com/piotrpersona/<repo>`
and installed by their own `install.sh`. A change to either needs no commit in
this repo, and this repo's `install.sh` does not touch them.

Each of those repos carries its own `CLAUDE.md`/`AGENTS.md` requiring an agent
to diff the live config against the repo and report destructive actions
**before** running its installer. Follow it; do not run their installers blind.
