#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

files_and_paths=(
  # common
  "nvim:~/.config/nvim"

  # linux
  ".zshrc:~/.zshrc"
  "starship.toml:~/.config/starship.toml"
  "tmux/tmux.conf:~/.config/tmux/tmux.conf"
)

# シンボリックリンクを作成する関数
create_symlink() {
  local source_relative_path="$1"
  local destination_raw_path="$2"
  local source_file
  local destination_path
  local backup_file

  source_file="$(realpath "${SCRIPT_DIR}/${source_relative_path}")"
  destination_path="${destination_raw_path/#\~/$HOME}"

  if [ ! -e "$source_file" ]; then
    echo "source not found: $source_file" >&2
    return 1
  fi

  mkdir -p "$(dirname "$destination_path")"

  backup_file="${destination_path}.bak.$(date +%Y%m%d%H%M%S)"     # 退避先のファイル名

  if [ -e "$destination_path" ]; then
    mv "$destination_path" "$backup_file"
  fi

  ln -s "$source_file" "$destination_path"  # シンボリックリンクの作成
}

for entry in "${files_and_paths[@]}"; do
  IFS=":" read -r source_file destination_path <<< "$entry"
  create_symlink "$source_file" "$destination_path"
done
