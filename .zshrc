autoload -Uz vcs_info add-zsh-hook
autoload -Uz compinit

compinit

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt AUTO_CD
setopt AUTO_PUSHD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt PUSHD_IGNORE_DUPS

setopt prompt_subst

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats '%F{cyan}%b%c%u%f'
zstyle ':vcs_info:git:*' actionformats '%F{yellow}%b|%a%c%u%f'

add-zsh-hook precmd vcs_info

PROMPT='%F{green}%1~%f${vcs_info_msg_0_:+ }${vcs_info_msg_0_} '

export CLICOLOR=1
export LSCOLORS='ExFxCxDxBxegedabagacad'

export EDITOR='vim'
export VISUAL="$EDITOR"
