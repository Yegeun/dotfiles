#!/usr/bin/env bash

echo "Installing wezterm configuration..."

mkdir -p ~/.config
ln -sf ~/dotfiles/wezterm ~/.config/wezterm
echo "✓ Linked wezterm config"

echo "✓ Wezterm setup complete!"
