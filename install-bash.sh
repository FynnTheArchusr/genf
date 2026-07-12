#!/usr/bin/env bash
set -euo pipefail

PROGRAM="genf"
SCRIPT="genf.sh"

# Find the directory this installer is located in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -f "$SCRIPT_DIR/$SCRIPT" ]]; then
    echo "Error: $SCRIPT not found in $SCRIPT_DIR"
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    PREFIX="/usr/local/bin"
else
    PREFIX="$HOME/.local/bin"
    mkdir -p "$PREFIX"
fi

echo "Installing $PROGRAM..."

install -m755 "$SCRIPT_DIR/$SCRIPT" "$PREFIX/$PROGRAM"

echo
echo "Installed successfully!"
echo "Location: $PREFIX/$PROGRAM"
echo

if [[ ":$PATH:" != *":$PREFIX:"* ]]; then
    echo "NOTE: $PREFIX is not in your PATH."
    echo "Add this line to your shell config:"
    echo
    echo "export PATH=\"$PREFIX:\$PATH\""
    echo
fi

echo "Run with:"
echo "  $PROGRAM"
