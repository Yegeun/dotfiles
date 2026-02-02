#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up tmux configuration..."

# Install prerequisites if not already installed
for tool in tmux fzf; do
    if ! command -v $tool &> /dev/null; then
        echo "  Installing $tool..."
        brew install $tool
    fi
done

# Link tmux config
ln -sf "${DOTFILES_DIR}/tmux.conf" "${HOME}/.tmux.conf"
echo "  ✓ Linked tmux.conf"

# Link tmux-sessionizer
mkdir -p "${HOME}/.local/bin"
ln -sf "${DOTFILES_DIR}/tmux-sessionizer" "${HOME}/.local/bin/tmux-sessionizer"
chmod +x "${DOTFILES_DIR}/tmux-sessionizer"
echo "  ✓ Linked tmux-sessionizer"

# Link tmux-command-menu
ln -sf "${DOTFILES_DIR}/tmux-command-menu" "${HOME}/.local/bin/tmux-command-menu"
chmod +x "${DOTFILES_DIR}/tmux-command-menu"
echo "  ✓ Linked tmux-command-menu"

# Install TPM if not already installed
if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
    echo "  ✓ Installed TPM"
else
    echo "  ✓ TPM already installed"
fi

# Install tmux plugins
echo "  Installing tmux plugins..."
plugins=(
    "tmux-plugins/tmux-cpu"
    "tmux-plugins/tmux-battery"
    "catppuccin/tmux"
    "christoomey/vim-tmux-navigator"
    "tmux-plugins/tmux-sensible"
    "jimeh/tmuxifier"
    "tmux-plugins/tmux-resurrect"
    "tmux-plugins/tmux-continuum"
)

for plugin in "${plugins[@]}"; do
    plugin_name=$(basename "$plugin")
    plugin_dir="${HOME}/.tmux/plugins/${plugin_name}"
    if [ ! -d "$plugin_dir" ]; then
        git clone "https://github.com/${plugin}" "$plugin_dir"
        echo "    ✓ Installed ${plugin_name}"
    else
        echo "    ✓ ${plugin_name} already installed"
    fi
done

echo "✓ Tmux setup complete!"
