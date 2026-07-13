# dotfiles

My personal macOS shell, git, and vim configuration. Reproducible on a new
machine with a single script.

## Setup on a new machine

```sh
git clone <this-repo-url>
cd dotfiles
./install.sh
```

Then adjust the machine-local files the installer seeds for you:

1. `~/.gitconfig.local` — your git `name`/`email` (and any per-directory work identity).
2. `~/.zprofile.local` — machine PATH/env (Homebrew, version managers). Trim to what this machine has.
3. `~/.zshrc.local` — secrets (e.g. `NPM_TOKEN`) and work-specific env/aliases.

Open a new shell (or `exec zsh -l`) to load everything.

`install.sh` **copies** files into `$HOME`. It backs up any existing file that
would change into `~/.dotfiles-backup/<timestamp>/` first, and it **never**
overwrites an existing `*.local` file. Re-run it any time you pull updates; if
nothing changed it copies nothing.

## What's here

| Repo file | Installs to | Purpose |
|-----------|-------------|---------|
| `.zshenv` | `~/.zshenv` | Env for all zsh invocations (minimal; `EDITOR`). |
| `.zprofile` | `~/.zprofile` | Login-shell entry point. Sources `~/.zprofile.local` for machine PATH/env. |
| `.zshrc` | `~/.zshrc` | Interactive shell: completion, history, git-aware prompt, keybindings. Sources `~/.zshrc.local`. |
| `.vimrc` | `~/.vimrc` | Vim settings. |
| `.gitconfig` | `~/.gitconfig` | Git settings. Identity-free; includes `~/.gitconfig.local`. |
| `.hushlogin` | `~/.hushlogin` | Silences the login banner. |

### Local, untracked files (created per machine)

| File | Seeded from | Holds |
|------|-------------|-------|
| `~/.gitconfig.local` | `.gitconfig.local.example` | Your `[user]` identity + optional per-directory `includeIf`. |
| `~/.zprofile.local` | `.zprofile.local.example` | Machine PATH/env. |
| `~/.zshrc.local` | `.zshrc.local.example` | Secrets and work env/aliases. |

### Per-directory identity (optional)

To use a different git identity for repos under a directory, uncomment the
`includeIf` block in `~/.gitconfig.local` and point it at an override file you
create (e.g. `~/.gitconfig.work`), which just sets the alternate `[user]`:

```gitconfig
[includeIf "gitdir:~/path/to/work/"]
	path = ~/.gitconfig.work
```

## Secrets

Never put tokens or passwords in tracked files — only in `~/.zshrc.local`.
