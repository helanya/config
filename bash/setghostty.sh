#!/usr/bin/env bash
# 将仓库中的 ghostty / starship 配置同步到本机
# 用法: ./setghostty.sh [--backup|--no-backup]
#   --backup     覆盖前备份（默认）
#   --no-backup  不备份，直接覆盖
#
# 同步映射:
#   dotFiles/ghostty/config        -> ~/.config/ghostty/config
#   dotFiles/ghostty/starship.toml -> ~/.config/starship.toml
set -euo pipefail

BACKUP=1

usage() {
  echo "用法: $0 [--backup|--no-backup]" >&2
  echo "  --backup, -b      覆盖前备份本地文件（默认）" >&2
  echo "  --no-backup, -n   不备份，直接覆盖" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --backup|-b) BACKUP=1; shift ;;
    --no-backup|-n) BACKUP=0; shift ;;
    -h|--help) usage ;;
    *) echo "未知参数: $1" >&2; usage ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="${SCRIPT_DIR}/../dotFiles/ghostty"

sync_file() {
  local src="$1"
  local dest="$2"
  local dest_dir

  if [[ ! -f "$src" ]]; then
    echo "错误: 源文件不存在: $src" >&2
    exit 1
  fi

  dest_dir="$(dirname "$dest")"
  mkdir -p "$dest_dir"

  if [[ "$BACKUP" -eq 1 && -f "$dest" ]]; then
    local backup_file="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    cp "$dest" "$backup_file"
    echo "已备份: $backup_file"
  fi

  cp "$src" "$dest"
  echo "已同步: $src -> $dest"
}

sync_file "${DOTFILES}/config" "${HOME}/.config/ghostty/config"
sync_file "${DOTFILES}/starship.toml" "${HOME}/.config/starship.toml"
