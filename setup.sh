#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(
  .zshrc
  .vimrc
  .gitconfig
  .hushlogin
)

BACKUP_DIR=""

backup_if_needed() {
  local target="$1"
  local file_name
  file_name="$(basename "$target")"

  if [[ -e "$target" || -L "$target" ]]; then
    if [[ -z "$BACKUP_DIR" ]]; then
      BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"
      mkdir -p "$BACKUP_DIR"
      echo "Created backup directory: $BACKUP_DIR"
    fi

    mv "$target" "$BACKUP_DIR/$file_name"
    echo "Backed up: $target -> $BACKUP_DIR/$file_name"
  fi
}

for file in "${FILES[@]}"; do
  source_file="$DOTFILES_DIR/$file"
  target_file="$HOME/$file"

  if [[ ! -e "$source_file" ]]; then
    echo "Skipping missing source file: $source_file"
    continue
  fi

  if [[ -L "$target_file" ]] && [[ "$(readlink "$target_file")" == "$source_file" ]]; then
    echo "Already linked: $target_file"
    continue
  fi

  backup_if_needed "$target_file"
  ln -s "$source_file" "$target_file"
  echo "Linked: $target_file -> $source_file"
done

if [[ -n "$BACKUP_DIR" ]]; then
  echo "Done. Previous files were saved in: $BACKUP_DIR"
else
  echo "Done. No existing files needed backup."
fi
