---
name: pr-description
description: Generate a PR description changelog. Use when writing pull request descriptions, changelogs, or summarising git changes for review.
---

## Template

Write PR descriptions in Markdown format. Always use this structure:

```
# Overview
A brief summary of what this PR does and why.

## Added
- item

## Changed
- item

## Fixed
- item

## Removed
- item
```

## Guidelines

- Use # for Overview heading and ## for Added, Changed, Fixed, Removed headings.
- Use dashes (-) as bullet points.
- If a section has no entries, write "N/A".
- Reference files and code using markdown backticks (e.g. `_cases_list.html.haml`, `User#gravatar`).
- Do not use bold or italic formatting. Only use backticks for file/code references.
- Added: Only list genuinely new functionality.
- Changed: Include config changes, schema updates, refactors, and UI tweaks.
- Fixed: Include bug fixes and corrections.
- Removed: Group by feature when multiple related files are deleted. List key files.
- Do not use AI-style language (e.g. "This PR introduces...", "Leveraging..."). Write plainly.
- Keep it short and factual.
- Output the entire PR description inside a code block so the markdown can be copied raw.

## How to Generate

1. Get the full diff against main: `git diff main --stat` and `git diff main`
2. Check current unstaged/staged changes: `git status --short`
3. Fill in each section based on what was actually done
4. Group related deletions by feature name
5. Keep entries concise with file paths where helpful
