#!/bin/sh
# install.sh — copy these dotfiles into $HOME.
#
# - Backs up any existing target that differs (into ~/.dotfiles-backup/<timestamp>/)
#   before overwriting, so nothing is lost.
# - Seeds local override files (~/.gitconfig.local, ~/.zshrc.local) from their
#   *.example templates ONLY if they don't already exist — real secrets are never
#   clobbered.
# - Idempotent: re-running when nothing changed copies nothing.
#
# Usage:  ./install.sh
set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
changed=0

# Copy $REPO_DIR/$1 to $2, backing up an existing, differing target first.
install_file() {
	src="$REPO_DIR/$1"
	dest="$2"
	if [ ! -f "$src" ]; then
		echo "  skip   $1 (missing in repo)"
		return
	fi
	if [ -e "$dest" ] && cmp -s "$src" "$dest"; then
		echo "  ok     $dest (unchanged)"
		return
	fi
	if [ -e "$dest" ]; then
		mkdir -p "$BACKUP_DIR"
		cp -p "$dest" "$BACKUP_DIR/"
		echo "  backup $dest -> $BACKUP_DIR/"
	fi
	cp "$src" "$dest"
	echo "  copy   $1 -> $dest"
	changed=1
}

# Seed $2 from template $REPO_DIR/$1 only if $2 does not already exist.
seed_file() {
	src="$REPO_DIR/$1"
	dest="$2"
	mode="${3:-644}"
	if [ -e "$dest" ]; then
		echo "  keep   $dest (exists — not overwritten)"
		return
	fi
	cp "$src" "$dest"
	chmod "$mode" "$dest"
	echo "  seed   $dest (from $1 — edit it and fill in real values)"
	changed=1
}

echo "Installing dotfiles from $REPO_DIR"
echo

# --- tracked dotfiles: repo file -> target ---
install_file ".zshenv"          "$HOME/.zshenv"
install_file ".zprofile"        "$HOME/.zprofile"
install_file ".zshrc"           "$HOME/.zshrc"
install_file ".vimrc"           "$HOME/.vimrc"
install_file ".gitconfig"       "$HOME/.gitconfig"
install_file ".hushlogin"       "$HOME/.hushlogin"

echo

# --- local overrides: seed from templates, never overwrite real ones ---
seed_file ".gitconfig.local.example" "$HOME/.gitconfig.local"
seed_file ".zprofile.local.example"  "$HOME/.zprofile.local"
seed_file ".zshrc.local.example"     "$HOME/.zshrc.local" 600

echo
if [ "$changed" -eq 1 ]; then
	echo "Done. Next steps:"
	echo "  1. Edit ~/.gitconfig.local  — set your name/email."
	echo "  2. Edit ~/.zshrc.local      — add secrets/work env (kept out of git)."
	echo "  3. Open a new shell (or: exec zsh -l)."
	[ -d "$BACKUP_DIR" ] && echo "  Backups of replaced files: $BACKUP_DIR"
else
	echo "Done. Everything already up to date."
fi
