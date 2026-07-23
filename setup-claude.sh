#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Claude Code configuration..."

# Symlink skills — each skill is a directory containing SKILL.md
for skill_dir in "${DOTFILES_DIR}"/claude/skills/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    mkdir -p "${HOME}/.claude/skills/${skill_name}"
    ln -sf "${DOTFILES_DIR}/claude/skills/${skill_name}/SKILL.md" "${HOME}/.claude/skills/${skill_name}/SKILL.md"
done

echo "✓ Claude Code setup complete!"
