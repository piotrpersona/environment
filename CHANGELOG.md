# Changelog

## Unreleased

### Changed — config is symlinked, not copied

Every module installer now calls `link` from the new `lib.sh` instead of
`cp -f`. Editing a file in `$HOME` edits this repo, and `git pull` rolls out a
change with no reinstall. An existing real file is moved to
`<target>.<stamp>.bak` rather than deleted.

Affected: `zsh`, `git`, `tmux`, `alacritty`, `wezterm`, `grc`, `code`, `nvim`.

### Added

- `ghostty/` module — `~/.config/ghostty/config` with the `Ayu Mirage` theme,
  `FiraCode Nerd Font Mono` at 13pt, ligatures off and option-as-alt, matching
  `alacritty.toml` and `.wezterm.lua`. The theme ships with Ghostty, from the
  same iTerm2-Color-Schemes upstream terminalcolors.com publishes, so no hex
  values are hand-copied. Validated with `ghostty +validate-config`.

- `lib.sh` — shared `link`, `say`, `warn`, `die`, `have`, `read_list`; sets
  `set -euo pipefail` and resolves `ENV_ROOT` so modules run standalone too.
- `gh/` module — `gh config set` for protocol/editor/prompt, aliases from
  `gh/aliases`, extensions from `gh/extensions`, and an auth check that runs
  `gh auth login` only on a TTY. Configured through `gh` commands rather than
  a symlinked `~/.config/gh`, because `hosts.yml` there holds the auth token.
- `agents/` submodule — `piotrpersona/agents`, the Claude Code config
  (rules, hooks, status line, merged `settings.json`). Its own `install.sh`
  runs as part of the sync.
- `CLAUDE.md` — repo conventions for agents working here.
- `fonts/fonts` — explicit Nerd Font cask list.
- `install.sh` flags: `--list`, `--help`, named modules
  (`./install.sh zsh nvim`), and `--brew` as the opt-in for slow modules.
- `git config pull.rebase true` and `rebase.autoStash true`.

### Fixed

- `zsh/.zshrc` had **two** hooks for the same job: `~/.zsh_aliases.local.sh`
  (sourced at line 38) and `~/.zsh_aliases_custom` (line 62, undocumented and
  absent on this machine). The first ran *before* `prompt.sh` and `~/.fzf.zsh`,
  so a machine-local override of either was silently clobbered. Consolidated
  to one block at the end of the file, which also sources `~/.zshrc.local` for
  machine-local exports and PATH, not just aliases.

- `install.sh` printed `${dirs[#]}`, which is a bash syntax error, and ran
  with no `set -e`, so a failing module was reported but the exit status was
  still 0. `--brew` also appended `brew` to a list that `ls -d */` already
  contained, installing it twice.
- `grc/install.sh` copied `grc.conf`, but the tracked file is `.grc.conf`, so
  the main grc config was never installed. Only `conf.gotest` worked.
- `code/install.sh` used a relative `settings.json`, so it only worked when
  the CWD happened to be `code/`. It now resolves through `ENV_ROOT` and
  skips cleanly when VS Code is absent.
- `git submodule foreach git pull origin` named no branch and failed in the
  detached HEAD a submodule checkout normally has. Replaced with
  `git submodule update --init --remote --recursive`, which also initialises
  a submodule on a first clone — previously `nvim/` was empty and its
  installer failed.
- `fonts/install.sh` ran `brew tap homebrew/cask-fonts` (deprecated; the
  fonts moved into `homebrew/cask`) and then
  `brew search '/font-.*-nerd-font/' | xargs brew install --cask`, installing
  every Nerd Font — 2067 font files, several GB, on this machine. It now
  installs only the fonts in `fonts/fonts`, which is just
  `font-fira-code-nerd-font`, the family `alacritty.toml` and `.wezterm.lua`
  actually name.
- `nvim/install.sh` ran `rm -rf ~/.config/nvim/*` before copying, destroying
  any local edit. It now links the submodule into place and clones
  `copilot.vim` under the gitignored `pack/`.

### Packages

Reconciled `brew/packages` and `brew/cask` with what is installed on this
machine. 36 formulae and 3 casks are now declared.

Added, present locally but undeclared: `asdf`, `colima`, `docker`,
`docker-buildx`, `docker-compose`, `docker-credential-helper`, `macmon`,
`ollama`, `rtk`, `tmux-sessionizer`, and the casks `libreoffice`,
`ollama-app`.

Also added `ripgrep`, which `nvim/README.md` lists as a dependency and which
telescope needs, but which was in neither the list nor the machine.

Renamed `ag` to its canonical name `the_silver_searcher`. `brew list` prints
canonical names only, so the alias would have read as permanently missing and
been reinstalled on every run.

Removed the duplicate `fzf` entry and grouped the list under comments.

