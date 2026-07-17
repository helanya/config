#!/usr/bin/env bash
# 将仓库中的 dotFiles/.zshrc 同步到本机 ~/.zshrc
# 用法: ./setzshrc.sh [--backup|--no-backup]
#   --backup     覆盖前备份（默认）
#   --no-backup  不备份，直接覆盖
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
SRC="${SCRIPT_DIR}/../dotFiles/.zshrc"
DEST="${HOME}/.zshrc"

if [[ ! -f "$SRC" ]]; then
  echo "错误: 源文件不存在: $SRC" >&2
  exit 1
fi

if [[ "$BACKUP" -eq 1 && -f "$DEST" ]]; then
  BACKUP_FILE="${DEST}.bak.$(date +%Y%m%d%H%M%S)"
  cp "$DEST" "$BACKUP_FILE"
  echo "已备份: $BACKUP_FILE"
fi

cp "$SRC" "$DEST"
echo "已同步: $SRC -> $DEST"
