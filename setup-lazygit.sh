#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up lazygit configuration..."

# Install lazygit if not already installed
if ! command -v lazygit &> /dev/null; then
    echo "  Installing lazygit..."
    brew install lazygit
fi

# Create config directory and symlink
mkdir -p "${HOME}/.config/lazygit"
ln -sf "${DOTFILES_DIR}/lazygit-config.yml" "${HOME}/.config/lazygit/config.yml"

echo "✓ Lazygit setup complete!"
