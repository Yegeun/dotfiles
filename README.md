# Dotfiles

My personal configuration files for macOS development setup.

## Quick Start

```bash
# Clone and install (asks about each component)
git clone https://github.com/Yegeun/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install-all-and-symlink.sh
```

Pick what gets installed:

```bash
./install-all-and-symlink.sh              # interactive [Y/n] per component
./install-all-and-symlink.sh --all        # everything, no prompts
./install-all-and-symlink.sh --only nvim,tmux
./install-all-and-symlink.sh --skip wezterm,font
./install-all-and-symlink.sh --list       # show components
```

Components: `core`, `zsh`, `font`, `nvim`, `tmux`, `wezterm`, `lazygit`, `kiro`, `claude`.
Each one installs its binary/app (if needed) *and* runs its `setup-*.sh` symlinking step.

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
cd ~/dotfiles && git pull && ./install-all-and-symlink.sh --all
```
