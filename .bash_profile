LUNAR_PHASE=`curl -s wttr.in/Stockholm?format="%m"`

export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1
export PS1="$LUNAR_PHASE \[\e[1m\]\W\[$(tput sgr0)\[\e[0m\] "

alias ..="cd .."
alias g="git"
alias v="vim"
