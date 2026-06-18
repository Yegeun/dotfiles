#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Kiro CLI configuration..."

# Create .kiro directories
mkdir -p "${HOME}/.kiro/agents"
mkdir -p "${HOME}/.kiro/hooks"
mkdir -p "${HOME}/.kiro/skills/pr-description"

# Symlink agents
ln -sf "${DOTFILES_DIR}/kiro/agents/default.json" "${HOME}/.kiro/agents/default.json"

# Symlink hooks
ln -sf "${DOTFILES_DIR}/kiro/hooks/rubocop-fix.sh" "${HOME}/.kiro/hooks/rubocop-fix.sh"

# Symlink skills
ln -sf "${DOTFILES_DIR}/kiro/skills/pr-description/SKILL.md" "${HOME}/.kiro/skills/pr-description/SKILL.md"

echo "✓ Kiro CLI setup complete!"
