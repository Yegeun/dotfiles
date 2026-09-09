#!/usr/bin/env bash

set -e

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# -----------------------------------------------------------------------------
# Components
# -----------------------------------------------------------------------------
# Each component is "name|description|needs_brew"
COMPONENTS=(
    "core|Core CLI tools (git, node, uv, fzf, asdf)|1"
    "zsh|Oh My Zsh + Powerlevel10k + ~/.zshrc|0"
    "font|MesloLGS Nerd Font|1"
    "nvim|Neovim + ~/.config/nvim|0"
    "tmux|tmux + ~/.tmux.conf + scripts|1"
    "kitty|kitty + ~/.config/kitty|1"
    "lazygit|lazygit + config|1"
    "kiro|Kiro CLI agents/hooks/skills|0"
    "claude|Claude Code skills|0"
)

comp_name()  { echo "${1%%|*}"; }
comp_desc()  { local r="${1#*|}"; echo "${r%%|*}"; }
comp_brew()  { echo "${1##*|}"; }

ALL_NAMES=()
for c in "${COMPONENTS[@]}"; do ALL_NAMES+=("$(comp_name "$c")"); done

usage() {
    cat <<EOF
Usage: ./install-all-and-symlink.sh [options]

Pick and choose what gets installed/symlinked. With no options it asks
about each component interactively.

Options:
  -a, --all             Install everything, no prompts
  -o, --only a,b,c      Install only these components
  -s, --skip a,b,c      Install everything except these components
  -l, --list            List available components and exit
  -h, --help            Show this help

Components:
EOF
    for c in "${COMPONENTS[@]}"; do
        printf "  %-9s %s\n" "$(comp_name "$c")" "$(comp_desc "$c")"
    done
    echo ""
    echo "Examples:"
    echo "  ./install-all-and-symlink.sh --only nvim,tmux"
    echo "  ./install-all-and-symlink.sh --skip kitty,font"
}

is_valid() {
    local n
    for n in "${ALL_NAMES[@]}"; do [ "$n" = "$1" ] && return 0; done
    return 1
}

# -----------------------------------------------------------------------------
# Parse args
# -----------------------------------------------------------------------------
MODE="interactive"
ONLY_LIST=""
SKIP_LIST=""

while [ $# -gt 0 ]; do
    case "$1" in
        -a|--all)   MODE="all"; shift ;;
        -o|--only)  MODE="only"; ONLY_LIST="$2"; shift 2 ;;
        -s|--skip)  MODE="skip"; SKIP_LIST="$2"; shift 2 ;;
        -l|--list)  usage; exit 0 ;;
        -h|--help)  usage; exit 0 ;;
        *) echo "Unknown option: $1"; echo ""; usage; exit 1 ;;
    esac
done

# -----------------------------------------------------------------------------
# Decide what to install
# -----------------------------------------------------------------------------
SELECTED=()

select_from_list() {
    # $1 = comma separated list, $2 = "include" or "exclude"
    local requested=() name found
    IFS=',' read -ra requested <<< "$1"
    for name in "${requested[@]}"; do
        name="$(echo "$name" | tr -d '[:space:]')"
        [ -z "$name" ] && continue
        if ! is_valid "$name"; then
            echo "❌ Unknown component: $name"
            echo ""
            usage
            exit 1
        fi
    done

    for c in "${ALL_NAMES[@]}"; do
        found=0
        for name in "${requested[@]}"; do
            name="$(echo "$name" | tr -d '[:space:]')"
            [ "$c" = "$name" ] && found=1
        done
        if [ "$2" = "include" ] && [ $found -eq 1 ]; then
            SELECTED+=("$c")
        elif [ "$2" = "exclude" ] && [ $found -eq 0 ]; then
            SELECTED+=("$c")
        fi
    done
}

case "$MODE" in
    all)  SELECTED=("${ALL_NAMES[@]}") ;;
    only) select_from_list "$ONLY_LIST" "include" ;;
    skip) select_from_list "$SKIP_LIST" "exclude" ;;
    interactive)
        if [ ! -t 0 ] && [ ! -e /dev/tty ]; then
            echo "❌ No terminal available for the interactive picker."
            echo "   Use --all, --only a,b or --skip a,b instead."
            exit 1
        fi
        echo "========================================="
        echo "🚀 dotfiles installer"
        echo "========================================="
        echo ""
        echo "Choose what to install (Enter = yes):"
        echo ""
        for c in "${COMPONENTS[@]}"; do
            name="$(comp_name "$c")"
            desc="$(comp_desc "$c")"
            printf "  %-9s %s [Y/n] " "$name" "$desc"
            read -r answer < /dev/tty || answer=""
            case "$answer" in
                [nN]|[nN][oO]) ;;
                *) SELECTED+=("$name") ;;
            esac
        done
        echo ""
        ;;
