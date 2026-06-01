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
      if ! mkdir -p "$BACKUP_DIR"; then
        echo "Failed to create backup directory: $BACKUP_DIR" >&2
        exit 1
      fi
      echo "Created backup directory: $BACKUP_DIR"
    fi

    if ! mv "$target" "$BACKUP_DIR/$file_name"; then
      echo "Failed to back up $target to $BACKUP_DIR/$file_name. Check file permissions and try again." >&2
      exit 1
    fi
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

  link_target="$(readlink "$target_file" 2>/dev/null || true)"
  if [[ -L "$target_file" ]] && [[ "$link_target" == "$source_file" ]]; then
    echo "Already linked: $target_file"
    continue
  fi

  backup_if_needed "$target_file"
  if ! ln -s "$source_file" "$target_file"; then
    echo "Failed to create symlink: $target_file -> $source_file" >&2
    exit 1
  fi
  echo "Linked: $target_file -> $source_file"
done

if [[ -n "$BACKUP_DIR" ]]; then
  echo "Done. Previous files were saved in: $BACKUP_DIR"
else
  echo "Done. No existing files needed backup."
fi
