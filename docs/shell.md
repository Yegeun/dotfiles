# Shell (Zsh) Configuration

## Aliases

| Alias | Command |
|-------|---------|
| `zshconfig` | Edit ~/.zshrc in nvim |
| `lg` | lazygit |
| `t` | tmux-sessionizer |
| `ta` | tmux attach |
| `tn` | tmux new-session |
| `updatenotes` | Sync cs-notes vault |

## fzf Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+R` | Fuzzy search command history |
| `Ctrl+T` | Fuzzy search files |
| `Alt+C` | Fuzzy cd into directories |

## Prompt (Powerlevel10k)

The prompt shows:

**Left side:**
- Directory path
- Git status
- Python project indicator (when in uv project)

**Right side:**
- Exit status (on error)
- Command execution time (if > 3s)
- Background jobs
- Time

## uv (Python)

Using uv doesn't require activating venvs. Just use:

```bash
uv add requests      # Add dependency
uv run python app.py # Run in venv
uv run pytest        # Run tests
```

The prompt shows ` projectname` when you're in a directory with `pyproject.toml`.

## Lazy-loaded Tools

These tools are lazy-loaded to speed up shell startup:

- **rbenv** - Ruby version manager
- **nvm** - Node version manager