esac

if [ ${#SELECTED[@]} -eq 0 ]; then
    echo "Nothing selected — exiting."
    exit 0
fi

wants() {
    local n
    for n in "${SELECTED[@]}"; do [ "$n" = "$1" ] && return 0; done
    return 1
}

echo "========================================="
echo "🚀 Installing: ${SELECTED[*]}"
echo "========================================="
echo ""

# -----------------------------------------------------------------------------
# Homebrew (only if a selected component needs it)
# -----------------------------------------------------------------------------
NEEDS_BREW=0
for c in "${COMPONENTS[@]}"; do
    if wants "$(comp_name "$c")" && [ "$(comp_brew "$c")" = "1" ]; then
        NEEDS_BREW=1
    fi
done

if [ $NEEDS_BREW -eq 1 ]; then
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
fi

brew_install_tool() {
    local tool="$1"
    if ! command -v "$tool" &> /dev/null; then
        echo "  Installing $tool..."
        brew install "$tool"
    else
        echo "  ✓ $tool already installed"
    fi
}

# -----------------------------------------------------------------------------
# core
# -----------------------------------------------------------------------------
if wants core; then
    echo "🛠️  Installing core tools..."
    for tool in git node uv fzf asdf; do
        brew_install_tool "$tool"
    done
    echo "✓ Core tools ready"
    echo ""
fi

# -----------------------------------------------------------------------------
# font
# -----------------------------------------------------------------------------
if wants font; then
    if ! ls ~/Library/Fonts/MesloLGS* &> /dev/null && ! ls /Library/Fonts/MesloLGS* &> /dev/null; then
        echo "🔤 Installing MesloLGS Nerd Font..."
        brew install --cask font-meslo-lg-nerd-font
        echo "✓ MesloLGS Nerd Font installed"
    else
        echo "✓ MesloLGS Nerd Font already installed"
    fi
    echo ""
fi

# -----------------------------------------------------------------------------
# zsh (oh-my-zsh + powerlevel10k + symlinks)
# -----------------------------------------------------------------------------
if wants zsh; then
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "🐚 Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        echo "✓ Oh My Zsh installed"
    else
        echo "✓ Oh My Zsh already installed"
    fi

    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        echo "⚡ Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        echo "✓ Powerlevel10k installed"
    else
        echo "✓ Powerlevel10k already installed"
    fi
    echo ""

    bash setup-zsh.sh
    echo ""
fi

# -----------------------------------------------------------------------------
# nvim
# -----------------------------------------------------------------------------
if wants nvim; then
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
        cd "$DOTFILES_DIR"
        echo "✓ Neovim v${NVIM_VERSION} installed"
    else
        echo "✓ Neovim already installed"
    fi
    echo ""

    bash setup-nvim.sh
    echo ""
fi

# -----------------------------------------------------------------------------
# tmux
# -----------------------------------------------------------------------------
if wants tmux; then
    echo "🛠️  Installing tmux..."
    brew_install_tool tmux
    echo ""

    bash setup-tmux.sh
    echo ""
fi

# -----------------------------------------------------------------------------
# kitty
# -----------------------------------------------------------------------------
if wants kitty; then
    if ! [ -d "/Applications/kitty.app" ]; then
        echo "🖥️  Installing kitty..."
        brew install --cask kitty
        echo "✓ kitty installed"
    else
        echo "✓ kitty already installed"
    fi
    echo ""

    bash setup-kitty.sh
    echo ""
fi

# -----------------------------------------------------------------------------
# lazygit
# -----------------------------------------------------------------------------
if wants lazygit; then
    echo "🛠️  Installing lazygit..."
    brew_install_tool lazygit
    brew link --overwrite lazygit 2>/dev/null || true
    echo ""

    bash setup-lazygit.sh
    echo ""
fi

# -----------------------------------------------------------------------------
# kiro / claude (symlinks only)
# -----------------------------------------------------------------------------
if wants kiro; then
    bash setup-kiro.sh
    echo ""
fi

if wants claude; then
    bash setup-claude.sh
    echo ""
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo "========================================="
echo "✨ Installation complete!"
echo "========================================="
echo ""
echo "Installed: ${SELECTED[*]}"
echo ""
echo "Next steps:"
if wants zsh; then
    echo "- Restart your terminal or run: source ~/.zshrc"
    echo "- Configure Powerlevel10k by running: p10k configure"
fi
if wants tmux; then
    echo "- Open tmux and press backtick + I to install tmux plugins"
fi
if wants nvim; then
    echo "- Open nvim - plugins will auto-install on first launch"
fi
echo ""
