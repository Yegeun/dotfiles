#!/usr/bin/env bash

echo "Installing zsh configuration..."

ln -sf ~/dotfiles/zshrc ~/.zshrc
echo "✓ Linked zshrc"

ln -sf ~/dotfiles/p10k.zsh ~/.p10k.zsh
echo "✓ Linked p10k.zsh"

echo "✓ Zsh setup complete!"
