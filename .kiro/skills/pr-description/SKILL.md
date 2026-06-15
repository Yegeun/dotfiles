---
name: pr-description
description: Generate a PR description changelog. Use when writing pull request descriptions, changelogs, or summarising git changes for review.
---

## Template

Always use this format for PR descriptions:

```
# Overview
A brief summary of what this PR does and why.

## Added
List new features, files, or capabilities introduced.

## Changed
List modifications to existing functionality, config, or structure.

## Fixed
List bug fixes or corrections.

## Removed
List deleted features, files, or deprecated code that was cleaned up.
```

## Guidelines

- Overview: One or two sentences explaining the purpose and motivation of the PR.
- Added: Only list genuinely new functionality. Write "Nothing added." if none.
- Changed: Include config changes, schema updates, refactors, and UI tweaks.
- Fixed: Include bug fixes and corrections. Write "Nothing fixed." if none.
- Removed: Group by feature when multiple related files are deleted. List key files.
- Do not use bold, italic, or any styled/coloured text formatting.
- Do not use AI-style language (e.g. "This PR introduces...", "Leveraging..."). Write plainly.
- Do not use dashes (-) as bullet points in the output. Use plain lines or numbered lists.
- Keep it short and factual.

## How to Generate

1. Get the full diff against main: `git diff main --stat` and `git diff main`
2. Check current unstaged/staged changes: `git status --short`
3. Fill in each section based on what was actually done
4. Group related deletions by feature name
5. Keep entries concise with file paths where helpful
