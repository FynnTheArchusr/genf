#!/usr/bin/env bash
set -euo pipefail

PROGRAM="genf"
SOURCE="genf.c"
INSTALL_DIR="/usr/local/bin"

if [[ ! -f "$SOURCE" ]]; then
    echo "Error: $SOURCE not found."
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
    echo "Please run this installer with sudo:"
    echo "  sudo ./install-c.sh"
    exit 1
fi

if command -v gcc >/dev/null 2>&1; then
    CC="gcc"
elif command -v clang >/dev/null 2>&1; then
    CC="clang"
else
    echo "Error: gcc or clang is required."
    exit 1
fi

echo "Compiling $PROGRAM..."
$CC -O2 -Wall -Wextra "$SOURCE" -o "$PROGRAM"

echo "Installing to $INSTALL_DIR/$PROGRAM..."
install -m 755 "$PROGRAM" "$INSTALL_DIR/$PROGRAM"

rm -f "$PROGRAM"

echo
echo "Installed successfully!"
echo "Run it with:"
echo "  genf"
