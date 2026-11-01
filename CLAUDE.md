# CLAUDE.md — dotfiles

Personal macOS dev environment config. Not an app — no build, no tests, no dependencies to install for "the project" itself; running code here means shell scripts that symlink config into `$HOME`.

## What this repo is

`~/dotfiles` is the source of truth for config; the actual tool config paths (`~/.zshrc`, `~/.config/nvim`, `~/.tmux.conf`, `~/.claude/skills/*`, `~/.kiro/*`, etc.) are **symlinks pointing back into this repo**. Editing a symlinked file anywhere edits the tracked file here — that's intentional, not a bug.

## Layout

| Path | Purpose |
|---|---|
| `install-all-and-symlink.sh` | Setup entry point — component picker (interactive by default; `--all` / `--only a,b` / `--skip a,b` / `--list`). Each component installs its binaries and runs its `setup-*.sh`. Homebrew is only installed if a selected component needs it. Add a new component to the `COMPONENTS` array + its own `if wants <name>` block. |
| `setup-*.sh` | Per-tool setup — each `mkdir -p`s the real config dir and `ln -sf`s from this repo into it |
| `zshrc`, `p10k.zsh` | Zsh (oh-my-zsh) + Powerlevel10k, symlinked via `setup-zsh.sh` |
| `nvim/` | Neovim config (lazy.nvim), symlinked via `setup-nvim.sh` |
| `tmux.conf`, `tmux-sessionizer`, `tmux-command-menu` | Tmux config + scripts, via `setup-tmux.sh` |
| `kitty/` | Terminal config (`kitty.conf` + the Catppuccin Macchiato palette it `include`s), via `setup-kitty.sh`. `term` is pinned to `xterm-256color` rather than kitty's `xterm-kitty` default, because `tmux.conf` matches that exact name to enable RGB truecolor |
| `lazygit-config.yml` | via `setup-lazygit.sh` |
| `filetypes/` | Finder default-app routing, via `setup-filetypes.sh` — builds `~/Applications/Open in Neovim.app` and makes it the default for every extension in `filetypes/extensions`. `filetypes/open-file` sends files inside an Xcode project to Xcode and the rest to nvim in a new kitty window. Swift and Objective-C are pinned to Xcode everywhere (`XCODE_EXTENSIONS` in the setup script). Edits to `open-file` apply immediately; edits to `extensions` need the setup script re-run |
| `kiro/` | Kiro CLI agents/hooks/skills, via `setup-kiro.sh` — symlinked into `~/.kiro/` |
| `claude/skills/<name>/SKILL.md` | Claude Code skills, via `setup-claude.sh` — symlinked into `~/.claude/skills/<name>/SKILL.md` |
| `routines/`, `setup-routines.sh` | Morning launchd jobs. `routines/jobs` is the index, one line per job. Each job's code and plist stay in its own repo; `setup-routines.sh` finds that repo, pulls it and runs its install script, but never clones it. `routines/status` is the `routines` command and flags any `com.yegeun.*` job not in the index, so add a line there for every new job. **This repo is public: never add private repo names, clone URLs or vault content.** That is why the vault is found by a `Vault/*` pattern and not named. Human guide: `docs/routines.md` |
| `docs/` | Deeper reference for neovim/tmux/shell/routines (keybindings etc.) |

## Adding a new symlinked skill/config

1. Put the real file under the matching source dir here (e.g. `claude/skills/<name>/SKILL.md`, `kiro/skills/<name>/SKILL.md`).
2. Make sure the tool's `setup-*.sh` picks it up — `setup-claude.sh` already loops over every dir in `claude/skills/*`, so a new Claude skill needs no script changes, just the folder. Other tools' scripts may need an explicit new `ln -sf` line (check `setup-kiro.sh` for the pattern).
3. Re-run that one `setup-*.sh` (or the full `install-all-and-symlink.sh`) to (re)create the symlink.
4. Never edit the `~/.foo` symlinked path expecting it to be gitignored-local — it's the same file as the one in this repo.

## Conventions

- Idempotent setup scripts: every `setup-*.sh` and the tool-install steps in `install-all-and-symlink.sh` check before installing/symlinking so re-running is always safe.
- Symlink individual files, not whole directories, when a target dir might also hold non-dotfiles-managed content (see `setup-kiro.sh`, `setup-claude.sh`).
- `README.md` is the human-facing quick start; this file is the map for Claude.
