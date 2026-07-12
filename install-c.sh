#!/usr/bin/env bash
set -euo pipefail

PROGRAM="genf"
SOURCE="genf.c"

if [[ ! -f "$SOURCE" ]]; then
    echo "Error: $SOURCE not found."
    exit 1
fi

if command -v gcc >/dev/null 2>&1; then
    CC=gcc
elif command -v clang >/dev/null 2>&1; then
    CC=clang
else
    echo "Error: gcc or clang is required."
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    PREFIX="/usr/local/bin"
else
    PREFIX="$HOME/.local/bin"
    mkdir -p "$PREFIX"
fi

echo "Compiling with $CC..."
$CC -O2 -Wall -Wextra "$SOURCE" -o "$PROGRAM"

echo "Installing to $PREFIX..."
install -m755 "$PROGRAM" "$PREFIX/$PROGRAM"

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
