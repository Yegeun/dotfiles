# Tmux Keybindings

Prefix key: `` ` `` (backtick)

## General

| Key | Action |
|-----|--------|
| `` ` `` | Prefix key |
| `Prefix + R` | Reload tmux config |
| `Prefix + r` | Rename current window |
| `Prefix + :` | Command menu (popup) |
| `Prefix + f` | Session manager (popup) |

## Panes

| Key | Action |
|-----|--------|
| `Prefix + \|` | Split horizontal |
| `Prefix + -` | Split vertical |
| `Ctrl+h` | Move to left pane |
| `Ctrl+j` | Move to down pane |
| `Ctrl+k` | Move to up pane |
| `Ctrl+l` | Move to right pane |

## Copy Mode (vim-style)

| Key | Action |
|-----|--------|
| `Prefix + [` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl+v` | Rectangle selection |
| `y` | Copy selection |

## Plugins

- **tpm** - Plugin manager
- **tmux-sensible** - Sensible defaults
- **vim-tmux-navigator** - Seamless vim/tmux navigation
- **catppuccin/tmux** - Theme (macchiato flavor)
- **tmux-resurrect** - Save/restore sessions
- **tmux-continuum** - Auto-save every 15 minutes

## tmux-sessionizer

Open with `Prefix + f`

| Input | Action |
|-------|--------|
| Select project | Switch to existing session |
| Type name | Create new session in `~/Developer/` |
| `new:name` | Create new folder + session |
| `uvnew:name` | Create Python project with `uv init` |
| `uvtddnew:name` | Create TDD Python project (see below) |

### uvtddnew: creates

```
project/
├── pyproject.toml
├── conftest.py          # Adds src/ to PYTHONPATH
├── src/
│   └── project/
│       ├── __init__.py
│       └── main.py      # Your code here
└── tests/
    ├── __init__.py
    └── test_main.py     # Example test
```

- Runs `uv init` and removes root main.py
- Installs `pytest` as dev dependency
- Creates src layout with main.py
- Sets up PYTHONPATH via conftest.py
- Run tests: `uv run pytest`
- Run main: `uv run python -m project.main`

## tmux-command-menu

Open with `Prefix + :`

Shows all available tmux keybindings in a searchable popup.
