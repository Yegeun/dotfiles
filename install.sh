#!/bin/bash

# Dotfiles installer
DOTFILES_DIR="$HOME/dotfiles"

# Create config directories if they don't exist
mkdir -p ~/.config
mkdir -p ~/Library/Application\ Support/lazygit

# Remove existing configs (backup first if they exist)
[ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup
[ -e ~/.config/wezterm ] && mv ~/.config/wezterm ~/.config/wezterm.backup
[ -e ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -e ~/.p10k.zsh ] && mv ~/.p10k.zsh ~/.p10k.zsh.backup
[ -e ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
[ -e ~/Library/Application\ Support/lazygit/config.yml ] && mv ~/Library/Application\ Support/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml.backup

# Create symlinks
ln -s "$DOTFILES_DIR/nvim" ~/.config/nvim
ln -s "$DOTFILES_DIR/wezterm" ~/.config/wezterm
ln -s "$DOTFILES_DIR/zshrc" ~/.zshrc
ln -s "$DOTFILES_DIR/p10k.zsh" ~/.p10k.zsh
ln -s "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
ln -s "$DOTFILES_DIR/lazygit-config.yml" ~/Library/Application\ Support/lazygit/config.yml

# Install TPM (Tmux Plugin Manager) if not exists
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "TPM installed. Run 'tmux source ~/.tmux.conf' then 'Prefix + I' to install plugins"
fi

echo "Dotfiles installed successfully!"
