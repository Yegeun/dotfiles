# Neovim Keybindings

Leader key: `Space`

## General

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>e` | Toggle file explorer |

## Find (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |

## Code (LSP)

| Key | Action |
|-----|--------|
| `<leader>cf` | Format buffer |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

## Harpoon (Quick File Navigation)

| Key | Action |
|-----|--------|
| `<leader>a` | Add file to harpoon |
| `<leader>h` | Open harpoon menu |
| `<leader>1-4` | Jump to harpoon file 1-4 |
| `<leader>[` | Previous harpoon file |
| `<leader>]` | Next harpoon file |

## Debug (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Eval (normal/visual) |

## Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |

## Tmux Integration

| Key | Action |
|-----|--------|
| `<leader>r` | Run current file in tmux pane |
| `Ctrl+h/j/k/l` | Navigate between vim/tmux panes |

## Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `Tab` | Next item / snippet forward |
| `Shift+Tab` | Previous item / snippet backward |
| `Enter` | Confirm selection |
| `Ctrl+Space` | Toggle completion/docs |
| `Ctrl+e` | Close completion menu |
| `Ctrl+b/f` | Scroll documentation |

## Plugins

- **lazy.nvim** - Plugin manager
- **telescope.nvim** - Fuzzy finder
- **nvim-tree** - File explorer
- **harpoon** - Quick file navigation
- **lualine** - Status line (dracula theme)
- **catppuccin** - Color scheme
- **treesitter** - Syntax highlighting
- **mason.nvim** - LSP/tool installer
- **nvim-lspconfig** - LSP configuration
- **lazydev.nvim** - Lua/Neovim API completion
- **blink.cmp** - Autocompletion (fast, Rust-powered)
- **conform.nvim** - Formatting
- **nvim-lint** - Linting
- **nvim-dap** - Debug Adapter Protocol
- **nvim-dap-ui** - Debugger UI
- **nvim-dap-virtual-text** - Inline variable values
- **mason-nvim-dap** - Auto-install debug adapters
- **lazygit.nvim** - Git integration
- **which-key** - Keybinding hints
