#!/usr/bin/env bash

echo "Installing tmux prerequisites..."
brew install tmux fzf

echo "Installing tmux configuration..."
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
echo "✓ Linked tmux.conf"

mkdir -p ~/.local/bin
ln -sf ~/dotfiles/tmux-sessionizer ~/.local/bin/tmux-sessionizer
chmod +x ~/dotfiles/tmux-sessionizer
echo "✓ Linked tmux-sessionizer"

if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "✓ Installed TPM"
else
    echo "✓ TPM already installed"
fi

echo "✓ Tmux setup complete! Press Ctrl-Space + I to install plugins"
