#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up zsh configuration..."

ln -sf "${DOTFILES_DIR}/zshrc" "${HOME}/.zshrc"
echo "  ✓ Linked zshrc"

ln -sf "${DOTFILES_DIR}/p10k.zsh" "${HOME}/.p10k.zsh"
echo "  ✓ Linked p10k.zsh"

echo "✓ Zsh setup complete!"
