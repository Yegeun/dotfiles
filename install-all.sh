#!/usr/bin/env bash

echo "========================================="
echo "Installing all dotfiles..."
echo "========================================="

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

cd ~/dotfiles

bash install-zsh.sh
bash install-tmux.sh
bash install-nvim.sh
bash install-wezterm.sh
bash install-lazygit.sh

echo "========================================="
echo "✓ All dotfiles installed!"
echo "========================================="
