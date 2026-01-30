# Dotfiles

My personal configuration files for macOS development setup.

## Quick Start

```bash
# Clone and install
git clone https://github.com/Yegeun/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install-all-and-symlink.sh
```

## After Install

1. Restart terminal or `source ~/.zshrc`
2. Open tmux → `` ` + I `` to install plugins
3. Open nvim → plugins auto-install

## Documentation

| Doc | Contents |
|-----|----------|
| [Neovim](docs/neovim.md) | LSP, keybindings, plugins |
| [Tmux](docs/tmux.md) | Sessions, panes, shortcuts |
| [Shell](docs/shell.md) | Aliases, fzf, prompt |

## Quick Reference

### Neovim (`<Space>` = leader)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>cf` | Format |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename |
| `<leader>e` | File explorer |
| `<leader>gg` | LazyGit |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Debug continue |
| `<leader>du` | Debug UI |

### Tmux (`` ` `` = prefix)

| Key | Action |
|-----|--------|
| `Prefix + f` | Session manager |
| `Prefix + :` | Command menu |
| `Prefix + \|` | Split horizontal |
| `Prefix + -` | Split vertical |
| `Ctrl+h/j/k/l` | Navigate panes |

### Shell

| Key | Action |
|-----|--------|
| `Ctrl+R` | Search history |
| `Ctrl+T` | Search files |
| `t` | tmux-sessionizer |
| `lg` | lazygit |

## Contents

```
dotfiles/
├── nvim/           # Neovim config (lazy.nvim)
├── docs/           # Documentation
├── tmux.conf       # Tmux config (catppuccin)
├── tmux-sessionizer
├── tmux-command-menu
├── zshrc           # Zsh config (oh-my-zsh)
├── p10k.zsh        # Powerlevel10k theme
├── wezterm/        # Terminal config
└── lazygit-config.yml
```

## Update

```bash
cd ~/dotfiles && git pull && ./install-all-and-symlink.sh
```
