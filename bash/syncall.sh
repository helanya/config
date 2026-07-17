#!/usr/bin/env bash
# 同步仓库中全部配置到本机
# 用法: ./syncall.sh [--backup|--no-backup]
#   --backup     覆盖前备份（默认）
#   --no-backup  不备份，直接覆盖
#
# 会依次调用:
#   setzshrc.sh   -> ~/.zshrc, ~/.zprofile
#   setghostty.sh -> ~/.config/ghostty/config, ~/.config/starship.toml
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  echo "用法: $0 [--backup|--no-backup]" >&2
  echo "  --backup, -b      覆盖前备份本地文件（默认）" >&2
  echo "  --no-backup, -n   不备份，直接覆盖" >&2
  echo "" >&2
  echo "同步全部配置:" >&2
  echo "  .zshrc / .zprofile / ghostty config / starship.toml" >&2
  exit 1
}

for arg in "$@"; do
  case "$arg" in
    -h|--help) usage ;;
  esac
done

echo "==> 同步 zshrc / zprofile"
"${SCRIPT_DIR}/setzshrc.sh" "$@"

echo "==> 同步 ghostty / starship"
"${SCRIPT_DIR}/setghostty.sh" "$@"

echo "==> 全部同步完成"
