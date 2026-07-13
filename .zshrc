# ~/.zshrc — sourced for INTERACTIVE shells only.
# Env & PATH live in ~/.zshenv and ~/.zprofile.

# ─── Completion (full security check at most once/24h, else fast) ───
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# ─── Prompt plumbing ───
autoload -Uz vcs_info add-zsh-hook

# ─── Local, untracked secrets (e.g. NPM_TOKEN). Not committed. ───
# Sourced here (interactive). Move to ~/.zshenv if non-interactive shells need it.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# ─── History ───
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

# ─── Shell options ───
setopt prompt_subst
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB
setopt NO_BEEP

# ─── Completion styles ───
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

# ─── Prompt (git-aware via vcs_info) ───
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr   '%F{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' formats       '%F{cyan}%b%f%c%u'
zstyle ':vcs_info:git:*' actionformats '%F{yellow}%b|%a%f%c%u'

# Untracked-files marker: append a red '?' when the tree has untracked files.
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if git rev-parse --is-inside-work-tree &>/dev/null && \
     git status --porcelain 2>/dev/null | grep -q '^??'; then
    hook_com[unstaged]+='%F{red}?%f'
  fi
}

add-zsh-hook precmd vcs_info

# path (current folder) + git + status-colored ❯
PROMPT='%F{green}%C%f${vcs_info_msg_0_:+ }${vcs_info_msg_0_} %(?.%F{green}.%F{red})❯%f '

# ─── Keybindings ───
bindkey -e
# Prefix-aware history search on Up/Down (type a prefix, arrows cycle matches).
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Treat '/' as a word separator so ^W / M-b / M-f stop at path segments.
WORDCHARS=${WORDCHARS//[\/]}
