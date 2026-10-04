# Developer environment

Dotfiles and machine setup for macOS. Config files are **symlinked** out of
this repo, so editing `~/.zshrc` edits `zsh/.zshrc` here, and `git pull` is
enough to roll out a change.

## Install

```bash
git clone --recurse-submodules https://github.com/piotrpersona/environment.git
./environment/install.sh --brew
```

## Sync

```bash
./install.sh              # pull submodules, relink every config
./install.sh --brew       # ... and install brew formulae, casks and fonts
./install.sh zsh nvim     # only the named modules
./install.sh --list       # show the modules
```

Re-running is safe. An existing real file at a link target is moved aside as
`<target>.<stamp>.bak`, never deleted.

## Modules

| module | what it does |
| --- | --- |
| `core` | Homebrew, `~/work`, `~/developer`, `~/.ssh`, key repeat rate |
| `brew` | formulae from `brew/packages`, casks from `brew/cask` (opt-in) |
| `fonts` | Nerd Font casks from `fonts/fonts` (opt-in) |
| `zsh` | `.zshrc`, `.zsh_aliases.sh`, `prompt.sh` |
| `git` | global `.gitignore` and `git config` |
| `gh` | GitHub CLI config, aliases, extensions, auth check |
| `tmux` | `.tmux.conf` |
| `alacritty` | `~/.config/alacritty/alacritty.toml` |
| `wezterm` | `~/.wezterm.lua` |
| `grc` | `~/.grc/grc.conf`, `~/.grc/conf.gotest` |
| `code` | VS Code `settings.json` (skipped if VS Code is absent) |
| `nvim` | submodule, linked to `~/.config/nvim` |
| `agents` | submodule, Claude Code config in `~/.claude` |

Machine-local shell additions go in `~/.zsh_aliases.local.sh`, which
`.zshrc` sources if it exists and which is never tracked.

## Supported operating systems

macOS.
