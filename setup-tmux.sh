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

echo "Installing tmux plugins..."
[ ! -d ~/.tmux/plugins/tmux-cpu ] && git clone https://github.com/tmux-plugins/tmux-cpu ~/.tmux/plugins/tmux-cpu && echo "✓ Installed tmux-cpu"
[ ! -d ~/.tmux/plugins/tmux-battery ] && git clone https://github.com/tmux-plugins/tmux-battery ~/.tmux/plugins/tmux-battery && echo "✓ Installed tmux-battery"
[ ! -d ~/.tmux/plugins/tmux ] && git clone https://github.com/catppuccin/tmux ~/.tmux/plugins/tmux && echo "✓ Installed catppuccin"
[ ! -d ~/.tmux/plugins/vim-tmux-navigator ] && git clone https://github.com/christoomey/vim-tmux-navigator ~/.tmux/plugins/vim-tmux-navigator && echo "✓ Installed vim-tmux-navigator"
[ ! -d ~/.tmux/plugins/tmux-sensible ] && git clone https://github.com/tmux-plugins/tmux-sensible ~/.tmux/plugins/tmux-sensible && echo "✓ Installed tmux-sensible"
[ ! -d ~/.tmux/plugins/tmuxifier ] && git clone https://github.com/jimeh/tmuxifier ~/.tmux/plugins/tmuxifier && echo "✓ Installed tmuxifier"
[ ! -d ~/.tmux/plugins/tmux-resurrect ] && git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect && echo "✓ Installed tmux-resurrect"
[ ! -d ~/.tmux/plugins/tmux-continuum ] && git clone https://github.com/tmux-plugins/tmux-continuum ~/.tmux/plugins/tmux-continuum && echo "✓ Installed tmux-continuum"

echo "✓ Tmux setup complete! All plugins installed. Start tmux to see the new status bar!"
