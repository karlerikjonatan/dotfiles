parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1
export PS1="\[$(tput bold)\]\W\[$(tput sgr0)\]\e[2m\$(parse_git_branch)\e[m "

alias ..="cd .."
alias g="git"
alias v="vim"
