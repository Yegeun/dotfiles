#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up nvim configuration..."

# Install prerequisites if not already installed
for tool in ripgrep fzf; do
    if ! command -v $tool &> /dev/null; then
        echo "  Installing $tool..."
        brew install $tool
    fi
done

# Create config directory and symlink
mkdir -p "${HOME}/.config"
ln -sf "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
echo "  ✓ Linked nvim config"

echo "✓ Nvim setup complete!"
