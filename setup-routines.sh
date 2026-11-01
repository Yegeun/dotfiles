#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOTFILES_DIR}/routines/lib.sh"

echo "Setting up morning routines..."

failed=0

# Stdin stays free on fd 0: git and ssh read it and would swallow the list.
while IFS='|' read -r label folders script args log what <&3; do
    case "$label" in ''|'#'*) continue ;; esac

    if ! repo="$(find_repo "$folders" "$script")"; then
        echo "  ❌ ${label}: no repo in ~/${folders}. Clone it there by hand, then re-run (docs/routines.md)."
        failed=1
        continue
    fi

    if [ -n "$(git -C "$repo" status --porcelain)" ]; then
        echo "  ⚠️  ${repo} has local changes, so it was not pulled"
    else
        git -C "$repo" pull --ff-only --quiet || echo "  ⚠️  Could not pull ${repo}, using what is here"
    fi

    # args is one word or none, so it is left unquoted
    if ! (cd "$repo" && bash "$script" $args); then
        echo "  ❌ ${label} did not install"
        failed=1
    fi
done 3< "${DOTFILES_DIR}/routines/jobs"

if [ ! -x "${HOME}/.local/bin/claude" ]; then
    echo "  ⚠️  Claude Code is not installed, so the feed will have no summaries. See docs/routines.md."
fi

# The scripts follow the vault wherever it is, but the skills' SKILL.md files name this path
if [ "$HOME" != "/Users/yegeunji" ]; then
    echo "  ⚠️  This account's home is ${HOME}, and the vault's SKILL.md files say /Users/yegeunji. Update them."
fi

if [ "$failed" -ne 0 ]; then
    echo "⚠️  Morning routines are only partly set up. Run ~/dotfiles/routines/status to see what is missing."
    exit 1
fi

echo "✓ Morning routines setup complete! Check them with: routines"
