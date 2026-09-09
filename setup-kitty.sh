#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up kitty configuration..."

# Create config directory and symlink
mkdir -p "${HOME}/.config"
ln -sfn "${DOTFILES_DIR}/kitty" "${HOME}/.config/kitty"
echo "  ✓ Linked kitty config"

echo "✓ Kitty setup complete!"
