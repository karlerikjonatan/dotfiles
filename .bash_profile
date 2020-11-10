GIT_BRANCH() {
  a=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$a" ]; then
    echo " $a"
  else
    echo ""
  fi
}

PS1="\[\e[1m\]\W\[\e[0m\]$(GIT_BRANCH) "

export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1

alias ..="cd .."
alias ls="ls -la"
alias g="git"
alias v="vim"
