# Aliases
alias g="git"

# Prompt
LUNAR_PHASE=`curl -s wttr.in/Stockholm?format="%m"`
export PS1="$LUNAR_PHASE \[\e[1m\]\W\[$(tput sgr0)\[\e[0m\] "
