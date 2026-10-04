# Developer environment

Dotfiles and machine setup for macOS. Config files are **symlinked** out of
this repo, so editing `~/.zshrc` edits `zsh/.zshrc` here, and `git pull` is
enough to roll out a change.

## Install

```bash
git clone https://github.com/piotrpersona/environment.git
./environment/install.sh --brew
```

## Sync

```bash
./install.sh              # relink every config
./install.sh --brew       # ... and install brew formulae, casks and fonts
./install.sh zsh git      # only the named modules
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
| `zsh` | `.zshrc`, `.zsh_aliases.sh` |
| `git` | global `.gitignore` and `git config` |
| `gh` | GitHub CLI config, aliases, extensions, auth check |
| `tmux` | `.tmux.conf` |
| `grc` | `~/.grc/grc.conf`, `~/.grc/conf.gotest` |
| `notes` | the `note` command and `Log.app`, the Spotlight note launcher |

Machine-local shell additions go in `~/.zsh_aliases.local.sh`, which
`.zshrc` sources if it exists and which is never tracked.

## Related repos

Neovim and the Claude Code config are **separate repos**, not modules here.
They were submodules; each is now cloned and installed on its own, so a change
to either needs no commit in this repo.

| repo | clone to | installs into |
| --- | --- | --- |
| [`piotrpersona/nvim`](https://github.com/piotrpersona/nvim) | `~/developer/github.com/piotrpersona/nvim` | `~/.config/nvim` |
| [`piotrpersona/agents`](https://github.com/piotrpersona/agents) | `~/developer/github.com/piotrpersona/agents` | `~/.claude` |

```bash
curl -fsSL https://raw.githubusercontent.com/piotrpersona/nvim/main/sync.sh | bash
curl -fsSL https://raw.githubusercontent.com/piotrpersona/agents/main/install.sh | bash
```

Both link rather than copy, and both move an existing real file aside as
`<target>.<stamp>.bak` instead of deleting it. Each repo's `CLAUDE.md` requires
an agent to diff the live config against the repo and report anything
destructive **before** running the installer.

## Quick notes

CMD+Space, type `log`, Enter: a new Ghostty window opens `nvim` on
`~/notes/<date>_<time>.md`, already in insert mode. Quit without writing and
no file is left behind.

The same thing in the terminal you already have open:

```bash
note              # in this terminal
note --window     # in a new Ghostty window, like Log.app does
NOTES_DIR=~/work/notes note
```

`~/Applications/Log.app` is a two-file bundle (`Info.plist` and a launcher
that execs `~/.local/bin/note`), both symlinked out of `notes/`. The app is
called "Log" because an app named "Note" loses to Apple's Notes.app in
Spotlight, and the command is called `note` because macOS already ships
`/usr/bin/log`.

## Supported operating systems

macOS.

## Tool reference

Fast lookup for everything this repo installs or defines. **Keep it in sync:**
adding a tool to `brew/packages`, `brew/cask`, `fonts/fonts`, `gh/aliases` or
an alias to `zsh/.zsh_aliases.sh` means adding its row here in the same commit.

### Brew formulae

Source: `brew/packages`.

| tool | description |
| --- | --- |
| `the_silver_searcher` | Code search (`ag`), similar to ack. |
| `bat` | `cat` with syntax highlighting and git integration. |
| `fzf` | Command-line fuzzy finder, used by several aliases below. |
| `grc` | Colourises log files and command output. |
| `grep` | GNU grep, for the BSD-incompatible flags. |
| `ripgrep` | Fast recursive search (`rg`), respects `.gitignore`. |
| `tree` | Prints a directory as a tree. |
| `thefuck` | Corrects the previous mistyped command. |
| `cmake` | Cross-platform build generator. |
| `luarocks` | Lua package manager, needed by some nvim plugins. |
| `neovim` | The editor; its config is the separate `nvim` repo. |
| `gh` | GitHub CLI, configured by the `gh` module. |
| `asdf` | Version manager for Go, Python, Node and more. |
| `colima` | Container runtime for macOS, the Docker Desktop replacement. |
| `docker` | Docker CLI for building and running containers. |
| `docker-buildx` | Docker CLI plugin for BuildKit builds. |
| `docker-compose` | Runs multi-container environments from a compose file. |
| `docker-credential-helper` | Stores Docker registry credentials in the macOS keychain. |
| `jq` | Command-line JSON processor; also merges `settings.json` in the agents repo. |
| `yq` | Same idea as jq for YAML, XML, CSV and properties files. |
| `pgcli` | Postgres client with auto-completion and syntax highlighting. |
| `yazi` | Fast terminal file manager. |
| `tmux-sessionizer` | Opens a git repo as a tmux session. |
| `rtk` | CLI proxy that condenses command output to save LLM tokens. |
| `ca-certificates` | Mozilla CA certificate store. |

### Casks and fonts

Source: `brew/cask` and `fonts/fonts`; both are opt-in behind `--brew`.

| tool | description |
| --- | --- |
| `ghostty` | GPU-accelerated terminal, configured by the `ghostty` module. |
| `libreoffice` | Office suite. |
| `font-fira-code-nerd-font` | The font every terminal config here names. |

### Shell aliases

Source: `zsh/.zsh_aliases.sh`.

| tool | description |
| --- | --- |
| `v` | Opens nvim; takes a path, so `v .` for the directory. |
| `zshrc` | Edits `~/.zshrc` and re-sources it. |
| `l` | Long listing including hidden files (`ls -lah`). |
| `work` | Changes to `~/work`. |
| `dev` | Changes to `~/developer`. |
| `bpy` | Starts bpython, if it is installed; not in `brew/packages`. |
| `distro` | Prints the Linux release files. |
| `uuid` | Generates a UUIDv7 and copies it to the clipboard. |
| `gitignore` | Fetches a `.gitignore` template from toptal.com. |
| `mkgit` | Creates a directory and inits a git repo in it on `main`. |

### Commands

Source: `notes/note.sh`, linked to `~/.local/bin/note`.

| tool | description |
| --- | --- |
| `note` | Opens nvim on a fresh timestamped note in `~/notes`, in insert mode. |
| `note --window` | The same in a new Ghostty window; this is what `Log.app` runs. |

### Git aliases

| tool | description |
| --- | --- |
| `g` | `git`. |
| `gs` / `gl` | Status / log. |
| `ga` / `gaa` | Stages a path / stages everything. |
| `grs` | Unstages everything, keeping the changes. |
| `gc` / `gcm` / `gca` | Commit / signed-off with a message / signed-off all tracked. |
| `gcam` / `gcane` | Amends with an editor / amends keeping the message. |
| `gcanef` | Amends keeping the message, then force-pushes with lease. |
| `gp` / `gpa` / `gpaf` | Push / push the current branch and tags upstream / same with lease. |
| `gf` / `gpl` | Fetches all tags / pulls the current branch with rebase. |
| `goo` / `gob` | Checks out a branch / creates and checks out one. |
| `gbr` / `gba` | Lists local branches / all branches. |
| `gm` | Merge; this repo prefers rebase, so it is rarely the right call. |
| `gsq` | Interactive autosquash rebase back to the merge base with `origin/main`. |
| `ghome` | Changes to the repository root. |

### Kubernetes aliases

| tool | description |
| --- | --- |
| `k` / `kg` / `kd` | `kubectl` / `get` / `describe`. |
| `kgpo` / `kdpo` | Gets pods / describes a pod. |
| `kdpof` | Picks a pod with fzf and describes it through `bat`. |
| `kgpoy` | Picks a pod with fzf and prints its YAML through `bat`. |
| `kt` | `kubetail`, tails logs across pods. |

### gh aliases

Source: `gh/aliases`.

| tool | description |
| --- | --- |
| `gh co` | Checks out a pull request locally. |
| `gh prs` | Lists your own open pull requests. |
| `gh prv` | Opens the current pull request in a browser. |
| `gh repos` | Lists up to 50 of your repositories. |
| `gh watch` | Watches a running workflow. |
