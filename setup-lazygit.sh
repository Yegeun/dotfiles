#!/usr/bin/env bash

echo "Installing lazygit prerequisites..."
brew install lazygit

echo "Installing lazygit configuration..."
mkdir -p ~/.config/lazygit
ln -sf ~/dotfiles/lazygit-config.yml ~/.config/lazygit/config.yml
echo "✓ Lazygit setup complete!"
