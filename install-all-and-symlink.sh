#!/usr/bin/env bash

set -e

echo "========================================="
echo "🚀 Installing dotfiles..."
echo "========================================="
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    echo "✓ Homebrew installed"
else
    echo "✓ Homebrew already installed"
fi
echo ""

# Install core tools
echo "🛠️  Installing core tools..."
brew install git node tmux lazygit uv
brew install --cask wezterm
echo "✓ Core tools installed"
echo ""

# Install Neovim from GitHub releases
if ! command -v nvim &> /dev/null; then
    echo "📦 Installing Neovim from GitHub..."
    NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')

    if [[ $(uname -m) == "arm64" ]]; then
        NVIM_ARCH="arm64"
    else
        NVIM_ARCH="x86_64"
    fi

    cd /tmp
    curl -LO "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-macos-${NVIM_ARCH}.tar.gz"
    tar xzf nvim-macos-${NVIM_ARCH}.tar.gz
    sudo mv nvim-macos-${NVIM_ARCH} /opt/nvim
    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    rm nvim-macos-${NVIM_ARCH}.tar.gz
    cd - > /dev/null
    echo "✓ Neovim v${NVIM_VERSION} installed"
else
    echo "✓ Neovim already installed"
fi
echo ""

# Install Nerd Font
echo "🔤 Installing MesloLGS Nerd Font..."
brew install --cask font-meslo-lg-nerd-font
echo "✓ MesloLGS Nerd Font installed"
echo ""

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🐚 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✓ Oh My Zsh installed"
else
    echo "✓ Oh My Zsh already installed"
fi
echo ""

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "⚡ Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "✓ Powerlevel10k installed"
else
    echo "✓ Powerlevel10k already installed"
fi
echo ""

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Run individual setup scripts
echo "========================================="
echo "📝 Setting up individual tools..."
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

echo "========================================="
echo "✨ Installation complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Open tmux and press Ctrl-a + I to install tmux plugins"
echo "3. Open nvim - plugins will auto-install on first launch"
echo "4. Configure Powerlevel10k by running: p10k configure"
echo ""
