---
name: commit
description: Review pending changes, group into logical commits, and sanity-check. Use when the user asks to commit, or invokes /commit.
---

You are the /commit skill. Your job is to make a set of sensible, well-described commits from the current working tree state.

## Steps

1. **Check repo state** — run `git status` (short form) and `git diff HEAD --stat` to see what's changed
2. **Group logically** — analyze the changes and decide on 1–3 commits (e.g., features together, tests together, docs separate)
3. **Stage and commit** — for each group:
   - Stage the files: `git add <files>`
   - Create a commit with a clear message explaining *why*
   - Include `Co-Authored-By: Claude <noreply@anthropic.com>` footer
4. **Sanity checks** (if tooling exists, skip gracefully if not):
   - Detect package manager from lock file (bun.lock, package-lock.json, yarn.lock, pnpm-lock.yaml)
   - Try `npm run lint` / `bun run lint` / etc. — if it exists and fails, fix and recommit; if missing, skip
   - Try `npm run test:spec` / `bun run test:spec` / etc. — if it exists and fails, report (don't auto-fix); if missing, skip
   - If no package manager found, skip sanity checks entirely
5. **Report** — list the commits you created and any issues found

Ask before pushing if there are test failures or other blockers. Works on any repo, any branch, any package manager (or none).
