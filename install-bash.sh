#!/usr/bin/env bash
set -euo pipefail

PROGRAM="genf"
SOURCE="genf.sh"
INSTALL_DIR="/usr/local/bin"

if [[ ! -f "$SOURCE" ]]; then
    echo "Error: $SOURCE not found."
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
    echo "Please run this installer with sudo:"
    echo "  sudo ./install-bash.sh"
    exit 1
fi

echo "Installing $PROGRAM to $INSTALL_DIR/$PROGRAM..."

install -m 755 "$SOURCE" "$INSTALL_DIR/$PROGRAM"

echo
echo "Installed successfully!"
echo "Run it with:"
echo "  genf"
