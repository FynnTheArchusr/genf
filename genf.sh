#!/usr/bin/env bash
set -euo pipefail

name="${USER:-$(whoami 2>/dev/null || echo user)}"
cpu() { lscpu 2>/dev/null | awk -F: '/Model name/ {sub(/^[ \t]+/,"",$2); print $2; exit}'; }

pink=$'\033[35m'
reset=$'\033[0m'

printf '%bGentooBox%b %b%s%b\n' "$pink" "$reset" $'\033[34m' "$name" "$reset"
printf '%bCPU%b: %s\n' $'\033[33m' "$reset" "$(cpu || echo Unknown)"

printf '%b%s%b\n' "$pink" '┏━━━┓━━━━━━━━━┏┓━━━━━━━━━
┃┏━┓┃━━━━━━━━┏┛┗┓━━━━━━━━
┃┃━┗┛┏━━┓┏━┓━┗┓┏┛┏━━┓┏━━┓
┃┃┏━┓┃┏┓┃┃┏┓┓━┃┃━┃┏┓┃┃┏┓┃
┃┗┻━┃┃┃━┫┃┃┃┃━┃┗┓┃┗┛┃┃┃┗┛
┗━━━┛┗━━┛┗┛┗┛━┗━┛┗━━┛┗━━┛
━━━━━━━━━━━━━━━━━━━━━━━━━
━━━━━━━━━━━━━━━━━━━━━━━━━' "$reset"
