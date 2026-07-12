#!/usr/bin/env bash
set -euo pipefail

PROGRAM="genf"
SCRIPT="genf.sh"

if [[ ! -f "$SCRIPT" ]]; then
    echo "Error: $SCRIPT not found."
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    PREFIX="/usr/local/bin"
else
    PREFIX="$HOME/.local/bin"
    mkdir -p "$PREFIX"
fi

install -m755 "$SCRIPT" "$PREFIX/$PROGRAM"

echo
echo "Installed successfully!"
echo

if [[ ":$PATH:" != *":$PREFIX:"* ]]; then
    echo "NOTE:"
    echo "Add this to your shell configuration:"
    echo
    echo "export PATH=\"$PREFIX:\$PATH\""
fi

echo
echo "Run with:"
echo "  $PROGRAM"
