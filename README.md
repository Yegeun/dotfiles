# Dotfiles

My personal configuration files for macOS development setup.

## Fresh Install

```bash
# Clone the repo
git clone https://github.com/Yegeun/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles
chmod +x install-all-and-symlink.sh
./install-all-and-symlink.sh
```

The install script will:
- Install Homebrew (if not installed)
- Install core tools (git, node, tmux, lazygit, uv, fzf, wezterm)
- Install Neovim from GitHub releases
- Install MesloLGS Nerd Font
- Install Oh My Zsh and Powerlevel10k theme
- Install TPM and tmux plugins
- Create all necessary symlinks

### After Install

1. **Restart your terminal** or run `source ~/.zshrc`
2. **Open tmux** and press `Ctrl+a + I` to install any remaining plugins
3. **Open nvim** - plugins will auto-install on first launch
4. **Configure Powerlevel10k** by running `p10k configure` (optional)

## Update

To pull the latest changes and re-run setup:

```bash
cd ~/dotfiles
git pull
./install-all-and-symlink.sh
```

The install script is idempotent - it will skip already installed components and only update symlinks.

## Contents

- `nvim/` - Neovim configuration with Lazy plugin manager
- `wezterm/` - WezTerm terminal configuration
- `tmux.conf` - Tmux configuration with Catppuccin theme
- `tmux-sessionizer` - Fuzzy session manager for tmux
- `zshrc` - Zsh shell configuration with Oh My Zsh and fzf
- `p10k.zsh` - Powerlevel10k theme configuration
- `lazygit-config.yml` - Lazygit configuration

## Keybindings

### Tmux

| Key | Action |
|-----|--------|
| `Ctrl+a` | Prefix (instead of Ctrl+b) |
| `Prefix + R` | Reload tmux config |
| `Prefix + r` | Rename current window |
| `Prefix + f` | Open tmux-sessionizer (fuzzy project switcher) |
| `Prefix + I` | Install tmux plugins |
| `Prefix + \|` | Split pane horizontally |
| `Prefix + -` | Split pane vertically |
| `Ctrl+h/j/k/l` | Navigate between panes (vim-style) |

### Shell (fzf)

| Key | Action |
|-----|--------|
| `Ctrl+R` | Fuzzy search command history |
| `Ctrl+T` | Fuzzy search files |
| `Alt+C` | Fuzzy cd into directories |

### Neovim

| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `Ctrl+p` | Open Telescope file finder |
| `Space + fg` | Live grep (search text across files) |
| `Space + r` | Run current file in adjacent tmux pane |

### tmux-sessionizer

| Key | Action |
|-----|--------|
| Type name | Select existing project or create new one in `~/Developer/` |
| `new:name` | Explicitly create new project folder |

## Tmux Plugins

- **tpm** - Tmux Plugin Manager
- **tmux-sensible** - Sensible defaults
- **vim-tmux-navigator** - Seamless vim/tmux navigation
- **catppuccin/tmux** - Catppuccin theme
- **tmux-resurrect** - Save/restore tmux sessions
- **tmux-continuum** - Auto-save sessions every 15 minutes
