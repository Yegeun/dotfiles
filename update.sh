#!/usr/bin/env bash

set -e

echo "========================================="
echo "🔄 Updating dotfiles..."
echo "========================================="
echo ""

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Pull latest changes from git
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "📥 Pulling latest changes..."
    git pull
    echo "✓ Git repository updated"
else
    echo "⚠️  Not a git repository, skipping git pull"
fi
echo ""

# Update Homebrew and upgrade packages
if command -v brew &> /dev/null; then
    echo "📦 Updating Homebrew packages..."
    brew update
    brew upgrade
    echo "✓ Homebrew packages updated"
else
    echo "⚠️  Homebrew not found, skipping package updates"
fi
echo ""

# Re-run setup scripts to refresh symlinks
echo "========================================="
echo "🔗 Refreshing symlinks..."
echo "========================================="
echo ""

bash setup-zsh.sh
echo ""

bash setup-nvim.sh
echo ""

bash setup-tmux.sh
echo ""

bash setup-wezterm.sh
echo ""

bash setup-lazygit.sh
echo ""

# Update tmux plugins
if command -v tmux &> /dev/null && [ -d "${HOME}/.tmux/plugins/tpm" ]; then
    echo "🔌 Updating tmux plugins..."
    "${HOME}/.tmux/plugins/tpm/bin/update_plugins" all
    echo "✓ Tmux plugins updated"
fi
echo ""

# Update Powerlevel10k
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "⚡ Updating Powerlevel10k..."
    cd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    git pull
    cd "$DOTFILES_DIR"
    echo "✓ Powerlevel10k updated"
fi
echo ""

echo "========================================="
echo "✨ Update complete!"
echo "========================================="
echo ""
echo "To apply changes:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. In tmux, press backtick + U to update plugins"
echo "3. In nvim, run :Lazy sync to update plugins"
echo ""
