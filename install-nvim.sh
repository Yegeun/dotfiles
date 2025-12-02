#!/usr/bin/env bash

echo "Installing nvim prerequisites..."
brew install neovim ripgrep fzf

echo "Installing nvim configuration..."
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim
echo "✓ Nvim setup complete!"
