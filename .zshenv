# ~/.zshenv — sourced by ALL zsh invocations (login, interactive, scripts).
# Keep minimal. No PATH here: macOS /etc/zprofile runs path_helper AFTER this
# file, which would reorder anything we set. PATH lives in ~/.zprofile.

export EDITOR='vim'
export VISUAL="$EDITOR"
