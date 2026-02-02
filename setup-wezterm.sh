#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up wezterm configuration..."

# Create config directory and symlink
mkdir -p "${HOME}/.config"
ln -sf "${DOTFILES_DIR}/wezterm" "${HOME}/.config/wezterm"
echo "  ✓ Linked wezterm config"

echo "✓ Wezterm setup complete!"
