# Dotfiles

My personal configuration files for macOS development setup.

## Installation Order

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Core Tools
```bash
brew install git tmux neovim zsh node
brew install --cask wezterm
```

### 3. Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 4. Install Powerlevel10k Theme
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 5. Clone and Install Dotfiles
```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### 6. Setup Tmux Plugins
```bash
tmux source ~/.tmux.conf
# Then press Ctrl+a + I to install plugins
```

### 7. Launch Neovim (plugins auto-install)
```bash
nvim
```

## Contents

- `nvim/` - Neovim configuration with Lazy plugin manager
- `wezterm/` - WezTerm terminal configuration  
- `tmux.conf` - Tmux configuration with Catppuccin theme
- `zshrc` - Zsh shell configuration with Oh My Zsh
- `p10k.zsh` - Powerlevel10k theme configuration
- `lazygit-config.yml` - Lazygit configuration with improved color contrast

## Custom Keybindings

### Tmux
- **Prefix**: `Ctrl+Space` (instead of default Ctrl+b)
- **Reload config**: `Ctrl+a + r` - Reload tmux configuration
- **Mouse support**: Enabled for pane selection and resizing
- **Vi mode**: Enabled for copy mode navigation

### Neovim
- **Leader key**: `Space`
- **Local leader**: `\`
- **File finder**: `Ctrl+p` - Open Telescope file finder
- **Live grep**: `Space + fg` - Search text across files with Telescope
- **Arrow keys**: Disabled in normal mode (forces hjkl usage)
- **Clipboard**: System clipboard integration enabled

### WezTerm
- No custom keybindings (uses defaults)
- Font: MesloLGS NF (Powerline compatible)
- Theme: Catppuccin Macchiato
