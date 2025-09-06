autoload -Uz vcs_info

precmd_functions+=(_vcs_info_hook)
_vcs_info_hook() { vcs_info }

setopt prompt_subst

zstyle ':vcs_info:git:*' formats '%b'

RPROMPT='${vcs_info_msg_0_}'
PROMPT='%. '

export CLICOLOR=1