Declared but **not installed** on this machine (23 of 36). `brew/install.sh`
only installs what is missing, so they are kept as intentional:
`the_silver_searcher`, `bat`, `bpython`, `cmake`, `cowsay`, `fzf`, `git-flow`,
`grc`, `grep`, `jq`, `k9s`, `kcat`, `kubectx`, `luarocks`, `mongocli`,
`netcat`, `pgcli`, `ripgrep`, `thefuck`, `tree`, `vegeta`, `yazi`, `yq`.

Two consequences of that gap, both pre-existing: `~/.fzf.zsh` fails on every
shell start because `fzf` is absent, and the `grc` config now installed has no
`grc` binary to read it.

`ghostty` was installed by hand and unmanaged; `brew install --adopt --cask`
took it over. `--adopt` is cask-only, so `brew/install.sh` passes it only for
casks — with `--formula` it is not a valid flag.

### nvim

The submodule pointer here was 19 commits stale (`6e207e5`, "fix: Install
ZLS"), and `~/.config/nvim` was a copy that matched neither it nor
`origin/main`. Fast-forwarded the submodule to `origin/main` (`73232c2`).

The live copy was compared against `origin/main` before anything was
replaced: upstream already contained every change in it and more, so nothing
was lost. It is backed up at `~/.config/nvim.bak-20261004-093815` and by the
installer at `~/.config/nvim.20261004-094842.bak`.

`plugin/packer_compiled.lua` was tracked despite `plugin/*` being gitignored;
it is generated, so it is now untracked. `pack/` and `lazy-lock.json` were
added to `.gitignore`, so the copilot.vim clone and plugin installs no longer
dirty the repo now that the live config is a symlink into it.

`nvim/install.sh` and `nvim/sync.sh` were rewritten to link rather than
`rm -rf` and copy. These are changes **in the submodule** and need their own
commit and push in `piotrpersona/nvim`.

Upstream `73232c2` adds `mason-tool-installer.nvim`, which is not downloaded
yet, so nvim prints a `require` error until `:PackerSync` runs. Pre-existing,
not caused by the symlink change.

### agents

Added as a submodule and synced to `f36a931`. Its own `install.sh` detects
that it is being run from inside a clone and relinked `~/.claude/rules`,
`~/.claude/hooks` and `~/.claude/statusline.sh` to this submodule.

Those links previously pointed at a standalone clone at
`~/developer/github.com/piotrpersona/agents`, which is now redundant. There
are two clones of the same repo on disk; the standalone one is no longer
linked from `~/.claude` and can be removed. `settings.json` was regenerated
and backed up to `settings.json.20261004-094845.bak`.

## Migration note — read before syncing another machine

The old `zsh/install.sh` ran `ls "$HOME/.zshrc" || cp -f ...`, so an existing
`~/.zshrc` was **never** overwritten. On this machine it had therefore diverged
for years, and the symlink migration replaced it with the repo version. What
was only in the live file:

`PATH` for flutter, opencode, LM Studio, pnpm and Qwen; `nvm` init; asdf init
plus the golang plugin's `set-env.zsh`; `. "$HOME/.local/bin/env"` for uv; and
the headroom env block (`ANTHROPIC_BASE_URL`, `HEADROOM_*`, `OPENAI_BASE_URL`).

All of it was restored to `~/.zshrc.local`, which is untracked and sourced
last. Two knock-on failures this explains:

- `go` was off `PATH`. The old line `. $(brew --prefix asdf)/libexec/asdf.sh`
  has been dead since asdf 0.16 became a Go binary — it is now 0.20.2 and
  ships no `asdf.sh`. Replaced with the shims directory on `PATH`. This one
  was broken before the migration, not by it.
- A Claude Code hook failed with `caveman: command not found`. `caveman` is an
  nvm-managed node binary, so losing the nvm block took it off `PATH`. The
  hooks live in the untracked `~/.claude/settings.machine.json`, not in the
  `agents` submodule, which has no `caveman` reference.

`zsh/install.sh` now detects that it replaced a real `~/.zshrc` and prints the
`diff` command to review the backup, so the next machine is not caught out.

## Fonts cleanup

The old `fonts/install.sh` had installed every Nerd Font: **2067 files,
8.0 GB** in `~/Library/Fonts`, none of it brew-managed. That also blocked
`font-fira-code-nerd-font` from installing, since brew will not adopt a font
whose existing copy differs — the files on disk were from April 2024.

Removed all 2060 `*NerdFont*` files and reinstalled just
`font-fira-code-nerd-font` through the cask, so the one family the terminal
configs name is now brew-managed and updates with `brew upgrade`.

Result: **8.0 GB -> 50 MB**, 25 files. Kept the six plain `FiraCode-*.ttf`
and the hand-patched `Monocraft-nerd-fonts-patched.ttf`, none of which came
from the bulk install. `FiraCode Nerd Font Mono` 3.5.1 is registered with the
system and `ghostty +validate-config` passes.
